#include<stdio.h>
#include<stdlib.h>
#define p printf


main(){
       
     int procesos[6];
     int rec[7];
     int solic[4];
     int solicj[4];
     int solick[4];
     int a,b,c,v;
     int r,n,w,l,i,j,z,m;                                                                   
     p("Dame los 7 Recursos: \n\n");    //Aqui se piden los 7 recursos a Utilizar           

       a=0;
       for(n=0;n<7;n++)
       {
                       a++;
                        p("dame el numero [%d]: ",a);
                         scanf("%d",&rec[n]);
}
   
      p("Dame los 6  Procesos: \n\n");
      
      for(v=1;v<7;v++){                  //Aqui se piden los 6 Procesos a Realizar(se piden por numero no con letras)
                                         //es  decir 1,2,3,4,...6 diferenciando cada uno con un enter
      p("\n\nProceso [%d]: ",v);  
      p("\nCuantos recursos necesita para ejecutarse totalmente: "); 
      scanf("%d",&b);             
      p("\nCuantos recursos tiene asignados este Proceso actualmente:");
      scanf("%d",&m);
      if(m>0){ 
      for(i=0;i<m;i++){
      p("Cuales son los recursos asignados: ",i);  // Se deben ingresar bien los numeros
       scanf("%d", &rec[i]);
       }
       }
    
        p("Cuantos recursos solicita para terminar su ejecucion: ");
        scanf("%d",&z);
    
      if(b==m){
                  p("Este Proceso esta completo: \n\n");
                  p("Estan Liberados los Recursos de este proceso");
                        }
                        
                        else{
                             for(i=0;i<z;i++){
                        p("Cuales son esos recursos:",i);
                        scanf("%d", &solic[i]);
                        }

}
}                                              //acabando el sistema  se debe dar un 1 y un enter para que finalice el sistema
        p("\nPresiona 1 y enter para Finalizar");

  scanf("%d",&procesos[l]);

p("\n\n\tEn este sistema no hay Bloqueo\n\n");


                  
 system("pause");

     }
     
 
     
/* Evaluación */

/* La lógica está incompleta: Detecta correctamente algunos casos en
   que no hay bloqueo (como cuando los procesos tienen todos los
   recursos que van a requerir), pero nunca llega a detectar un
   bloqueo. */

/* Como comentarios de estilo: Tu programa está escrito con variables
   de nombre corto, pero muy poco descriptivo. Si bien «i» es un
   nombre universalmente aceptado como contador, las variables a, b,
   c, v, r, n, w, l, j, z y m no significan nada. De hecho, muchas de
   ellas no son siquiera empleadas (y apuntan a que el programa está
   incompleto). */
