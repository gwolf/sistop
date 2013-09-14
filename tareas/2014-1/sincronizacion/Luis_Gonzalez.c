#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <semaphore.h>
//Gonzalez Alegria Luis Armando
//Sistemas operativos
//tarea: Garage automatico
//intente implementar un proceso padre que creara un hijo para poder
//abrir y cerrar la puerta, tambien hacer entrar y salir el coche,
//no entendi lo de la bateria baja
sem_t *sem_1, *sem_2, *sem_3; //apuntadores para los semaforos

int main(void)
{
  int i=1;
  pid_t hijo;
  int val;

  printf("Creando semaforos... \n");
  //comprobar y crear semaforos
  sem_1=sem_open("/sem_1", O_CREAT, 0644, 1);//semaforo puerta
  if(sem_1==(sem_t*)-1)
    perror("Error creando semaforo 1");

  sem_2=sem_open("/sem_2", O_CREAT, 0644, 0);//semaforo coche
  if(sem_2==(sem_t*)-1)
    perror("Error creando semaforo 2");

  sem_3=sem_open("/sem_3", O_CREAT, 0644, 0);//semaforo estorbo
  if(sem_3==(sem_t*)-1)
    perror("Error creando semaforo 3");

  printf("creando proceso hijo... \n");
  sem_close(sem_2);//libero semaforo 2 y 3
  sem_close(sem_3);
  hijo=fork();
  switch(hijo)
  {
    case -1:
      printf("error creando proceso hijo\n");
        exit(0);
    case 0:
      printf("el hijo\n");
      if(i==1)
      {
        sem_wait(sem_1); sem_wait(sem_3);
        printf("abre puerta %d\n",i);
        sleep(1);
        i++;
        sem_post(sem_1);
      }
      if(i==3)
      {
       sem_wait(sem_1); sem_wait(sem_3);
       printf("cierra puerta %d\n",i);
       sleep(1);
       i++;
       sem_post(sem_1);
      }
      sem_close(sem_1);
      sem_close(sem_2);
      sem_close(sem_3);
      printf("soy hijo y termino...\n");
      break;
    default:
      printf("el padre\n");
      if(i==2)
      {
        sem_wait(sem_2); sem_wait(sem_3);
        printf("coche entra\n");
        sleep(1);
        i++;
        sem_post(sem_2);
      }
      if(i==4)
      {
        sem_wait(sem_2); sem_wait(sem_3);
        printf("coche sale\n");
        sleep(1);
        i=1;
        sem_post(sem_2);
      }
      sem_close(sem_1);
      sem_close(sem_2);
      sem_close(sem_3);
      printf("soy padre y termino...\n");
      wait(0);
      printf("soy el padre, termino semaforos y termino...\n");
      sem_unlink("/sem_3");
      sem_unlink("/sem_2");
      sem_unlink("/sem_1");
  }
  exit(0);
}
