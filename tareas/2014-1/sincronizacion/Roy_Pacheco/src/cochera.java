import java.util.Random;
public class cochera{
    private int porton;
    private int coche;
    
 cochera(){  //se inicilizaron en cero para tener un estado donde la puerta estaba abierta y el carro estaba afuera
     //puerta=0 cerrada, =1 abierta, coche=0 no esta adentro de la cochera, =1, esta adentro de
     coche=0; 
     porton=0;
 }   
 
 public synchronized void meterCoche(){
     if(coche == 0){
         abrirPuerta();
         while(checarPeatones()==1){
                 System.out.println("El conductor no puede meter coche, hay gente adelante");             
         }
         coche=1;
         imprimir1();
         cerrarPuerta();
         notifyAll();
     }
     else{
         try{//esta parte es para que el hilo tenga una espera activa si no se cumple la primera condicion
             System.out.println("Ya hay un coche adentro de la cochera, no se puede meter nada \n");
             wait();
         }catch(InterruptedException e){}
     }   
    }

 public synchronized void sacarCoche(){
     if(coche == 1){
         abrirPuerta();
         while(checarPeatones()==1){
                 System.out.println("El conductor no puede sacar coche, hay gente atras"); 
         }
         coche=0;
         imprimir2();
         cerrarPuerta();
         notifyAll();
     } 
     else{
      try{//esta parte es para que el hilo tenga una espera activa si no se cumple la primera condicion
            System.out.println("No hay ningun coche adentro de la cochera, no se puede sacar nada \n");
             wait();
         }catch(InterruptedException e){}  
     }
}
 
    public void abrirPuerta(){
        if(this.porton == 0){
         this.porton =1;
         System.out.println(Thread.currentThread().getName() + " ha abierto el porton");
        }
    }
 
    public void cerrarPuerta(){
        if(this.porton == 1){
         this.porton =0;
         System.out.println(Thread.currentThread().getName() + " ha cerrado el porton \n");
        }
    }
 //este metodo Thread.currentThread().getName() lo encontre en internet, ya que como la clase cochera no hereda de Thread
    //el metodo getName() no me funcionaba para imprimir el identificador
    public void imprimir1(){
         System.out.println("El conductor ha metido el coche");
    }
        
    public void imprimir2(){
        System.out.println("El conductor ha sacado el coche");
    } 
    
    public int checarPeatones(){
        Random r = new Random();
        int peaton= r.nextInt(2);//calcula un aleatorio entre 0 y 1, 0 no hay peatones, 1 si hay peatones
        return peaton;
    }
}
