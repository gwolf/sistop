#include <stdio.h>
#define LONGITUD 1024
#define VECES 10

unsigned long timestamp(){
  /* RDTSCP entrega el valor del contador de tiempo del CPU (TSC), obligando */
  /* a la serialización (evitando el reordenamiento de instrucciones). */
  /* Siendo un valor de 64 bits, se recupera de los registros RDX y RAX. */
  /* */
  /* Referencias: */
  /* https://ccsl.carleton.ca/~jamuir/rdtscpm1.pdf */
  /* http://www.strchr.com/performance_measurements_with_rdtsc */
  /* https://stackoverflow.com/questions/12631856/difference-between-rdtscp-rdtsc-memory-and-cpuid-rdtsc */
  long tsc;
  asm volatile("rdtscp; "         /* Lectura serializada del TSC */
	       "shl $32, %%rdx; " /* Recorre 32 bits bajos de RDX a izq. */
	       "or %%rdx, %%rax"  /* Combina RDX y RAX */
	       : "=a"(tsc)        /* Obtiene el valor en la variable tsc */
	       :
	       : "%rcx", "%rdx"   /* Registros que son afectados */
	       );
  return tsc;
}

void llena_arreglo(int modo) {
  int data[LONGITUD][LONGITUD];
  int x, y;
  for (x=0; x < LONGITUD; x++)
    for (y=0; y < LONGITUD; y++)
      if (modo)
	data[y][x] = 1;
      else
	data[x][y] = 1;
}

int main(){
  unsigned long inicio, fin, prom_h, prom_v;
  printf( "Usando %lu bytes de memoria\n", LONGITUD*LONGITUD*sizeof(int));
  prom_h = 0;
  prom_v = 0;
  int i;
  
  for (i=0; i < VECES; i++) {
    inicio = timestamp();
    llena_arreglo(0);
    fin = timestamp();
    prom_h += (fin-inicio);
    printf("De %lu a %lu: %lu\n", inicio, fin, fin - inicio);
  }
  printf("Promedio (horizontal): %lu\n", prom_h / VECES);

  printf("=========\n");
  for (i=0; i < VECES; i++) {
    inicio = timestamp();
    llena_arreglo(1);
    fin = timestamp();
    prom_v += (fin-inicio);
    printf("De %lu a %lu: %lu\n", inicio, fin, fin - inicio);
  }
  printf("Promedio (vertical): %lu\n", prom_v / VECES);
  printf("\nRelación (horiz / vert): %f\n", (float) prom_h / prom_v);
  return(0);
}
