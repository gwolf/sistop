/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package carro_cochera_semaforos;

import java.util.concurrent.Semaphore;

public class carro_sale extends Thread{
        
 protected Semaphore s2;
 
 public carro_sale(Semaphore r)
 {
 this.s2 =r;
 
 }
 
 public void run()
         {
 
      try{  
          s2.acquire();}
      catch(Exception e){;}
      
        for(int j=0;j<=10; j++)       
        System.out.println("Estoy saliendo");
        
         try{sleep(100);}
         catch(Exception e)
         {;}
         
         s2.release();
         
         }
        
        
             
             
             
        }