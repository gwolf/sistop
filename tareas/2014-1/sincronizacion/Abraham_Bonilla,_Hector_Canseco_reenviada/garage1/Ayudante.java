/* Bonilla Pastor Jos Abraham y Canseco Sánchez Hector
Sistemas operativos grupo:7  12/09/13
FI-UNAM

Programa que resuelve el problema:
Implementa hilos que controlen el siguiente sistema:

La cochera de casa es de portn de apertura automtica
Una vez que la puerta comienza a abrir, tarda x tiempo en quedar abierta
Una vez que la puerta comienza a cerrar, tarda x tiempo en quedar cerrada
El coche toma cierto tiempo en entrar y salir. Particularmente si hay peatones o vehculos cruzando frente a la puerta, tienes que esperar a que terminen de pasar.
La batera del control est muy dbil, por lo que cuando llegas tienes que pedirle a otro actor que abra y cierre por t. Cuando te vas tambin necesitas esta ayuda.
Si el coche es golpeado por la puerta, se abolla y hay que llevarlo al taller. No quieres que eso ocurra.
Implementa un sistema que tome en cuenta las restricciones en cuestin.
*/


package garage1;

import java.util.Random;

public class Ayudante extends Thread {  // clase en hilo ayudante
	public synchronized  void run() {
		
	Ayudante puerta = new Ayudante(); // objeto puerta de ayudante
	Garag var = new  Garag();  // instancia de garag para usar sus metodos
	 int x=0;
	 
   int s=0;
	 
	while(true){  // ciclo infinito
	
	if(var.getVar()==0&&var.getVar2()==0||var.getVar()==0&&var.getVar2()==1){  // variables condicionales obtenida desde garag
		puerta.abrePuerta(s);  //abre puerta
		
		x=1; // modifica x
		var.setVar(x);	 //escribe variable global a
		try {
				wait();
				notifyAll();
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
	}
	if(var.getVar()==2&&var.getVar2()==1||var.getVar()==2&&var.getVar2()==0){
	puerta.cierraPuerta(s);
	x=0;
	
	var.setVar(x); // escribe variable global a
	
	}
	
	}
	
	}
	
	public int abrePuerta (int s){  //metodo  abrir la puerta
		int d=15;
		s=d;
		//Random r = new Random();
		//s=r.nextInt(d+1);
		while (s!=0){
			s--;
			System.out.println("abriendo puerta"+s);
		}
		System.out.println("puerta abierta");
		return s;
}
	
	public int cierraPuerta(int s){  //metodo  cerrar la puerta 
		int d=15;
		s=d;
		//Random r = new Random();
		//s=r.nextInt(d+1);
		while (d!=0){
			s--;
			System.out.println("cerrando puerta "+s);
		}
		System.out.println("cerro");
		return s;
		
	}

}

