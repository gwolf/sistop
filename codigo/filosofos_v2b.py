def levanta_palillos(id):
    if id == 0:  # Zurdo
        palillos[id].acquire()
        print("%d - Tengo el palillo izquierdo" % id)
        palillos[(id + 1) % num].acquire()
    else:  # Diestro
        palillos[(id + 1) % num].acquire()
        print("%d - Tengo el palillo derecho" % id)
        palillos[id].acquire()
    print("%d - Tengo ambos palillos" % id)
