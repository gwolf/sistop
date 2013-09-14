/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package carro_cochera_semaforos;

import java.util.concurrent.Semaphore;

public class carro_entra extends Thread{
    
 protected Semaphore s1;    
 protected Semaphore s2;
 
 public carro_entra(Semaphore r, Semaphore s)
 {
 this.s1 =r;
 this.s2 = s;
 
 }
 
 public void run()
         {
 
      try{  
          s1.acquire();}
      catch(Exception e){;}
      
        for(int j=0;j<=10; j++)       
        System.out.println("Estoy entrando");
        
         try{sleep(100);}
         catch(Exception e)
         {;}
         
         s1.release();
         s2.release();
         
         }
        
        
             
             
             
        }