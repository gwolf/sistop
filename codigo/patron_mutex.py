mutex = Semaphore(1)
# ...Inicializar estado y lanzar hilos
mutex.acquire()
#  Aquí se está en la region de exclusión mutua
x = x + 1
mutex.release()
# Continúa la ejecucion paralela
