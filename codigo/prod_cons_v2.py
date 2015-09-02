import threading
mutex = threading.Semaphore(1)
elementos = threading.Semaphore(0)
buffer = []
threading.Thread(target=productor, args=[]).start()
threading.Thread(target=consumidor, args=[]).start()

def productor():
    while True:
        event = genera_evento()
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
