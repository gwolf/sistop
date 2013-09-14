import threading
import time

mutex = threading.Semaphore(1)
señal = threading.Semaphore(0)

def Aut(): # Función de comportamiento del automóvil
	while True:
		#print("Controlando el auto")
		print("He llegado, quiero entrar")
		mutex.release()
		time.sleep(0.01)
def Pue(): #Función de comportamiento de la puerta
	while True:
		#print("Controlando la puerta")
		print("Abriendo la puerta")
		señal.acquire()
		time.sleep(0.01)
def Ayu(): #Función de comportamiento de el ayudante
	while True:
		#print("Controando al ayudante")
		print("El coche está aquí, debo abrir")
		mutex.acquire()
		time.sleep(0.01)
		señal.release()

threading.Thread(target = Aut, args=[]).start()
threading.Thread(target = Pue, args=[]).start()
threading.Thread(target = Ayu, args=[]).start()