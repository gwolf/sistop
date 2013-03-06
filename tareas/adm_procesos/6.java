package hilosjava;

import java.util.concurrent.Semaphore;

public class ProblemaSem {
    
    private int carro = 0,personas_cruzando=0;
    
    private final Semaphore mutex = new Semaphore(1);
    private final Semaphore carro_listo=new Semaphore(0);
    private final Semaphore actor_listo=new Semaphore(0);
    
    public void run() throws InterruptedException //Se encarga de la ejecuciÃ³n
    {
	carro_listo.acquire();
	if(carro!=0){
	    actor_listo.acquire();
	    abre();
	    while(personas_cruzando!=0){
		Thread.currentThread().sleep(3000);
		cruzando();}
	    personas_cruzando=0;
	    cierra();
	    actor_listo.release();}
	else {
	    System.out.println("No hay lugar");
	}
	carro_listo.release();
    }
    
    
    
    
    public int abre() throws InterruptedException {
	try {
	    mutex.acquire();
	    return carro++;
	    
	} finally {
	    mutex.release();
	}
    }
    
    public int cierra() throws InterruptedException {
	try {
	    mutex.acquire();
	    return 0;
	} finally {
	    mutex.release();
	}
    }
    public int cruzando() throws InterruptedException {
	try {
	    mutex.acquire();
	    return personas_cruzando++;
	    
	} finally {
	    mutex.release();
	}
    }
    
    
    public static void main(String args[]) throws InterruptedException
    {
	ProblemaSem a=new ProblemaSem();
	HilosJava carro=new HilosJava("Soy el carro");//El hilo estÃ¡ listo, se hace referencia a la clase que lo contiene
	HilosJava ayudante=new HilosJava("Soy el que cierra la puerta");
	
	carro.start();
	ayudante.start();
	
    }
    
    private String getName() {
	throw new UnsupportedOperationException("Not yet implemented");
    }
}
