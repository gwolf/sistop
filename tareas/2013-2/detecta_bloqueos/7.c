/*Sistemas Operativos
Objetivo: Detección de bloqueos */

/*A pesar de que brindó una prorroga de entrega no pude hacer funcionar correctamente el programa,
sin embargo presento aquí un intento, alguna vez escuché durante un examen<<ustedes no se estresen
cualquier número natural es mejor que cero, contesten lo que puedan>>, suena mal pero igual tomaré
la filosofía. Tendré que dedicarle más a la siguiente tarea.*/
#include <stdio.h>
#include <stdlib.h>
typedef struct nodo *APNODO;

    struct nodo{
            char recursoAsignado[20];
            char recursoSolicitado[20];
            APNODO sigte;
     };


void implista(APNODO lista);
/*Con esta función creo nuevos proceso en forma de lista*/
APNODO nuevo(char recAsig[], char recSol[]);
/*La siguiente función busca los bloqueos. Sus limitantes son:
   1. Todos los recursos deben ser asignados pero no es necesario que un proceso
   requiera recursos adicionales. 
   2. No se verifica duplicidad de asignaciones
   3. Solo verifica situaciones en que se presenta un ciclo
   
La función pregunta si requiere más recursos para terminar, como se
supone que todos los recursos han sido asignados si el número de procesos que esperan
recursos para terminar, es igual al número total de procesos activos existirá un bloqueo.*/
void buscarBloqueo(APNODO proceso, int numDeProcesos);



int main(void)
{
   char respuesta='s',escape,asignado[20],solicitado[20];
   int i=0, numDeProcesos=0;
   struct nodo *p,*t,*s,*temporal;
/****************************************/ /****************************************/
                /*Crear primer proceso*/
/***************************************/ /****************************************/
   
   while(respuesta== 's')
   {
      printf("\nIngrese la lista de recursos asignados\n\n");
      i=0;
      while (escape!='n')
      {
         
         printf("\n\nIngrese recurso %d ",i+1);
         asignado[i]=getch();
         printf("\n\nRecurso asignado: %c\n",asignado[i]);
         i++;
         printf("\n\nDesea asignar otro recurso? s/n \n");
         escape= getch();
         if (escape=='n')asignado[i]='\0';
      }
      escape= 's';
      while(escape== 's')
      {
         printf("\n\nDesea ingresar solicitud? s/n \n");
         escape= getch();
         if(escape=='n')
         {
            asignado[i]='\0';break;
         }
         i=0;
         printf("\n\nIngrese la lista de recursos solicitados\n\n");
         while (escape!='n')
         {
            printf("\n\nIngrese el recurso solicitado %d \n",i+1);
            solicitado[i]=getch();
            i++;
            printf("\n\nDesea solicitar otro recurso? s/n \n");
            escape= getch();
            
         }
         
         i=0;
      }
       /*en P es una apuntador al primer proceso*/
       p=nuevo(asignado,solicitado);
       t=p;/*Crear una copia del primer proceso para pasar la dirección al siguiente */
       printf("\n\n\tDesea crear otro proceso s/n \n\n\t");
       respuesta=getch();
       numDeProcesos++;
       if(respuesta=='s')break;
   }
    /****************************************/
    //Aquí se crean los siguientes procesos de ser el caso.
    /***************************************/
   
    while(respuesta== 's')
   {
      printf("\nIngrese la lista de recursos asignados\n\n");
      escape='o';
      i=0;
      while (escape!='n')
      {
         
         printf("\n\nIngrese recurso %d ",i+1);
         asignado[i]=getch();
         printf("\n\nRecurso asignado: %c\n",asignado[i]);
         i++;
         printf("\n\nDesea asignar otro recurso? s/n \n");
         escape= getch();
         if (escape=='n')asignado[i]='\0';
      }
      escape= 's';
      while(escape== 's')
      {
         printf("\n\nDesea ingresar solicitud? s/n \n");
         escape= getch();
         if(escape=='n')
         {
            asignado[i]='\0';break;
         }
         i=0;
         printf("\n\nIngrese la lista de recursos solicitados\n\n");
         while (escape!='n')
         {
            printf("\n\nIngrese el recurso solicitado %d \n",i+1);
            solicitado[i]=getch();
            i++;
            printf("\n\nDesea solicitar otro recurso? s/n \n");
            escape= getch();
         }
         
         i=0;
      }
/********************//********************//********************//********************/
//En esta parte del código se ligan los procesos <<s>> recibirá el proceso de recien creación
// <<t>> tomará la dirección del proceso en su campo <<sigte>>, así apunta hacia el sig proceso
//cuando <<t>> se transforma en <<s>>, <<s>> en su campo sigte apuntara al s+1.
/********************//********************//********************//********************/
       s=nuevo(asignado,solicitado);
       numDeProcesos++;
       t->sigte=s;
       t=s;
       printf("\n\n\tDesea crear otro proceso s/n \n\n\t");
       respuesta=getch();
       
       
   }
    printf("\n\nProcesos creados.\n\n");
    implista(p);
    printf("\n\tNumero de proceso crados%d",numDeProcesos);

    getch();
    return 0;
    
}
/******************************************************/
/*Definición de funciones*/

void implista(APNODO lista)
{
     int i=0;
     for(;lista->sigte!=NULL; lista=lista->sigte)
     {   
         for (lista->recursoAsignado[0];lista->recursoAsignado[i]!='\0';i++)
         {
            printf("\nRecurso [%d]: \n %c\n\n",i,lista->recursoAsignado[i]);
         }
     }
     
     
}

APNODO nuevo(char recAsig[],char recSol[])
{
       APNODO aprnvo;
       int i=0;
       aprnvo=(APNODO)malloc(sizeof(struct nodo));
       while(recAsig[i]!='\0')
       {
         aprnvo->recursoAsignado[i]=recAsig[i];
         
         i++;
      }
      i=0;
      while(recSol[i]!='\0')
       {
         aprnvo->recursoSolicitado[i]=recSol[i];
         i++;
      }
       aprnvo->sigte=NULL;
       return aprnvo;
}

void buscarBloqueo(APNODO proceso, int numDeProcesos)
{
    int bloqueo=0;
    for(;proceso->sigte!=NULL; proceso=proceso->sigte)
     {   
         if(proceso->recursoSolicitado[0]!='\0')
         {
            bloqueo++;   
         }
     }
     if (bloqueo==numDeProcesos)printf("\n\n\tExiste bloqueo");
}


/* Evaluación */

/* Haces un buen uso de estructuras, al usar una lista ligada, puedes
   tener una cantidad arbitraria de procesos en el sistema - ¡Bien!
   Podrías haber (si fuera para el empleo en una situación real)
   manejado también listas ligadas para los recursos, dado que podrían
   ser más de 20 (y para no ocupar de fijo 20+20 caracteres que
   podrían ahorrarse), pero es válido como lo presentas.

   No me queda del todo clara la lógica de tu función
   "buscarBloqueo(APNODO, int)". Si bien al crear un nuevo proceso (
   APNODO nuevo(char, char) ) sí registras recursos asignados y
   solicitados, en esta función sólo evalúas los solicitados. Recuerda
   que un bloqueo se produce cuando tienes un ciclo inescapable, en el
   que hay recursos asignados a un proceso que están siendo
   solicitados por otro, y recursos asignados al otro que están siendo
   solicitados por el primero (o un ciclo más ampliado). Un ciclo de
   recursos solicitados *puede llevar a* un bloqueo, pero no lo
   implica necesariamente.
*/ 
