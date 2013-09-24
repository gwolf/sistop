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



public class Garag {
	 public static int a=0; //variable global1
	 public static int j=0; //variable global2
	 public static void main(String[] args){
		 
		 new Ayudante().start(); // hilo clase ayudante
		 new Conductor().start();//hilo clase conductor
		 
	 }
	 public int getVar(){    //metodo para obtener variable a por las otra clases
		 
		 return a;
		 }
	 public int setVar(int x){  //metodo para escribir la variable a por las otras clases
		a=x;
		 return x;
		 }
	 public int getVar2(){   //metodo para obtener variable j  por las otra clases
		 
		 return j;
		 }
	 public int setVar2(int y){    //metodo para escribir la variable j por las otras clases
		j=y;
		 return y;
		 }  

}
