from threading import Semaphore
senal = Semaphore(0)

def envia_datos():
    calcula_datos()
    senal.acquire()
    envia_por_red()

def prepara_conexion():
    crea_conexion()
    senal.release()
