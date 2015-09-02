num_hilos = 10
cuenta = 0
mutex = Semaphore(1)
barrera = Semaphore(0)

# (...)

inicializa_estado()

mutex.acquire()
cuenta = cuenta + 1
mutex.release()

if cuenta == num_hilos:
    barrera.release()

barrera.acquire()
barrera.release()

procesamiento()
