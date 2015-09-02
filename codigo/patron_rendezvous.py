from threading import Semaphore, Thread
guiListo = Semaphore(0)
calculoListo = Semaphore(0)

Thread(target=maneja_gui, args=[]).start()
Thread(target=maneja_calculo, args=[]).start()

def maneja_gui():
    inicializa_gui()
    guiListo.release()
    calculoListo.acquire()
    recibe_eventos()

def maneja_calculo():
    inicializa_datos()
    calculoListo.release()
    guiListo.acquire()
    procesa_calculo()
