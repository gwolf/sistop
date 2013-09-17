package tareasincronizacion;

import java.util.concurrent.Semaphore;
import java.util.Random;

public class Porton extends Thread{
    protected Semaphore puerta;
    private static Random generador = new Random();
    public int pausa,auto,peaton,transito,tiempoPuerta;
    
    public Porton(Semaphore puerta){
        this.puerta = puerta;
        pausa = generador.nextInt(500);
        peaton = generador.nextInt(10);
        transito = generador.nextInt(10);
        tiempoPuerta = generador.nextInt(100);
    }
    public void run(){
        try{
            auto=10;
            
            System.out.println("La puerta esta abierta.\n");
                
            while(auto>0){
                Thread.sleep(pausa);
                System.out.println("El auto avanza.\n");
                auto=auto-1;
                System.out.printf("\nSe cruzaron %d peatones, el auto espera a que pasen.\n",peaton);
                System.out.printf("\nSe cruzaron %d autos, el auto espera a que pasen.\n",transito);
                tiempoPuerta = transito + peaton;
                tiempoPuerta = tiempoPuerta-1;
                
                if(tiempoPuerta==0){
                    System.out.println("La puerta se cerro, el auto sigue afuera.\n");
                    break;
                }
            }
            
            
            
        }
        catch(InterruptedException e){
            e.printStackTrace();
        }
        System.out.println("El coche esta adentro.\n");
    }
}
