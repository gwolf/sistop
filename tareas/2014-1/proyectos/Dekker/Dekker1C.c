/*
###############################################
###############################################
##############  Para compilar: ################
####### gcc file.c -o file -pthread ###########
###############################################
###############################################
*/

#include<stdio.h> 
#include<stdlib.h> //Para usar malloc
#include<pthread.h> //Necesaria para threading en POSIX

int *turno , *saldo;

void *proc1(void *id){ //Suma dos al saldo
  while(*saldo < 100){
    while(*turno == 2);
      printf("\nSaldo en 1 = %d",*saldo);
      *saldo = (*saldo +2);
      *turno = 2;
      nanosleep((struct timespec[]){{0, 500000}}, NULL);
  }
  return NULL;
}

void *proc2(void *id){ //Resta 1 al saldo
  while(*saldo < 100){
    while(*turno == 1);
    printf("\nSaldo en 2 = %d", *saldo);
    *saldo -= 1;
    *turno = 1;
    nanosleep((struct timespec[]){{0, 500000}}, NULL);
  }
  return NULL;
}


void main(){
  pthread_t t1, t2;

  //Variables and stuff
  turno = (int*)malloc(sizeof(int));
  *turno = 1;
  saldo = (int*)malloc(sizeof(int));
  *saldo = 13;
  
  //Engendramos nuevos hilos
  pthread_create(&t1, NULL, proc1, NULL);
  pthread_create(&t2, NULL, proc2, NULL);
  
  //Se espera a terminar cada proceso, de lo
  //contrario llega al fin del main y sale.
  pthread_join(t1, NULL);
  pthread_join(t2, NULL);

  printf("\n-----------------------\n\
             Saldo al terminar los dos procesos: %d\n\n", *saldo);

  //Save the mallocs, free them all!!
  free(saldo);
  free(turno);
}
