import threading

abran = threading.Semaphore(1) //Alguien abra el porton	
cierren= threading.Semaphore(1)    //Alguien que cierre el porton

def entrando():		
	while True:
	entra()
	cierra_porton()
def saliendo():
	while True:
	sal()
	cierra_porton()
def entra():	
	abran.acquire()
	print "Voy a meter el carro"
	abran.release()
def sal():
	abran.acquiere()
	print "voy a sacar el carro"
	abran.release()
def cierra_porton():
	cierren.acquire()
	cierren.release()

//Traté de usar un codigo parecido al visto en clase
//Espero no tenga problemas en leerlo
//Tuve dificultad en como hacerle para ver si puedo meter o no el carro dependiendo si hay o no un peaton o un carro estorbando en la entrada