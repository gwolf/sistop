que_tengo = {}
semaforos_interm = {}
for i in ingredientes:
    que_tengo[i] = False
    semaforos_interm[i] = threading.Semaphore(0)
interm_mutex = threading.Semaphore(1)
intermediarios = [threading.Thread(target=intermediario, args=[i]).start() for i in ingredientes]

def fumador(ingr):
    while True:
        semaforos_interm[ingr].acquire()
        fuma(ingr)
        semaforo_agente.release()

def intermediario(ingr):
    otros_ingr = ingredientes[:]
    otros_ingr.remove(ingr)
    while True:
        semaforos[ingr].acquire()
        interm_mutex.acquire()
        found = True
        for i in otros_ingr:
            if que_tengo[i]:
                que_tengo[i] = False
                habilitado = list(otros_ingr)
                habilitado.remove(i)
                semaforos_interm[habilitado[0]].release()
                found = True
                break
            if not found:
                que_tengo[ingr] = True
            interm_mutex.release()
