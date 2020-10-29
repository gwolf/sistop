# *-* Encoding: utf-8 *-*
import threading
import time
import random
mutex = threading.Semaphore(1)
elementos = threading.Semaphore(0)
buffer = []
max_buffer = 5
multip_buffer = threading.Semaphore(max_buffer)
duracion = {'prod': 0.5, 'cons': 1}

class Evento:
    def __init__(self, hilo):
        self.ident = random.random()
        print("Hilo G%d generando evento %1.3f; buffer con %d" % (hilo, self.ident, len(buffer)))
        time.sleep( duracion['prod'] )
    def process(self, hilo):
        print("Hilo P%d procesando evento %1.3f" % (hilo, self.ident))
        time.sleep( duracion['cons'] )

def productor(yo):
    while True:
        event = Evento(yo)
        multip_buffer.acquire()
        mutex.acquire()
        buffer.append(event)
        mutex.release()
        elementos.release()

def consumidor(yo):
    while True:
        elementos.acquire()
        mutex.acquire()
        event = buffer.pop()
        mutex.release()
        multip_buffer.release()
        event.process(yo)

for i in range(3):
    threading.Thread(target=productor, args=[i]).start()
for i in range(2):
    threading.Thread(target=consumidor, args=[i]).start()
