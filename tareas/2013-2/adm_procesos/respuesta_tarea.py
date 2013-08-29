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


puerta_abierta = threading.Semaphore(0)
abreme = threading.Semaphore(0)
cierrame = threading.Semaphore(0)
demora_apertura = 3

def mete_coche():
    abreme.release()
    puerta_abierta.acquire()
    while peatones_o_coches_pasando():
        sleep 0.1
    entra()
    puerta_abierta.release()
    cierrame.release()

def saca_coche():
    abreme.release()
    puerta_abierta.acquire()
    while peatones_o_coches_pasando():
        sleep 0.1
    sal()
    puerta_abierta.release()
    cierrame.release()

def asistente():
    while True:
        abreme.acquire()
        abre_puerta()
        sleep demora_apertura
        puerta_abierta.release()

        cierrame.acquire()
        cierra_puerta()
        puerta_abierta.release()

def conductor():
    while True:
        saca_coche()
        da_vueltas_como_trompo()
        mete_coche()
        descansa()
