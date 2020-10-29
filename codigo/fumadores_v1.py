#!/usr/bin/python3
#
# Versión inicial del problema de los fumadores compulsivos: Lleva
# necesariamente a un bloqueo mutuo.
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

def fumador(ingr):
    mis_semaf = []
    # Construye la lista de semáforos a los que vamos a esperar con
    # todos los ingredientes existentes, a excepción del que cada uno
    # de los fumadores tiene
    for i in semaforos.keys():
        if i != ingr:
            mis_semaf.append(semaforos[i])

    while True:
        for i in mis_semaf:
            i.acquire()
            print('   FUM(%s): Levanto algo de la mesa' % ingr)
        fuma(ingr)
        semaforo_agente.release()

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

# Lanzamos los hilos. ¡A darle al vicio!
threading.Thread(target=agente, args=[]).start()
for i in ingredientes:
    fumadores = [threading.Thread(target=fumador, args=[i]).start() for i in ingredientes]
