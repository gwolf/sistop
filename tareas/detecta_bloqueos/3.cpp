//NOTA: el programa no corre pues por que pense q prodria hacer algo mejor, no me salio con arreglos q creo era mas eficiente
// y con Python tampoco me salio, tampoco sabia como hacer listas en C :(
//solo mando el programa asi por cuestines de tiempo ya q no creo poder arreglarlo

#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{ int A[1][2]={0,1}, B[1][2][2][2]={3,4,1,6}, C[1][3][2]={5,4,2}, D[1][3]={4,7}, E[1][3]={7,5}, F[1][3]={0,6};


    char proceso;
    printf("Ingresa uno de los siguientes procesos y te diré si esta bloqueado por algun otro:\nA, B, C, D, E, F\n");
    scanf("%c",&proceso);

    switch(proceso){
    
    case 'A':
    if (A[0][1] == B[0][1][0][0])
    printf("El proceso A esta bloqueado por el proceso B, ya que el proceso B tiene asignado el proceso 1 y es el mismo que pide A\n");
    else printf ("No hay bloqueo en el proceso A");

    
    case 'B':
    if (B[4][1][3][6] == A[0][1])
    printf("El recurso esta bloqueado por A\n");
    else{
         if (B[4][1][3][6] == D[7][4])
         printf("El recurso esta bloqueado por D\n");
    else
        if (B[4][1][3][6] == C[5][4][2])
        printf("El proceso B esta bloqueado por el recurso 4 de B\n");
    else
        if (B[4][1][3][6] == F[0][6])
        printf("El proceso B esta bloqueado por el recurso 6 de F\n");
    else
    printf("No hay bloqueo en el proceso B\n"); }
                    
                    
    case 'C':
    if (C[2][5][4] == A[0][1])
    printf("El proceso D no esta bloqueado por ningun reurso de B\n");
    else {
         if (C[2][5][4] == D[7][4])
         printf("El proceso C esta bloqueado por el recurso 4 de D\n");
    else
        if (C[2][5][4] == E[7][5])
        printf("El proceso C esta bloqueado por el recurso 5 de E\n");
    else
    printf("No hay bloqueo en el proceso C\n"); }

    case 'D': if (D[7][4] == C[5][4][2])
         printf("El proceso D esta bloqueado por el recurso 5 de C\n");
    else {
                     
    
        if (D[7][4] == B[1][4][3][6])
        printf("El proceso D esta bloqueado por el recurso 4 de B\n");
    else
        if (D[7][4] == E[7][5])
        printf("El proceso D esta bloqueado por el recurso 7 del proceso E\n");
    else
    printf("No hay bloqueo en el proceso D\n"); }
    
    
    case 'E':   
    if (E[7][5] == C[4][5][2])
    printf("El proceso E esta bloqueado por el recurso 5 del proceso C\n");
    else{
         if (E[7][5] == D[7][4])
         printf("El proceso E esta bloqueado por el recurso 7 del proceso D\n");
    else
    printf("No hay bloqueo en el proceso E\n"); }
    
    
    case 'F': 
    if (F[0][6] == B[1][6][3][4])
    printf("El proceso F esta bloqueado por el recurso 6 del proceso B\n");
    else{ 
    printf("No hay bloqueo en el proceso F\n"); }
    
    break; }
    
getchar();
return 0;
}

/* Evaluación: */

/* Si bien tu programa presenta la respuesta correcta ante la
   situación específica planteada, no es un verdadero algoritmo en
   tanto que no reacciona correctamente a una situación distinta: Por
   más que yo modificara los arreglos de inicio, dado que tienes las
   respuestas rígidas pre-programadas, no puede detectar ninguna
   situación que no fuera la planteada. */

/* La estructura básica sobre la cual deberías haber centrado tu
   análisis es un ciclo "for" o "while", no un "case" o "if". Si
   definieras tus procesos sobre el arreglo "procs", podrías hacer un
   recorrido sobre todos los procesos en "procs" (excepto cuando
   procs[i] == proceso) y procesar cada uno de sus recursos
   solicitados y asignados. */
