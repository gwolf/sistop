Espinoza Gazano, José
López Sánchez, Arturo

puerta = semaforo(1)
ayudando = semaforo(1)
entrar_salir = semaforo(1)
torniquete = semaforo(1)
mutex = semaforo(1)
obstaculos = 0
via_libre = semaforo(1)

def abrir_puerta():
  #Al comenzar a abrir pide el mutex
  puerta.acquire
  abrir()
  puerta.release #Al terminar de abrir lo suelta
  pass
  
def cerrar_puerta():
  #Al comenzar a cerrar debe pedir el mutex
  puerta.aquire
  cerrar()
  puerta.release #Libera al terminar de cerrar
  pass

def obstaculo():
  #Peatones o ciclistas que estan pasando
  torniquete.acquire()
  torniquete.release()
  
  mutex.acquire()
  obstaculos += 1
  if obstaculos == 1:
    via_libre.acquire()
  mutex.release
  
  pasar_la_calle()
  
  mutex.acquire()
  obstaculos -= 1
  if obstaculos == 0:
    via_libre.release()
  mutex.release()
  
  
def pedir_ayuda(accion):
  entrar_salir.acquire() #Tomo el control sobre la entrada/salida
  ayudando.acquire()     #indico que no puedo hacer dos cosas a la vez

    abrir_puerta()         #Primero abro la puerta y la dejo 'abriendo'
    torniquete.acquire()  #Evito que pasen más peatones
    via_libre.acquire()   #Espero a que`pase el ultimo peaton
    puerta.acquire()      #Espero a que toda la puerta este abierta
    puerta.release()
    
    entrar_salir.release() #Indica al auto que puede entrar/salir
    entrar_salir.acquire() #Espera a que el auto termine de entrar/salir
    entrar_salir.release() #Libera el semaforo de entrada/salida

    via_libre.release()     #Le regresamos el paso a los peatones
    
    cerrar_puerta()         #Independientemente de si entra o sale debo cerrar puerta
                            #No necesito semaforos porque el auto ya terminó de entrar/salir y la puerta no lastima
                            #a los peatones!

    torniquete.release()    #Para indicar nuevamente el paso a peatones
    

  ayudando.release()        #Puedo recibir nueva orden
  
def automovil():
    pedir_ayuda('abrir')     #Se abre la puerta
    entrar_salir.acquire()   #No hago nada hasta que me indiquen que puedo entrar/salir
    entrar_salir_auto()                 #Entro o salgo con el auto
    entrar_salir.release()   #Termine de entrar, se lo indico al asistente
