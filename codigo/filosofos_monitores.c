/* Implementacion para cinco filósofos */
#define PENSANDO 1
#define HAMBRIENTO 2
#define COMIENDO 3
pthread_cond_t  VC[5]; /* Una VC por filósofo */
pthread_mutex_t M;     /* Mutex para el monitor */
int estado[5];         /* Estado de cada filósofo */

void palillos_init () {
    int i;
    pthread_mutex_init(&M, NULL);
    for (i = 0; i < 5; i++) {
        pthread_cond_init(&VC[i], NULL);
        estado[i] = PENSANDO;
    }
}

void toma_palillos (int i) {
    pthread_mutex_lock(&M)
    estado[i] = HAMBRIENTO;
    actualiza(i);
    while (estado[i] == HAMBRIENTO)
        pthread_cond_wait(&VC[i], &M);
    pthread_mutex_unlock(&M);
}

void suelta_palillos (int i) {
    pthread_mutex_lock(&M)
    estado[i] = PENSANDO;
    actualiza((i - 1) % 5);
    actualiza((i + 1) % 5);
    pthread_mutex_unlock(&M);
}

void come(int i) {
    printf("El filosofo %d esta comiendo\n", i);
}

void piensa(int i) {
    printf("El filosofo %d esta pensando\n", i);
}

/* No incluir 'actualiza' en los encabezados, */
/* es una función interna/privada */
int actualiza (int i) {
    if ((estado[(i - 1) % 5] != COMIENDO) &&
        (estado[i] == HAMBRIENTO) &&
        (estado[(i + 1) % 5] != COMIENDO)) {
        estado[i] = COMIENDO;
        pthread_cond_signal(&VC[i]);
    }
    return 0;
}

void *filosofo(void *arg) {
  int self = *(int *) arg;
  for (;;) {
    piensa(self);
    toma_palillos(self);
    come(self);
    suelta_palillos(self);
  }
}

int main() {
  int i;
  pthread_t th[5];  /* IDs de los hilos filósofos */
  pthread_attr_t attr = NULL;
  palillos_init();
  for (i=0; i<5; i++) 
    pthread_create(&th[i], attr, filosofo, (int*) &i);
  for (i=0; i<5; i++) 
    pthread_join(th[i],NULL);
}
