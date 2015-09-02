import threading
lectores = 0
mutex = threading.Semaphore(1)
cuarto_vacio = threading.Semaphore(1)
torniquete = threading.Semaphore(1)

def escritor():
    torniquete.acquire()
    cuarto_vacio.acquire()
    escribe()
    cuarto_vacio.release()
    torniquete.release()

def lector():
    global lectores
    torniquete.acquire()
    torniquete.release()

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
