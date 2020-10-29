# -*- coding: utf-8 -*-
import threading
num = 5
palillos = [threading.Semaphore(1) for i in range(num)]

def filosofo(id):
    while True:
        piensa(id)
        levanta_palillos(id)
        come(id)
        suelta_palillos(id)

def piensa(id):
    # (...)
    print("%d - Tengo hambre..." % id)

def levanta_palillos(id):
    palillos[(id + 1) % num].acquire()
    print("%d - Tengo el palillo derecho" % id)
    palillos[id].acquire()
    print("%d - Tengo ambos palillos" % id)

def suelta_palillos(id):
    palillos[(id + 1) % num].release()
    palillos[id].release()
    print("%d - Sigamos pensando..." % id)

def come(id):
    print("%d - ¡A comer!" % id)
    # (...)

filosofos = []
for i in range(num):
    fil = threading.Thread(target=filosofo, args=[i])
    filosofos.append(fil)
    fil.start()
