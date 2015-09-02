int bandera; /* 0 => desocupada */

while (++bandera != 1) {
  bandera--; /* Debe generar "INC" */
 }
/* Sección crítica */
cuenta = cuenta + 1;

bandera--;
