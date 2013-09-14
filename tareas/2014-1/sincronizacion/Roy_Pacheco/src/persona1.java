public class persona1 extends Thread {
    private cochera c;  //se utiliza la miama seccion critica  para los dos tipos de hilos
    //recibe un nombre y un dato del tipo cochera  (la seccion critica) para trabajar
    public persona1(String nombre, cochera mnsj){
        c=mnsj;
        setName(nombre);
    }
    //se invoca el metodo especifico del hilo
    public void run(){
        while(true){
            c.meterCoche();
        }
    }
    
}
