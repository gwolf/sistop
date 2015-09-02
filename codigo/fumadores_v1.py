import random
import threading
ingredientes = ['tabaco', 'papel', 'cerillo']
semaforos = {}
semaforo_agente = threading.Semaphore(1)
for i in ingredientes:
    semaforos[i] = threading.Semaphore(0)

    threading.Thread(target=agente, args=[]).start()
    fumadores = [threading.Thread(target=fumador, args=[i]).start() for i in ingredientes]

def agente():
    while True:
        semaforo_agente.acquire()
        mis_ingr = ingredientes[:]
        mis_ingr.remove(random.choice(mis_ingr))
        for i in mis_ingr:
            print "Proveyendo %s" % i
            semaforos[i].release()

def fumador(ingr):
    mis_semaf = []
    for i in semaforos.keys():
        if i != ingr:
            mis_semaf.append(semaforos[i])
        while True:
            for i in mis_semaf:
                i.acquire()
            fuma(ingr)
            semaforo_agente.release()

def fuma(ingr):
    print 'Fumador con %s echando humo...' % ingr
