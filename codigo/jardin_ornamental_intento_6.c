int b1, b2;
/* ... */

/* Proceso 1: */
/* ... */
b1 = 1;
if (b2) {
  esperar();
 }
/* Sección crítica */
cuenta = cuenta + 1;
b1 = 0;
/* ... */
/* Proceso 2: */
/* ... */
b2 = 1;
if (b1) {
  esperar();
 }
/* Sección crítica */
cuenta = cuenta + 1;
b2 = 0;
/* ... */
