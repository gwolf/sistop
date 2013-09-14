# AUTORES

# CRUZ MARTINEZ ANTONIO

# DELGADILLO HERNANDEZ ESTEFANIA

from threading import*
import time

def main():
 signal=Semaphore(0) #senal para que la cochera se active
 avanza=Semaphore(0) #indica que podemos entrar o salir de la cochera
 puedo =Semaphore(1) #indica si no hay personas cruzando
 torniquete =Semaphore(1)
 Thread(target=cochera,args=[signal,avanza]).start()
 Thread(target=carro,args=[signal,avanza,puedo,torniquete]).start()
 Thread(target=persona,args=[puedo,torniquete]).start()

def cochera(signal,avanza): 
 while True:
  signal.acquire()
  print "garaje: llamando ayudante"
  time.sleep(5)
  print "garaje: ayudante llego"
  print "garaje: abriendo puerta"
  time.sleep(5)
  print "garaje: puerta abierta"
  avanza.release()
  signal.acquire()
  print "garaje: cerrando puerta"
  time.sleep(5)
  print "garaje: puerta cerrada"


def carro(signal,avanza,puedo,torniquete):
 carInside=0#incialmente no hay carro en la cochera
 while True:
  if carInside==0:
   print "automovil: quiero entrar"
  else:
   print "automovil: quiero salir"
  signal.release()
  avanza.acquire()
  torniquete.acquire()
  puedo.acquire()
  print "automovil: avanzando"
  time.sleep(5)
  if carInside==0:
   print "automovil: estoy adentro"
   carInside=1
  else:
   print "automovil: estoy afuera"
   carInside=0
  signal.release()
  puedo.release()
  torniquete.release()


def persona(puedo,torniquete):
 while True:
  torniquete.acquire()
  torniquete.release()
  puedo.acquire()
  print "persona: quiero pasar"
  print "persona: cruzando"
  time.sleep(5)
  print "persona: ya pase"
  puedo.release()

main()
