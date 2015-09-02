asigna_asiento() {
  lockfile /tmp/asigna_asiento.lock
  PROX=$(cat /tmp/proximo_asiento || echo 0)
  CAP=$(cat /etc/capacidad || echo 40)
  if [ $PROX -lt $CAP ]
    then
      ASIG=$PROX
      echo $(($PROX+1)) > /tmp/proximo_asiento
      echo "Asiento asignado: $ASIG"
    else
      echo "No hay asientos disponibles"
      return 1;
    fi
  rm -f /tmp/asigna_asiento.lock
}
