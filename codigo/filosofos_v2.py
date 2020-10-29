def levanta_palillos(id):
    if (id % 2 == 0):  # Zurdo
        palillo1 = palillos[id]
        palillo2 = palillos[(id + 1) % num]
    else:  # Diestro
        palillo1 = palillos[(id + 1) % num]
        palillo2 = palillos[id]
    palillo1.acquire()
    print("%d - Tengo el primer palillo" % id)
    palillo2.acquire()
    print("%d - Tengo ambos palillos" % id)
