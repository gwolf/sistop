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

import java.io.*;
import java.util.*;




public class Conductor extends Thread {
	public synchronized void run() {
		int x;
			int s = 0;
			int p=0;
			int y=0;
		while (true){
	Conductor carro = new Conductor();  //objeto carro de conductor
	Garag var = new  Garag();            // instancia de garag para usar sus metodos
	
	if(var.getVar()==1 && var.getVar2()==0){
	carro.verificaPeaton(s);
	
	carro.sacaCarro(p);
		x=2;
		y=1;
		var.setVar(x);  // escribe variable global a
		var.setVar2(y);   // escribe variable global j
		//if(a==0){
			try {
				wait();
				notifyAll();
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		//}
	}
	if(var.getVar()==1 && var.getVar2()==1){
	carro.meteCarro(s);
	x=2;
	y=0;
	var.setVar(x);   // escribe variable global a
	var.setVar2(y);   // escribe variable global j
	
		try {
			wait();
			notifyAll();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	}
	}
	
	public int sacaCarro (int p){  //metodo   sacar el carro
		int b=15;
		p=b;
		//Random r = new Random();
		//p=r.nextInt(b+1);
		while (p!=0){
			p--;
			System.out.println("sacando carro"+p);
		}
		System.out.println("salio carro");
		return p;
}
	public int verificaPeaton(int s){  //metodo    verificar si hay peaton 
		int b=10;
		Random r = new Random();
		s=r.nextInt(b+1);
		while (s!=0){
			s--;
			System.out.println("peaton "+s);
		}
		System.out.println("no hay peaton");
		return s;

	}
	public int meteCarro(int s){  //metodo meter el carro
		int b=15;
		s=b;
		//Random r = new Random();
		//s=r.nextInt(b+1);
		while (s!=0){
			s--;
			System.out.println("entrando carro "+s);
		}
		System.out.println("entro");
		return s;
		
	}

}
