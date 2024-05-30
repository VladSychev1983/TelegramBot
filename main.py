import random
from telebot import telebot, types, custom_filters
from telebot.storage import StateMemoryStorage
from telebot.handler_backends import State, StatesGroup
from settings import TOKEN
import sqlalchemy
from sqlalchemy import insert
from sqlalchemy.orm import sessionmaker
from sqlalchemy.orm import aliased
from models import English_Words,Russian_Words,Chats,History,Translation,create_talbes
from settings import DBNAME,DBHOST,DBPASSWORD,DBPORT,DBUSER

DSN = f"postgresql://{DBUSER}:{DBPASSWORD}@{DBHOST}:{DBPORT}/{DBNAME}"
engine = sqlalchemy.create_engine(DSN)
create_talbes(engine)

Session = sessionmaker(bind=engine)
session = Session()

bot = telebot.TeleBot(TOKEN)
state_storage = StateMemoryStorage()

@bot.message_handler(commands=['help','start'])
def send_welcome(message):
    bot.reply_to(message, """
Привет 👋 Давай попрактикуемся в английском языке. Тренировки можешь проходить в удобном для себя темпе.
""")
    #bot.register_next_step_handler(message, write_chat)     # <-- write new chat here.
    chat_id = write_chat(message)
    print(chat_id)
    #bot.register_next_step_handler(message, get_words)                                            
    get_words(message)                                                      
                                                          
def write_chat(message):
    cid = message.chat.id
    print(f"connected chat_id: {cid}")
    check_user = session.query(Chats).filter_by(chat_id=cid).first() 
    if val := (check_user):
        if isinstance(val.chat_id, int):
             print(f"found cid in pg: {val.chat_id}")
             return val.chat_id
    else:
        print(f'writting new chat: {cid}..')
        new_user = session.scalar(insert(Chats).returning(Chats.chat_id), [{"chat_id" : cid}])
        session.commit()
        return new_user
    
def get_words(message):
    buttons = []
    target_word = 'Peace'
    translate = "Мир"
    markup = types.ReplyKeyboardMarkup(row_width=2)
    target_word_btn = types.KeyboardButton(target_word)
    buttons.append(target_word_btn)
    markup.add(*buttons)

    greeting = f"Выбери перевод слова:\n🇷🇺 {translate}"
    bot.send_message(message.chat.id, greeting, reply_markup=markup)
    bot.register_next_step_handler(message, check_answer, target_word,translate,markup) 

def check_answer(message,target_word,translate,markup):
    hint = ""
    if message.text == target_word:
        hint = f"Отлично!❤"
        bot.send_message(message.chat.id, hint, reply_markup=markup)
        get_words(message)
        return
    else:
        hint = f"Допущена ошибка! Попробуй ещё раз вспомнить слово 🇷🇺 {translate}!"
        bot.register_next_step_handler(message, check_answer, target_word,translate,markup)
        bot.send_message(message.chat.id, hint, reply_markup=markup)
    
session.close()
   
if __name__ == '__main__':
    print('Бот запущен...')
    print('Для завершения нажмите Ctrl+C')
    bot.polling()

"""
простой select в базу
check_user = session.query(Chats).filter_by(chat_id=cid).first()

простой insert в базу.
new_user = Chats(chat_id=cid)       # <-- insert new user
session.add(new_user)
"""