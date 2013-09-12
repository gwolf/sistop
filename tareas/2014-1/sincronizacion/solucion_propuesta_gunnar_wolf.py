#!/usr/bin/python
# This Python file uses the following encoding: utf-8
# Implementa hilos que controlen el siguiente sistema:

# *   La cochera de casa es de portón de apertura automática
# *   Una vez que la puerta comienza a abrir, tarda x tiempo en quedar abierta
# *   Una vez que la puerta comienza a cerrar, tarda x tiempo en quedar cerrada
# *   El coche toma cierto tiempo en entrar y salir. Particularmente si hay
#     peatones o vehículos cruzando frente a la puerta, tienes que esperar a
#     que terminen de pasar.
# *   La batería del control está muy débil, por lo que cuando llegas tienes
#     que pedirle a otro actor que abra y cierre por tí. Cuando te vas también
#     necesitas esta ayuda.
# *   Si el coche es golpeado por la puerta, se abolla y hay que llevarlo al
#     taller. No quieres que eso ocurra.
#
# Implementa un sistema que tome en cuenta las restricciones en cuestión. Para
# su calificación, importa que:
#
# * El problema se resuelva correctamente
# * El tiempo de espera sea razonable
# * El código sea válido y legal en tu lenguaje favorito
#   * Puedes asumir que la semántica del control de hilos, señales y
#     primitivas de sincronización es similar a la expuesta en clase, no
#     hace falta implementar eso a detalle.
# * Puedes enviar tu código más de una vez si sientes que lo mejoras; el
#   que vale es el último.
#
# El sistema cerrará la recepción a la hora de inicio de la próxima
# clase (lunes 18 de febrero, 13:00)

from time import sleep
from random import random
import threading

puerta_abierta = threading.Semaphore(0)
abreme = threading.Semaphore(0)
cierrame = threading.Semaphore(0)
demora_apertura = 1

def mete_coche():
    print "    Quiero meter el coche"
    abreme.release()
    puerta_abierta.acquire()
    while peatones_o_coches_pasando():
        sleep(0.1)
    entra()
    puerta_abierta.release()
    cierrame.release()

def saca_coche():
    print "    Quiero sacar el coche"
    abreme.release()
    puerta_abierta.acquire()
    while peatones_o_coches_pasando():
        sleep(0.1)
    sal()
    puerta_abierta.release()
    cierrame.release()

def asistente():
    while True:
        print "*A* Esperando a que me pidan abrir"
        abreme.acquire()
        print "*A* Abrir"
        abre_puerta()
        sleep(demora_apertura)
        print "*A* Puerta lista"
        puerta_abierta.release()
        print "*A* Esperando a que me pidan cerrar"
        cierrame.acquire()
        print "*A* Cerrando"
        cierra_puerta()
        print "*A* Puerta lista"
        puerta_abierta.release()

def conductor():
    while True:
        print "*C* Quiero salir"
        saca_coche()
        print "*C* A dar vueltas"
        da_vueltas_como_trompo()
        print "*C* Quiero entrar"
        mete_coche()
        print "*C* Ya a descansar"
        descansa()

def entra():
    print "    Entrando"
    sleep(0.3)

def sal():
    print "    Saliendo"
    sleep(0.3)

def abre_puerta():
    print "    Abriendo la puerta"
    sleep(0.3)

def cierra_puerta():
    print "    Cerrando la puerta"
    sleep(0.3)

def da_vueltas_como_trompo():
    print "    A pasear!"
    sleep(0.5)

def descansa():
    print "    Por fin en casa"
    sleep(0.5)

def peatones_o_coches_pasando():
    random() < 0.8


c = threading.Thread(target=conductor,args=[])
a = threading.Thread(target=asistente,args=[])

a.start()
c.start()

