import threading
lectores = 0
mutex = threading.Semaphore(1)
cuarto_vacio = threading.Semaphore(1)

def escritor():
    cuarto_vacio.acquire()
    escribe()
    cuarto_vacio.release()

def lector():
    mutex.acquire()
    lectores = lectores + 1
    if lectores == 1:
        cuarto_vacio.acquire()
    mutex.release()

    lee()

    mutex.acquire()
    lectores = lectores - 1
    if lectores == 0:
        cuarto_vacio.release()
    mutex.release()
