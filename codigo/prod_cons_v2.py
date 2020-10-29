import threading
import time
import random
mutex = threading.Semaphore(1)
elementos = threading.Semaphore(0)
buffer = []

class Evento:
    def __init__(self):
        self.ident = random.random()
        print("Generando evento %1.3f" % self.ident)
        time.sleep(self.ident)
    def process(self):
        print("Procesando evento %1.3f" % self.ident)


def productor():
    while True:
        event = Evento()
        mutex.acquire()
        buffer.append(event)
        mutex.release()
        elementos.release()

def consumidor():
    while True:
        elementos.acquire()
        mutex.acquire()
        event = buffer.pop()
        mutex.release()
        event.process()

threading.Thread(target=productor, args=[]).start()
threading.Thread(target=consumidor, args=[]).start()
