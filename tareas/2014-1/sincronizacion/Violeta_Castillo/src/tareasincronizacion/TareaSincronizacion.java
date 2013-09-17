package tareasincronizacion;

import java.util.concurrent.Semaphore;

public class TareaSincronizacion extends Thread {
    protected static Semaphore puerta;
    
    public static void main(String[] args) {
        puerta = new Semaphore(0,true);
        
        (new Thread(new Porton(puerta))).start();
        
        
        
        // TODO code application logic here
    }
}
