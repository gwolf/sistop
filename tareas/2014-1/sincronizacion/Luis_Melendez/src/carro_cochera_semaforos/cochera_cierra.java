/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package carro_cochera_semaforos;

import java.util.concurrent.Semaphore;

public class cochera_cierra extends Thread{
    
 protected Semaphore s2;    
 
 
 public cochera_cierra(Semaphore r)
 {
 this.s2 =r;
 }
 
 public void run()
         {
 
     try{  
          s2.acquire();}
      catch(Exception e){;}
     
        
      for(int j=1;j<=10;j++)
      System.out.println("Cerrando cochera");
        
        
        try{sleep(100);}
         catch(Exception e)
         {;}
         
         s2.release();
   
     
           }
        
        
             
             
             
        }
 
    