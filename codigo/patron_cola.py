colaLideres = Semaphore(0)
colaSeguidores = Semaphore(0)
# (...)
def lider():
    colaSeguidores.release()
    colaLideres.acquire()
    baila()
def seguidor():
    colaLideres.release()
    colaSeguidores.acquire()
    baila()
