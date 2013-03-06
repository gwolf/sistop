entrada =semaphore(0)
garage=semaphore(=)
def auto() :
    garage.acquire()
    garage.relese()
    entrando.acquire() -----→Adquiere la entrada y al terminar de entrar la libera
    entrada.relese()

def casa() :
    garage.acquire()
    abre_garage()
    entrada.acquire()
    cerrando_garage()
    entrando.relese()
    garage.relese()
