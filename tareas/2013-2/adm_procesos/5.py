
import threading
peatones=0
garage=0
mutex = threading.Semaphore(1)
torniquete = threading.Semaphore(1)
calleLibre = threading.semaphore(1)

def entrar():
  torniquete.acquire()
  calleLibre.acquire()
  abrir()
  mutex.acquire()
  if garage == 0:
      meterAuto()
  garage = garage + 1
  else:
      print 'Garage lleno'
  mutex.release()
  calleLibre.release()
  torniquete.release()
 
def salir():
  torniquete.acquire()
  calleLibre.acquire()
  abrir()
  mutex.acquire()
  if garage == 1:
      sacarAuto()
  garage = garage - 1
  else:
      print 'Garage vacio'
  mutex.release()
  calleLibre.release()
  torniquete.release()
 
def peaton():
  torniquete.acquire
  torniquete.release
 
  mutex.aquire
  peatones = peatones + 1
  if peatones == 1:
      calleLibre.acquire
mutex.release
cruzaPeatones()

mutex.aquire
    peatones=peatones-1
    if peatones == 0:
      calleLibre.release
    mutex.release
