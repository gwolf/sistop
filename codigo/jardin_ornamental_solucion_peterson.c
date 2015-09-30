int b1, b2;
int quien;

/* Proceso 1: */
/* ... */
b1=1;
quien=2;
if ( b2 && (quien==2)) {
    esperar();
}
/* Sección crítica */
cuenta = cuenta + 1;
b1=0;

/* Proceso 2: */
/* ... */
b2=1;
quien=1;
if ( b1 && quien==1) {
    esperar();
}
/* Sección crítica */
cuenta = cuenta + 1;
b2=0;
