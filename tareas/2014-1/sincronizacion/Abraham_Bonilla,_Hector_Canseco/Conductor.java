/* Bonilla Pastor José Abraham y Canseco Hector
Sistemas operativos grupo:7  12/09/13
FI-UNAM

Programa que resuelve el problema:
Implementa hilos que controlen el siguiente sistema:

La cochera de casa es de portón de apertura automática
Una vez que la puerta comienza a abrir, tarda x tiempo en quedar abierta
Una vez que la puerta comienza a cerrar, tarda x tiempo en quedar cerrada
El coche toma cierto tiempo en entrar y salir. Particularmente si hay peatones o vehículos cruzando frente a la puerta, tienes que esperar a que terminen de pasar.
La batería del control está muy débil, por lo que cuando llegas tienes que pedirle a otro actor que abra y cierre por tí. Cuando te vas también necesitas esta ayuda.
Si el coche es golpeado por la puerta, se abolla y hay que llevarlo al taller. No quieres que eso ocurra.
Implementa un sistema que tome en cuenta las restricciones en cuestión.
*/


package garage1;

import java.io.*;
import java.util.*;




public class Conductor extends Thread {
	public void run() {
		int h=1;
		int a=0;
		while (h==1){
	Conductor carro = new Conductor();
	
	
	carro.verificaPeaton(a);
	if(a==0){
		carro.sacaCarro(a);
		if(a==0){
			try {
				wait();
				notifyAll();
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	carro.meteCarro(a);
	if(a==0){
		try {
			wait();
			notifyAll();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	try {
		wait();
		notifyAll();
	} catch (InterruptedException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	}
	}
	
	public int sacaCarro (int a){  //metodo
		int b=15;
		Random r = new Random();
		a=r.nextInt(b+1);
		while (a!=0){
			a--;
			System.out.println("sacando carro"+a);
		}
		System.out.println("salio carro");
		return a;
}
	public int verificaPeaton(int a){  //metodo
		int b=10;
		Random r = new Random();
		a=r.nextInt(b+1);
		while (a!=0){
			a--;
			System.out.println("peaton "+a);
		}
		System.out.println("no hay peaton");
		return a;

	}
	public int meteCarro(int a){  //metodo
		int b=15;
		Random r = new Random();
		a=r.nextInt(b+1);
		while (a!=0){
			a--;
			System.out.println("entrando carro "+a);
		}
		System.out.println("entro");
		return a;
		
	}

}
