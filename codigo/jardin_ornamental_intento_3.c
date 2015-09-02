int bandera = 0; /* 0 => región crítica libre, 1 => ocupada */
int cuenta = 0;
/* ... */

/* Torniquete1 */
/* ... */
if (bandera) wait;
/* Aquí bandera=0 */
bandera = 1; /* Inicio de la sección crítica */
cuenta = cuenta + 1;
bandera = 0; /* Fin de la sección crítica */
