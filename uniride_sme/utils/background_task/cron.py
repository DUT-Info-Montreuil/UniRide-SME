import threading
from time import sleep

import schedule

from uniride_sme.service import admin_service

thread_event = threading.Event()


def background_task():
    while thread_event.is_set():
        schedule.every().day.at("15:19").do(admin_service.get_end_date_insurance)
        schedule.run_pending()
        sleep(30)
