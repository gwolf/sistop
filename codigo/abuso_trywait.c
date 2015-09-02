while (sem_trywait(semaforo) != 0) {}
seccion_critica();
sem_post(semaforo);


/* O peor aún: */
/* Cruzamos los dedos... a fin de cuentas, ejecutaremos con baja frecuencia! */
seccion_critica();
