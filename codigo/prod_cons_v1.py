import threading
buffer = []
threading.Thread(target=productor,args=[]).start()
threading.Thread(target=consumidor,args=[]).start()

def productor():
    while True:
        event = genera_evento()
        buffer.append(event)

def consumidor():
    while True:
        event = buffer.pop()
        procesa(event)
