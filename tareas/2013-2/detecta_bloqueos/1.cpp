/*Profesor el esquema que use para los bloqueos fue el visto en clase
compilado en Code blocks 10.05*/

#include <stdio.h>
#include <conio.h>
#include <stdlib.h>


 int main(){
     int a[2][2]={0,1},b[2][2]={3,4},c[2][2]={5,4},d[2][2]={4,7},e[2][2]={7,5},f[2][2]={0,6};


    char rec;
    printf("Que recurso desea saber sobre su estado? (a, b, c, d, e, f )\n");
    scanf("%c",&rec);

    switch(rec){
        case 'a':
            if (a[0][0] == b[0][1])
                printf("El recurso esta bloqueado\n");

                else{
                     if (a[0][0] == c[0][1])
                     printf("El recurso esta bloqueado por c\n");
                        else
                         if (a[0][0] == d[0][1])
                        printf("El recurso esta bloqueado por d\n");
                            else
                             if (a[0][0] == e[0][1])
                            printf("El recurso esta bloqueado por e\n");
                                else
                                 if (a[0][0] == f[0][1])
                                printf("El recurso esta bloqueado por f\n");

                                else

                    printf("El recurso esta libre\n");

            }



            break;
        case 'b':
                   if (b[0][0] == a[0][1])
                printf("El recurso esta bloqueado por a\n");

                else{
                     if (b[0][0] == c[0][1])
                     printf("El recurso esta bloqueado por c\n");
                        else
                         if (b[0][0] == d[0][1])
                        printf("El recurso esta bloqueado por d\n");
                            else
                             if (b[0][0] == e[0][1])
                            printf("El recurso esta bloqueado por e\n");
                                else
                                 if (b[0][0] == f[0][1])
                                printf("El recurso esta bloqueado por f\n");

                                else

                    printf("El recurso esta libre\n");
                }

            break;
        case 'c':
                   if (c[0][0] == a[0][1])
                printf("El recurso esta bloqueado por a\n");

                else{
                     if (c[0][0] == b[0][1])
                     printf("El recurso esta bloqueado por b\n");
                        else
                         if (c[0][0] == d[0][1])
                        printf("El recurso esta bloqueado por d\n");
                            else
                             if (c[0][0] == e[0][1])
                            printf("El recurso esta bloqueado por e\n");
                                else
                                 if (c[0][0] == f[0][1])
                                printf("El recurso esta bloqueado por f\n");

                                else

                    printf("El recurso esta libre\n");
                }

            break;
        case 'd':
                   if (d[0][0] == a[0][1])
                printf("El recurso esta bloqueado por a\n");

                else{
                     if (d[0][0] == c[0][1])
                        printf("El recurso esta bloqueado por c\n");
                            else
                        if (d[0][0] == b[0][1])
                        printf("El recurso esta bloqueado por b\n");
                            else

                             if (d[0][0] == e[0][1])
                            printf("El recurso esta bloqueado por e\n");
                                else
                                 if (d[0][0] == f[0][1])
                                printf("El recurso esta bloqueado por f\n");

                                else

                    printf("El recurso esta libre\n");
                }

            break;
        case 'e':
                   if (e[0][0] == a[0][1])
                printf("El recurso esta bloqueado por a\n");

                else{
                     if (e[0][0] == b[0][1])
                     printf("El recurso esta bloqueado por b\n");
                        else
                         if (e[0][0] == c[0][1])
                        printf("El recurso esta bloqueado por c\n");
                            else
                             if (e[0][0] == d[0][1])
                            printf("El recurso esta bloqueado por d\n");
                                else
                                 if (e[0][0] == f[0][1])
                                printf("El recurso esta bloqueado por f\n");

                                else

                    printf("El recurso esta libre\n");
                }

            break;
        case 'f':
                   if (f[0][0] == a[0][1])
                printf("El recurso esta bloqueado por a\n");

                else{
                     if (f[0][0] == b[0][1])
                     printf("El recurso esta bloqueado por b\n");
                        else
                         if (f[0][0] == c[0][1])
                        printf("El recurso esta bloqueado por c\n");
                            else
                             if (f[0][0] == d[0][1])
                            printf("El recurso esta bloqueado por d\n");
                                else
                                 if (f[0][0] == e[0][1])
                                printf("El recurso esta bloqueado por e\n");

                                else

                    printf("El recurso esta libre\n");

                }

            break;

        default:
            printf("No existe ese recurso\n");
            break;



    }

system ("pause");
return 0;
 }

/* Evaluación: */

/* El programa es muy rígido, está hecho para evaluar a seis (y no
   más, y no menos que seis) procesos. No me estás indicando el
   formato de entrada, así que no puedo cambiar sus parámetros, está
   trabajando sobre una fotografía dada del sistema ya dada.*/

/* El bloqueo mutuo se produce entre (al menos) dos procesos y dos
   recursos; no me sirve saber si un recurso específico está bloqueado
   por un proceso específico, sino que encontrar ciclos - Esto es, tu
   programa me dice:*/

/* Que recurso desea saber sobre su estado? (a, b, c, d, e, f )
   c
   El recurso esta bloqueado por e

   Cuando en realidad un bloqueo se produce cuando A tiene asignado al
   recurso 1, B al recurso 2, A solicita al recurso 2, y B solicita al
   recurso 1. Hacen falta cuando menos cuatro relaciones para que se
   declare un bloqueo. */
