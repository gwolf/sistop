#include <stdlib.h>
#include <stdio.h>
#include <pthread.h>

/* Implementacion para cinco filósofos */
#define COUNT 5

#define PENSANDO 1
#define HAMBRIENTO 2
#define COMIENDO 3

pthread_cond_t VC[COUNT];                      /* Una VC por filósofo */
pthread_mutex_t M = PTHREAD_MUTEX_INITIALIZER; /* Mutex para el monitor */
int estado[COUNT];                             /* Estado de cada filósofo */

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

void palillos_init() {
    int i;

    pthread_mutex_init(&M, NULL);
    for (i = 0; i < COUNT; i++) {
        pthread_cond_init(&VC[i], NULL);
        estado[i] = PENSANDO;
    }
}

void toma_palillos (int i) {
    pthread_mutex_lock(&M);
    estado[i] = HAMBRIENTO;
    actualiza(i);
    while (estado[i] == HAMBRIENTO)
        pthread_cond_wait(&VC[i], &M);
    pthread_mutex_unlock(&M);
}

void suelta_palillos (int i) {
    pthread_mutex_lock(&M);
    estado[i] = PENSANDO;
    actualiza((i - 1) % COUNT);
    actualiza((i + 1) % COUNT);
    pthread_mutex_unlock(&M);
}

void come(int i) {
    printf("El filosofo %d esta comiendo\n", i);
}

void piensa(int i) {
    printf("El filosofo %d esta pensando\n", i);
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
    int indexes[COUNT];

    pthread_t th[COUNT];  /* IDs de los hilos filósofos */
    pthread_attr_t attr;
    pthread_attr_init(&attr);

    palillos_init();

    for (i = 0; i < COUNT; i++) {
        indexes[i] = i;
        pthread_create(th + i, &attr, filosofo, indexes + i);
    }

    for (i = 0; i < 5; i++)
        pthread_join(th[i],NULL);

    return 0;
}
