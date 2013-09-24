#include <stdio.h>
#include <pthread.h>
#include <unistd.h>

#define NUM_CRUZANDO 100  //Número de personas-autos que cruzarán
#define TIEMPO_ESPE 500000 //Tiempo de espera para los autos y las personas

/* Programa que implementa hilos de una cochera
 *
 * Implementa hilos que controlen el siguiente sistema:
 *
 * La cochera de casa es de portón de apertura automática
 *
 * Una vez que la puerta comienza a abrir, tarda x tiempo en quedar abierta
 *
 * Una vez que la puerta comienza a cerrar, tarda x tiempo en quedar cerrada
 *
 * El coche toma cierto tiempo en entrar y salir. Particularmente si hay peatones o vehículos cruzando frente a la puerta, tienes que esperar a que terminen de pasar.
 *
 * La batería del control está muy débil, por lo que cuando llegas tienes que pedirle a otro actor que abra y cierre por tí. Cuando te vas también necesitas esta ayuda.
 *
 * Si el coche es golpeado por la puerta, se abolla y hay que llevarlo al taller. No quieres que eso ocurra.
 *
 * */

pthread_mutex_t mut_cochera;
pthread_mutex_t mut_salida_llegada;

void accionar_puerta(int);
void *coche_sale();
void *coche_entra();
void actor_acciona_puerta(int);
void *peaton_cruzando();
void *vehiculo_cruzando();




int main()
{

    // Inicializa Mutex
    pthread_mutex_init(&mut_cochera, 0);
    pthread_mutex_init(&mut_salida_llegada, 0);

    //Creación de hilos
    pthread_t peaton, cocheSal, vehiculos, cocheLlega;
    pthread_create(&peaton, 0, peaton_cruzando, 0);
    pthread_create(&cocheSal, 0, coche_sale, 0);
    pthread_create(&vehiculos, 0, vehiculo_cruzando, 0);
    pthread_create(&cocheLlega, 0, coche_entra, 0);

    //Ejecución de hilos
    pthread_join(peaton, 0);
    pthread_join(vehiculos, 0);
    pthread_join(cocheSal, 0);
    pthread_join(cocheLlega, 0);


    printf("\n\n");

    return 0;
}




void *coche_sale()
{
    pthread_mutex_lock(&mut_salida_llegada); //Verifica que solo pueda entrar o salir a la vez.

    actor_acciona_puerta(0);            //Abre puerta

    pthread_mutex_lock(&mut_cochera);   //Verifica que no pasen autos y peatones
    printf("\n\t\tAuto saliendo");
    sleep(3);
    printf("\n\t\tAuto afuera");
    pthread_mutex_unlock(&mut_cochera); //Avisa que los autos pueden seguir pasando

    actor_acciona_puerta(1);             //Cierra puerta

    pthread_mutex_unlock(&mut_salida_llegada); //Indica que ya se puede entrar

    pthread_exit(0);
}

void *coche_entra()
{
    pthread_mutex_lock(&mut_salida_llegada); //Verifica que solo pueda entrar o salir a la vez.

    actor_acciona_puerta(0);            //Abre puerta
    pthread_mutex_lock(&mut_cochera);   //Verifica que no pasen autos y peatones
    printf("\n\t\tAuto entrando");
    sleep(3);
    printf("\n\t\tAuto adentro");
    pthread_mutex_unlock(&mut_cochera); //Avisa que los autos pueden seguir pasando

    actor_acciona_puerta(1);             //Cierra puerta

    pthread_mutex_unlock(&mut_salida_llegada); //Indica que ya se puede entrar

    pthread_exit(0);

}


void actor_acciona_puerta(int accion)
{
    accionar_puerta(accion);
}


void accionar_puerta(int accion)
{
    if(accion == 0) //verifica acción a realizar
        printf("\n\t\tAbriendo puerta");
    else
        printf("\n\t\tCerrando puerta");
    sleep(1);
    if(accion == 0) //verifica acción a realizar
        printf("\n\t\tPuerta abierta");
    else
        printf("\n\t\tPuerta cerrada");
}

void *peaton_cruzando()
{
    int i;

    for(i = 0; i < NUM_CRUZANDO; i++)
    {
        pthread_mutex_lock(&mut_cochera);
        printf("\nCruza peatón");
        pthread_mutex_unlock(&mut_cochera);
        usleep(TIEMPO_ESPE); //Espera un tiempo antes de volver a pasar
    }

    pthread_exit(0);
}

void *vehiculo_cruzando()
{
    int i;

    for(i = 0; i < NUM_CRUZANDO; i++)
    {
        pthread_mutex_lock(&mut_cochera);
        printf("\nCruza vehículo");
        pthread_mutex_unlock(&mut_cochera);
        usleep(TIEMPO_ESPE); //Espera un tiempo antes de volver a pasar
    }

    pthread_exit(0);
}
