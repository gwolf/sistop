/* Programa para a detección de bloqueos

   ***Programa sin terminar***
   La idea del programa era tener dos vectores, un vector Rec para los recursos y otro
   vector Proc para los procesos. En el vector de recursos guardar el estado de cada
   recurso según lo siguiente:
   Estado del recurso:   0 -> Libre     1 -> Asignado
   En el vector de procesos se pondría el proceso y el recurso que tiene asignado, y en
   caso de solicitar un proceso ya asignado se pondría solicitado sumándole 100 a la
   cantidad que se guardaría en el vector, así para números mayores de 100 significa que
   el solamente se solicitó un recurso, no que esté asignado.

   Sin embargo no pude acabar el programa ya que me atoré en la parte de comprobar cuando
   un recurso ya estaba asignado, no me quedó como espere.

    */
#include<stdio.h>
#include<conio.h>

main(){
   //Rec-> Recursos    Proc->Procesos
   int Rec[1000],Proc[1000],Lrec,Lproc,entradaInt,cont=0;
   char entradaChar;
   printf("**Recursos y Procesos**\nDeseas usar la propuesta por default? (Y/N):");
   scanf("%c",&entradaChar);
   if(entradaChar=="Y"||entradaChar=="y"){
      Lrec=6;
      Lproc=6;
   }
   else{
      printf("\n\nCuantos RECURSOS habra en el sistema?(min. 1 - max. 1000): ");
      scanf("%d",&Lrec);
      /*Asignamos como disponibles a los recursos que solicitó*/
      while(cont<Lrec){
         Rec[cont]=0;
         cont++;
      }
      cont=0;
      printf("Cuantos PROCESOS habra en el sistema?(min. 1 - max. 1000): ");
      scanf("%d",&Lproc);
      printf("**Digita a que recurso estara asignado cada proceso: (en caso de no estar asinado a ningun recurso digita 0)\n");
      while(cont<Lproc){
         printf("  Proceso %d?, a recurso ->",cont+1);
         scanf("%d",&entradaInt);
         if(antradaInt!=0){ //Si estará asignado a un recurso


         }


         /*
         if(entradaInt!=0){
            if(Rec[entradaInt-1]==1){
                printf("El recurso ya esta asignado a otro proceso, se pondra como solicitado.");
                Proc[cont]=100+entradaInt;
            }
            else{
                Proc[cont]=entradaInt;
            }
         } */
         cont++;

      }

   }

getch();
}
