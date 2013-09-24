#  Espinosa Gazano Jose Alejandro  - Arturo Sanchez Lopez
#! encoding: UTF-8
from threading import Semaphore, Thread
from time import sleep
from random import random

puerta, entrar_salir = Semaphore(0), Semaphore(1)
torniquete, mutex = Semaphore(1), Semaphore(1)
via_libre = Semaphore(1)
obstaculos = 0


def abrir_cerrar_puerta():  # Accion -> abrir o cerrar
    """A final de cuentas siempre se abre y se cierra la puerta
    primero se abre para que el auto entre o salga y luego se cierra
    En estas funciones se puede decir que la puerta o se abre o se cierra."""
    print 'Puerta abriendo/cerrando!'
    sleep(3)
    print 'Puerta termina de abrir/cerrar'
    puerta.release()
    pass


def obstaculo(o_id):
    sleep(random())
    global obstaculos
    torniquete.acquire()
    torniquete.release()

    mutex.acquire()
    obstaculos += 1
    if obstaculos == 1:
        via_libre.acquire()
    mutex.release()

    print '\nObstaculo %d pasando.\n' % o_id

    mutex.acquire()
    obstaculos -= 1
    print '\nObstaculo %d termine de pasar.\n' % o_id
    if obstaculos == 0:
        via_libre.release()
    mutex.release()
    pass


def ayudante():
    sleep(random())
    entrar_salir.acquire()  # Garantiza que el auto no se mueva Sem = 0

    print 'Soy el ayudante y abro la puerta'
    Thread(target=abrir_cerrar_puerta).start()  # Estamos abriendo la puerta.

    torniquete.acquire()  # Pedimos el torniquete
    via_libre.acquire()
    print 'Soy el ayudante y ya no veo obstaculos.'

    puerta.acquire()  # Espero a que se abra la puerta

    print 'Soy el ayudante y le digo al auto que pase'
    entrar_salir.release()  # Le digo al auto que pase!
    sleep(1)  # Forzamos el cambio de control
    entrar_salir.acquire()  # Estoy esperando a que el auto entre
    print 'Soy el ayudante y cerrare la puerta'
    Thread(target=abrir_cerrar_puerta).start()

    print 'Soy el ayudante y dejo pasar peatones'
    via_libre.release()
    torniquete.release()
    pass


def main():  # Esta funcion maneja el auto
    #########################CREAR THREADS E INICIARLAS#######################
    obst = 10  # Numero de obstaculos
    [Thread(target=obstaculo, args=(x+1,)).start() for x in range(obst)]
    ayuda = Thread(target=ayudante)
    ##########################################################################

    print '\n\n\nSoy el auto y quiero entrar/salir \n'
    ayuda.start()  # Pido ayuda para la puerta!
    sleep(0.1)  # Forzamos a que ceda el paso
    entrar_salir.acquire()  # Espero el permiso para pasar (lo da el ayudante)

    print 'Soy el auto y estoy pasando'
    sleep(2)
    print 'Soy el auto y ya pase'
    entrar_salir.release()
    pass


main()
