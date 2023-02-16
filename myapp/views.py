from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
import telegram
from telegram.ext import Updater, CommandHandler

def start(update, context):
    context.bot.send_message(chat_id=update.effective_chat.id, text="Hello, world!")

@csrf_exempt
def webhook(request):
    if request.method == 'POST':
        update = telegram.Update.de_json(request.body, telegram.Bot(token=os.environ['TOKEN']))
        dispatcher.process_update(update)
    return HttpResponse('ok')

updater = Updater(token=os.environ['TOKEN'], use_context=True)
dispatcher = updater.dispatcher
start_handler = CommandHandler('start', start)
dispatcher.add_handler(start_handler)
