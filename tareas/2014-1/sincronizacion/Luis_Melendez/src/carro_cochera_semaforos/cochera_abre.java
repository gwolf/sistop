/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package carro_cochera_semaforos;

import java.util.concurrent.Semaphore;

public class cochera_abre extends Thread{
    
 protected Semaphore s1;    
 
 public cochera_abre(Semaphore r)
 {
 this.s1 =r;
 }
 
 public void run()
         {
 
     /* try{  
          s1.acquire();}
      catch(Exception e){;}
      */
        
      for(int j=1;j<=10;j++)
      System.out.println("Abriendo cochera");
        
        
        try{sleep(100);}
         catch(Exception e)
         {;}
         
         s1.release();
   
     
         
         
         
         }
        
        
             
             
             
        }
 
    
