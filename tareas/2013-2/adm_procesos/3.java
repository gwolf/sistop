public class Cochera {
    
    public class Puerta implements Runnable {
	private boolean esta_abierta;
	private Thread hilo_puerta;
	final int retardo = 7;
	
	public Puerta () {
	    this.esta_abierta = false;
	}
	
	public void abrir () {
	    this.hilo_puerta = new Thread(this);
	    this.hilo_puerta.start();
	    try { this.hilo_puerta.join(); } catch (InterruptedException e) { }
	}
	
	public void cerrar () {
	    this.hilo_puerta = new Thread(this);
	    this.hilo_puerta.start();
	    try { this.hilo_puerta.join(); } catch (InterruptedException e) { }
	}
	
	public boolean estaAbierta () {
	    return this.esta_abierta;
	}
	
	public void run () {
	    int i = 0;
	    Thread hilo_sistema = Thread.currentThread();
	    
	    System.out.println ((this.esta_abierta ? "Cerrando" : "Abriendo") + " puerta ");
	    
	    while (hilo_sistema == hilo_puerta) {
		try { Thread.sleep(1000); } catch (InterruptedException e) { }
		System.out.print (".");
		if (i++ >= this.retardo) hilo_puerta = null;
	    }
	    
	    System.out.println ("\nPuerta " + (this.esta_abierta ? "cerranda" : "abierta"));
	    
	    this.esta_abierta = !this.esta_abierta;
	}
    }
    
    public class Carro {
	private boolean esta_adentro;
	
	public Carro () {
	    this.esta_adentro = true;
	}
	
	public void salir () {
	    System.out.println ("El carro va a salir ahora");
	    this.esta_adentro = !this.esta_adentro;
	}
	
	public void entrar () {
	    System.out.println ("El carro va a entrar ahora");
	    this.esta_adentro = !this.esta_adentro;
	}
	
	public boolean estaAdentro () {
	    return this.esta_adentro;
	}
	
    }
    
    public Cochera() {
	Puerta mi_puerta = new Puerta();
	Carro mi_carro = new Carro();
	final int espera_maxima = 15;
	int tiempo;
	
	while (true) {
	    
	    tiempo = (int) Math.floor(Math.random() * espera_maxima + 1);
	    System.out.println ("\n\n\nEsperando " + tiempo + " segundos para el siguiente evento...");
	    try { Thread.sleep (tiempo * 1000); } catch (InterruptedException ie) {}
	    System.out.println ("El coche quiere " + (mi_carro.estaAdentro() ? "salir" : "entrar"));
	    mi_puerta.abrir();
	    if (mi_carro.estaAdentro()) mi_carro.salir(); else mi_carro.entrar();
	    mi_puerta.cerrar();
	}
    }
    
    /**
     * @param args
     */
    public static void main(String[] args) {
	new Cochera();
    }
    
}
