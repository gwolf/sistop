//PACHECO CERON RODRIGO JAVIER

/*este programa lo hice tratando de resolverlo por un enfoque de productores-consumidores, 
 * por lo cual, no hice la implementacion de semaforos correctamente, pero trate de hacer una
 * sincronizacion entre las dos clases de hilos que maneja el programa*/

public class Hilos{
    
    public static void main(String[] args) {
        
        cochera mensaje= new cochera();
        /*aqui me di cuenta que hubiera sido mejor llamar a la clase persona1 
         conductor 1, ya que es el que trata de meter el coche a la cochera,
         lo mismo con la clase persona2, que es un conductor que siempre trata de sacar el coche*/
        persona1 personauno= new persona1("Ayudante 1" ,mensaje); 
        persona1 personados= new persona1("Ayudante 2" ,mensaje);
        persona1 personatres= new persona1("Ayudante 3" ,mensaje); //aqui se les manda un nombre para su futura identificacion
        
        persona2 personacuatro= new persona2("Ayudante 4" ,mensaje);
        persona2 personacinco= new persona2("Ayudante 5" ,mensaje);
        persona2 personaseis= new persona2("Ayudante 6" ,mensaje);
        
        personauno.start();
        personados.start();
        personatres.start();
        personacuatro.start();
        personacinco.start();
        personaseis.start();
        /*uso aqui los join para que haya una pelea justa  de todos los hilos por la cochera y por ende el coche*/
         try {
        personauno.join();
        personados.join();
        personatres.join();
        personacuatro.join();
        personacinco.join();
        personaseis.join();
        } catch(InterruptedException e) {}
        
    }
}
