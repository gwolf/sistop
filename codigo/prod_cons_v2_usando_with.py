def consumidor():
    while True:
        elementos.acquire()
        with mutex:
            event = buffer.pop()
        event.process()
