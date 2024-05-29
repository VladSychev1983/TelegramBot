import requests
import telebot
from settings import TOKEN

bot = telebot.TeleBot(TOKEN)

@bot.message_handler(commands=['help','start'])
def send_welcome(message):
    bot.reply_to(message, """
Привет 👋 Давай попрактикуемся в английском языке. Тренировки можешь проходить в удобном для себя темпе.
""")
    cid = message.chat.id
    print(f"connected chat_id: {cid}")
    
if __name__ == '__main__':
    print('Бот запущен...')
    print('Для завершения нажмите Ctrl+Z')
    bot.polling()