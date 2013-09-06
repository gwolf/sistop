from threading import Thread
from time import sleep

lista = []
turno = 1 

def proceso1():
    global turno, lista;
    while (len(lista) < 20):
        while (turno == 2): pass
        lista.append(1)#agrega elemento
        turno = 2
    pass


def proceso2():
    global turno, lista;
    while(len(lista) < 20):
        while(turno==1): pass
        lista.append(2)#Agrega elemento
        turno = 1
    pass


def main():
    global lista
    t1 = Thread(target=proceso1)
    t2 = Thread(target=proceso2)
    t1.start(); t2.start()
    t1.join(); t2.join()

    print lista
    pass


main()
