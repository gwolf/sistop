use threads::shared;
my ($proximo_asiento :shared, $capacidad :shared);
$capacidad = 40;

sub asigna_asiento {
  lock($proximo_asiento);
  if ($proximo_asiento < $capacidad) {
    $asignado = $proximo_asiento;
    $proximo_asiento += 1;
    print "Asiento asignado: $asignado\n";
  } else {
    print "No hay asientos disponibles\n";
    return 1;
  }
  return 0;
}
