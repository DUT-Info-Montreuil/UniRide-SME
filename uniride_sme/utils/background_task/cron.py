import threading
from time import sleep

import schedule

from uniride_sme.service import admin_service

thread_event = threading.Event()


def background_task():
    while thread_event.is_set():
        schedule.every().day.at("00:00").do(admin_service.send_mail_expiration_and_update_insurance)
        schedule.run_pending()
        sleep(30)
