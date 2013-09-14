/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package carro_cochera_semaforos;

import java.util.concurrent.Semaphore;

public class Carro_cochera_semaforos {

    
    public static void main(String[] args) {
        // TODO code application logic here

     Semaphore semaforo1 = new Semaphore(0,true);
     Semaphore semaforo2 = new Semaphore(0,true);
     
     
     (new Thread (new carro_entra(semaforo1,semaforo2))).start();
     (new Thread (new cochera_abre(semaforo1))).start();
     (new Thread (new carro_sale(semaforo2))).start();
     (new Thread (new cochera_cierra(semaforo2))).start();
     
     
    
    }
}
