#!/usr/bin/python3
#
# Versión corregida del problema de los fumadores compulsivos: Agrega
# a un arreglo de intermediarios para arbitrar entre los fumadores.
import time
import random
import threading

# Los requisitos del problema establecen que no se debe modificar al
# agente.
def agente():
    while True:
        semaforo_agente.acquire()
        # Copio la lista completa de ingredientes, elimino uno al
        # azar, y pongo los otros dos en la mesa.
        mis_ingr = ingredientes[:]
        mis_ingr.remove(random.choice(mis_ingr))
        for i in mis_ingr:
            print("AG: Proveyendo %s" % i)
            semaforos[i].release()

# El fumador resulta muy simplificado: Únicamente espera a una señal
# de su intermediario.
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
        found = False
        print('      I(%s): Estado: %s' % (ingr, que_tengo))
        for i in otros_ingr:
            if que_tengo[i]:
                  # ¿A quién hay que despertar?
                  restante = ingredientes[:]
                  restante.remove(ingr)
                  restante.remove(i)
                  print(' →    I(%s): ¡Tenemos lo necesario! Notificar a FU(%s)' % (ingr, restante[0]))
                  semaforos_interm[ restante[0] ].release()
                  # Y antes de que otro intermediario entre (tenemos
                  # interm_mutex), vaciamos nuestras estructuras.
                  que_tengo[i] = False
                  found = True
        if not found:
            # Somos el primer intermediario en despertar. Sólo
            # indicamos en que_tengo que encontramos uno de los
            # ingredientes.
            print('      I(%s): No tenemos %s' % (ingr, i))
            que_tengo[ingr] = True
        interm_mutex.release()


def fuma(ingr):
    print(' → FUM(%s) echando humo...' % ingr)
    time.sleep(0.3)

ingredientes = ['tabaco', 'papel', 'cerillo']

# Genero un hash de semáforos, indexados por ingrediente (cadena)
semaforos = {}
for i in ingredientes:
    semaforos[i] = threading.Semaphore(0)

# Cada fumador notifica al agente cuando ya fumó.
semaforo_agente = threading.Semaphore(1)

que_tengo = {}
semaforos_interm = {}
for i in ingredientes:
    que_tengo[i] = False
    semaforos_interm[i] = threading.Semaphore(0)
interm_mutex = threading.Semaphore(1)

# Lanzamos los hilos. ¡A darle al vicio!
threading.Thread(target=agente, args=[]).start()
intermediarios = [threading.Thread(target=intermediario, args=[i]).start() for i in ingredientes]
for i in ingredientes:
    fumadores = [threading.Thread(target=fumador, args=[i]).start() for i in ingredientes]
