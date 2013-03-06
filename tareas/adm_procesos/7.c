# include
# include
# include
# include

void *auto(*arg){
  torniquete =semaforo(0);
  torniquete.acquire();
  if (persona ==0){
    avanza_auto();
    torniquete.release();
  }


  else{


  }


}

int senalizador(){
  crearconexion();
  senal.release();



}

int puerta(){

  if(puerta==0){
    cerrada();
    senal.acquire();
    abrirpuerta();
    entrar();


  }
  else{
    puertaabierta();
    entrar();

  }


}

}
