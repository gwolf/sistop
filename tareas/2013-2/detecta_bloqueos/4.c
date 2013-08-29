/** PROGRAMA DE DETECCION DE BLOQUEO */

#include <stdio.h>
#define Proc 20
#define Recu 20

void sinSolicitud(int solicitado[Proc][Recu], int asignado[Proc][Recu], int proceso[Proc],int pro, int rec);
void sinBloqueo(int solicitado[Proc][Recu], int asignado[Proc][Recu], int proceso[Proc], int pro, int rec);

void main()
{
   int asignado[Proc][Recu] = {0};
   int solicitado[Proc][Recu] = {0};
   int proceso[Proc];
   int i,j,l,a,pro,rec,cont;

   printf("Cuantos Procesos existen \n");
   scanf("%d",&pro);

   printf("Cuantos Recursos existen \n");
   scanf("%d",&rec);

   l = 65;
   for(i=0; i<pro; i++)
   {
      printf("Ingrese los recursos asignados, con enter entre ellos y complete con cero si es necesario \n");
      printf("Ingrese los recursos asignados al proceso %c \n",l+i);
      for(j = 0;j<rec;j++)
      {
         scanf("%d,",&asignado[i][j]);
      }
      system("cls");
   }

   l = 65;
   for(i=0; i<pro; i++)
   {
      printf("Ingrese los recursos solicitados, con enter entre ellos y complete con cero si es necesario \n");
      printf("Ingrese los recursos solicitados al proceso %c \n",l+i);
      for(j = 0;j<rec;j++)
      {
         scanf("%d,",&solicitado[i][j]);
      }
      system("cls");
   }

   sinSolicitud(solicitado,asignado,proceso,pro,rec);

   for(a=0; a<pro; a++)
   {
      sinBloqueo(solicitado,asignado,proceso,pro,rec);
   }
   cont = 0;
   for(i=0; i<pro; i++)
   {
      if(proceso[i] != 0)
         cont++;
   }

   if(cont == 0)
      printf("NO EXISTE BLOQUEO \n");
   else
   {
      printf("EXISTE BLOQUEO EN  ");
      l = 65;
      for(i=0;i<pro;i++)
      {
         if(proceso[i] != 0)
            printf("%c, ",l+i);
      }
   }
   getch();
}

void sinSolicitud(int solicitado[Proc][Recu], int asignado[Proc][Recu], int proceso[Proc], int pro,int rec)

{
   int i,j,c,k;
   for(i=0;i<pro;i++)
   {
      c = 0;
      for(j=0;j<rec;j++)
      {
         if(solicitado[i][j]!=0)
         {
            c++;
         }
      }
      if(c==0)
      {
         proceso[i] = 0;
         for(k=0;k<rec;k++)
         {
            asignado[i][k] = 0;
         }
      }
      else
         proceso[i] = 1;
   }
}

void sinBloqueo(int solicitado[Proc][Recu], int asignado[Proc][Recu], int proceso[Proc], int pro, int rec)
{
   int i,j,c,k,h,g;

   for(i=0;i<pro;i++)
   {
      c = 0;
      for(j=0;j<rec;j++)
      {
         for(h=0;h<pro;h++)
         {
            for(g=0;g<rec;g++)
            {
               if(solicitado[i][j] != 0)
               {
                  if(solicitado[i][j] == asignado[h][g])
                  {
                     c++;
                  }
               }
            }
         }
      }
      if(c==0)
      {
         proceso[i] = 0;
         for(k=0;k<rec;k++)
         {
            asignado[i][k] = 0;
         }
      }
      else
         proceso[i] = 1;
   }
}

/* Evaluación */

/* Muy bien. Código claro y simple. Podría sugerirte algunas mejorías, como: */


/*  - Si sólo hay un proceso, o sólo hay un recurso (o cero), no
      tienes que pedir más datos: No podría producirse un bloqueo.

    - Verificación de límites. Definiste tanto Proc como Recu a 20;
      ¿qué pasa cuando le indico, por ejemplo, que tiene 2 procesos
      pero 25 recursos?


Cuantos Procesos existen
2
Cuantos Recursos existen
25
Ingrese los recursos asignados, con enter entre ellos y complete con cero si es necesario
Ingrese los recursos asignados al proceso A
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
1
sh: 1: cls: not found
Ingrese los recursos asignados, con enter entre ellos y complete con cero si es necesario 
Ingrese los recursos asignados al proceso B 
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
2
sh: 1: cls: not found
Ingrese los recursos solicitados, con enter entre ellos y complete con cero si es necesario
Ingrese los recursos solicitados al proceso A
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
2
sh: 1: cls: not found
Ingrese los recursos solicitados, con enter entre ellos y complete con cero si es necesario
Ingrese los recursos solicitados al proceso B
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
0
1
sh: 1: cls: not found
NO EXISTE BLOQUEO*/


/* Pero bueno, ambos casos los hice claramente para probar si se rompía. */

/* Por otro lado: Tu función sinBloqueo tiene una eficiencia O(n⁴), es
   muy cara. ¿Se te ocurre una manera de realizar la búsqueda en menor
   tiempo? Toma en cuenta que, si tienes cientos de procesos en
   ejecución y decenas de recursos, ejecutar este algoritmo muchas
   veces por segundo puede resultar demasiado caro.

   ¡Muy bien!*/
