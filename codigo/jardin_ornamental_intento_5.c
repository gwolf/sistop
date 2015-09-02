int turno = 1; /* Inicialmente el turno es del proceso 1 */

/* Ahora el código del proceso 1 contendría algo como: */
while (turno != 1) {
  esperar(); /* ¿Otro proceso? */
 }
/* Sección crítica */
cuenta = cuenta + 1;
turno = 2;

/* Y el del proceso dos: */
while (turno != 2) {
  esperar();
 }
/* Sección crítica */
cuenta = cuenta + 1;
turno = 1;
