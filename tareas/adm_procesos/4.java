public class Coche extends Thread{
    Cochera aux;
    Peaton auxp;
    int tiempo;
    int estado;
    boolean estacionado = false; //Dice si está estacionado en la cochera
    boolean estacionando = false; //Dice si está en el proceso de estacionarse
    boolean golpe = false;
    Semaphore semaforo;
    
    public Coche(int tiempo, Cochera aux, Peaton auxp){
	this.tiempo = tiempo;
	this.aux = aux;
	this.auxp = auxp;
    }
    @Override
    public void run(){
	if(!estacionado){
	    semaforo.acquire();
	    estado = estacionarVerifica();
	    semaforo.release();
	    if(estado == -1){ //Puede entrar
		if()
		    estacionarse();
	    }
	    if(estado = 10){//No está abierto
		aux.abrir();
	    }
	    else
		
		}
    }
}
public void esperar(int espera) throws InterruptedException{
    Thread.sleep(espera * 1000);
}
public void abrirCochera() throws InterruptedException{
    semaforo.acquire();
    if(estacionado)
	Thread.sleep(5000);
    semaforo.release();
}
public void cerrarCochera() throws InterruptedException{
    semaforo.acquire();
    if(estacionado)
	aux.cerrar();
    semaforo.release();
}
public int estacionarVerifica() throws InterruptedException{
    if(aux.isAbierto() && aux.isLibre()){
	return -1;
    }
    
    return Ayuda();//Necesita ayuda
}
public int Ayuda(){
    if(aux.isAbierto()){
	return auxp.tiempo;
    }
    return 10;
}
public void estacionarse() throws InterruptedException{
    estacionando = true;
    Thread.sleep(2000); //Dos segundos
    estacionando = false;
    estacionado = true;
}
}
//----------------------------------------------Cochera-------------------------------------------------------------------------
public class Cochera extends Thread{
    Semaphore semaforo;
    private boolean abierto = false;
    private boolean libre = true;
    boolean solicitud = false;
    Coche auxc;
    Peaton auxp;
    List<Coche> lco;
    public Cochera(Semaphore semaforo,Coche auxc, Peaton auxp){
	lco = new ArrayList<Coche>();
	this.semaforo = semaforo;
	this.auxc = auxc;
	this.auxp = auxp;
    }
    public void run(){
	
    }
    public void abrir() throws InterruptedException{
	if(!lco.isEmpty()){
	    lco.get(1).abrirCochera();
	    abierto = true;
	}
	else
	    auxp.
		
		}
    public void cerrar() throws InterruptedException{
	abierto = false;
	Thread.sleep(5000);
    }
    //------------ Getter / Setter -------------------
    public boolean isLibre() {
	return libre;
    }
    
    public void setLibre(boolean libre) {
	this.libre = libre;
    }
    
    public boolean isAbierto() {
	return abierto;
    }
    
    public void setAbierto(boolean abierto) {
	this.abierto = abierto;
    }
    
    public Semaphore getSemaforo() {
	return semaforo;
    }
    
    public void setSemaforo(Semaphore semaforo) {
	this.semaforo = semaforo;
    }
    
}
//---------------------------------Peaton-----------------------------------------------------------
public class Peaton extends Thread{
    Cochera aux;
    Coche auxc;
    boolean cruzando = false;
    
    int tiempo;
    
    public Peaton(Cochera aux, Coche auxc){
	this.aux = aux;
	this.auxc = auxc;
    }
    @Override
    public void run(){
	cruzando = true;
	for(tiempo = 3; tiempo >= 0; tiempo--){
	    try {
		Thread.sleep(1000);
	    } catch (InterruptedException ex) {
		Logger.getLogger(Peaton.class.getName()).log(Level.SEVERE, null, ex);
	    }
	}
	cruzando = false;
	Thread.sleep(Math.random() * 1000);
    }
    public void abrirCochera() throws InterruptedException{
	if(!cruzando)
	    aux.abrir();
    }
    public void cerrarCochera() throws InterruptedException{
	if(!cruzando)
	    aux.cerrar();
    }
    
}
