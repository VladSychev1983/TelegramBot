import random
from telebot import telebot, types, custom_filters
from telebot.storage import StateMemoryStorage
from telebot.handler_backends import State, StatesGroup
from settings import TOKEN
import sqlalchemy
from sqlalchemy import insert
from sqlalchemy.orm import sessionmaker
from sqlalchemy.orm import aliased
from sqlalchemy.sql import func
from sqlalchemy import insert
from models import English_Words,Russian_Words,Chats,History,Translation,create_talbes,User_Words
from settings import DBNAME,DBHOST,DBPASSWORD,DBPORT,DBUSER
from datetime import datetime

DSN = f"postgresql://{DBUSER}:{DBPASSWORD}@{DBHOST}:{DBPORT}/{DBNAME}"
engine = sqlalchemy.create_engine(DSN, echo=True)
create_talbes(engine)

Session = sessionmaker(bind=engine)
session = Session()

bot = telebot.TeleBot(TOKEN)
state_storage = StateMemoryStorage()

class Command:
    ADD_WORD = 'Добавить слово ➕'
    DELETE_WORD = 'Удалить слово🔙'
    NEXT = 'Дальше ⏭'

@bot.message_handler(commands=['help','start'])
def send_welcome(message):
    bot.reply_to(message, """
Привет 👋 Давай попрактикуемся в английском языке. Тренировки можешь проходить в удобном для себя темпе.
""")
    chat_id = write_chat(message)                                            
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
    target_word, translate = ('','')
    keybord_words = []
    
    ru = aliased(Russian_Words)
    en = aliased(English_Words)
    trans = aliased(Translation)

    query_get_words  = session.query(en, trans, ru).\
        join(trans, en.word_id == trans.en_word_id ).\
        join(ru, trans.ru_word_id == ru.word_id).\
        order_by(func.random()).limit(1).all()
    for en,trans,ru in query_get_words:
        target_word =  en.word
        translate = ru.word
        keybord_words.append(target_word)
    session.commit()

    query_other_words = session.query(English_Words.word).\
        filter(English_Words.word != target_word).\
            order_by(func.random()).limit(3)
    
    keybord_words.extend([en.word for en in query_other_words])
    print(keybord_words)
    session.commit()

    markup = create_buttons(keybord_words)

    greeting = f"Выбери перевод слова:\n🇷🇺 {translate}"
    bot.send_message(message.chat.id, greeting, reply_markup=markup)
    bot.register_next_step_handler(message, check_answer, target_word,translate,markup)

def create_buttons(word_list):
    buttons = []
    markup = types.ReplyKeyboardMarkup(row_width=2)
    buttons = [types.KeyboardButton(word) for word in word_list]
    random.shuffle(buttons)
    buttons.extend(mylist := [types.KeyboardButton(getattr(Command,x)) for x in dir(Command)[0:3]])   
    markup.add(*buttons)
    return markup

def check_answer(message,target_word,translate,markup):
    hint = ""
    if message.text == target_word:
        hint = f"Отлично!❤"
        bot.send_message(message.chat.id, hint, reply_markup=markup)
        get_words(message)
        return
    elif message.text == Command.NEXT:
        next_word(message)
    elif message.text == Command.ADD_WORD:
        hint = f"""Для добавления нового слова введите слово и перевод 
        через пробел. пример: Любовь Love"""
        bot.send_message(message.chat.id, hint, reply_markup=markup)
        bot.register_next_step_handler(message, add_word, markup)
    elif message.text == Command.DELETE_WORD:
        hint = f"""Для удаления слова введите слово. пример: Война"""
        bot.send_message(message.chat.id, hint, reply_markup=markup)
        bot.register_next_step_handler(message, del_word, markup)
    else:
        hint = f"Допущена ошибка! Попробуй ещё раз вспомнить слово 🇷🇺 {translate}!"
        bot.register_next_step_handler(message, check_answer, target_word,translate,markup)
        bot.send_message(message.chat.id, hint, reply_markup=markup)

@bot.message_handler(func=lambda message: message.text == Command.NEXT)
def next_word(message):
    get_words(message)

@bot.message_handler(func=lambda message: message.text == Command.ADD_WORD)
def add_word(message, markup):
    splitted_str = message.text
    russian_word, english_word = str(splitted_str).split(' ')
    print(f'New word ru: {russian_word} en: {english_word}')
    current_datetime = datetime.now()
    insert_query = User_Words(chat_id=message.chat.id, ru_word=russian_word, en_word=english_word, created_at=current_datetime)
    session.add(insert_query)
    session.commit()
    bot.send_message(message.chat.id, f"Слово {russian_word} успешно сохранено!", reply_markup=markup)
    get_words(message)

@bot.message_handler(func=lambda message: message.text == Command.DELETE_WORD)
def del_word(message, markup):
    delete_word = message.text
    delete_query = session.query(User_Words).filter(User_Words.ru_word == delete_word).delete()
    session.commit()
    bot.send_message(message.chat.id, f"Слово {delete_word} успешно удалено!", reply_markup=markup)
    get_words(message)

session.close()
   
if __name__ == '__main__':
    print('Бот запущен...')
    print('Для завершения нажмите Ctrl+C')
    #bot.enable_save_next_step_handlers(delay=2)
    #bot.load_next_step_handlers()
    bot.polling()