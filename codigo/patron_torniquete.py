torniquete = Semaphore(0)
# (...)
if alguna_condicion():
    torniquete.release()
# (...)
torniquete.acquire()
torniquete.release()
