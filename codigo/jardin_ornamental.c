int cuenta;

proceso torniquete1() {
	int i;
	for(i=0;i<20;i++) {
		cuenta = cuenta + 1;
	}
}

proceso torniquete2() {
	int i;
	for(i=0;i<20;i++) {
		cuenta = cuenta + 1;
	}
}

main() {
	cuenta = 0;
	/* Lanzar ambos procesos concurrentemente*/
        concurrentemente { //
		torniquete1();
	        torniquete2();
	}
        /* Esperar a que ambos finalicen */
        esperar(torniquete1);
        esperar(torniquete2);
	printf("Cuenta: %d\n", cuenta);
}
