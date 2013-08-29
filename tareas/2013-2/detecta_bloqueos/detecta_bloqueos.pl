#!/usr/bin/perl
#
# Planteamiento de la tarea:
#
# Programa de detección de bloqueos
# =================================
#
# Implementa, en tu lenguaje favorito, un programa que reciba como
# entrada una lista de recursos y procesos, y presente como salida la
# evaluación de si hay bloqueos en el estado del sistema o no (si
# puedes, que presente los procesos o recursos involucrados en el
# bloqueo).
#
# Debes indicar:
#
# * Cómo es la sintaxis de entrada. Esto es, cómo voy a indicarle la
#   lista de procesos y recursos.
#
# * La estructura que comenzamos a desarrollar en clase partía de un
#   arreglo asociativo (hash) donde las llaves eran los
#   identificadores de proceso y cada uno de ellos correspondía con
#   dos arreglos, el de los recursos que tenía asignados y el de los
#   que tenía solicitados, como:
#     { 'a' : [[1], [2, 3]], 'b' : [[2], [1, 4, 5]], 'c' : [[3], []] }
#   Pero puedes hacerlo con la estructura o formato que prefieras.
#
# * Cómo debo ejecutar tu programa. El programa debe poderse ejecutar,
#   no será aceptado pseudocódigo.
#
# * Qué formato debe tener la respuesta que recibiré.
#
# Puedes enviar nuevas versiones si mejoras tu programa, la última
# será la que cuente. Si envías tu programa después del viernes 1 de
# marzo a las 13:00 (y hasta el lunes 4 a las 13:00) el sistema te lo
# aceptará, pero con una calificación máxima del 80%.

# Resolución
# ==========
# Sintaxis:
#
# $procesos es un hash, donde las llaves son los nombres de los
# procesos, y el valor es la referencia a dos arreglos: El primero,
# los recursos asignados, y el segundo, los procesos solicitados.
#
# Respuesta:
#
# En caso de haber un bloqueo, el programa indicará "Bloqueo mutuo
# detectado", y presentará la lista de procesos y recursos
# implicados. En caso de no haberlo, el programa imprimirá "No se
# detectó ningún bloqueo".
use strict;
use YAML;
our ($procesos, $solicitados, $asignados, $debug);

$debug = 2;

my $procesos = { 'A' => [[], [1]],
		 'B' => [[1, 3, 6], [4]],
		 'C' => [[4, 2], [5]],
		 'D' => [[7], [4]],
		 'E' => [[5], [7]],
		 'F' => [[], [6]]
};

($asignados, $solicitados) = hashes_auxiliares();

debug(3, "Listos para ejecutar con\n" .
      YAML::Dump {Procesos => $procesos,
	      Asignados => $asignados,
	      Solicitados => $solicitados});

for my $proc (keys %$procesos) {
    my $revisados = {rec => {}, proc => {}};
    debug(1, "Buscando bloqueos en torno a $proc");
    busca_bloqueos($proc, $revisados);
}

debug(0, "No se detectó ningún bloqueo.");

sub busca_bloqueos {
    my ($proceso, $revisados);
    $proceso = shift;
    $revisados = shift;

    # Si el proceso ya está en la lista de revisados, hemos encontrado
    # un ciclo
    reporta_bloqueo($revisados) if $revisados->{proc}{$proceso};
    $revisados->{proc}{$proceso} = 1;

    for my $solic (@{$procesos->{$proceso}[1]}) {
	debug(2, sprintf('Recuso solicitado %s (%s)', $solic, $proceso));
	$revisados->{rec}{$solic} = 1;

	if (my $otroproc = $asignados->{$solic}) {
	    next if $otroproc eq $proceso;
	    debug(3, "Buscando por el proceso $otroproc");
	    busca_bloqueos($otroproc, $revisados);
	}
    }
}

sub reporta_bloqueo {
    my $estado = shift;
    die sprintf("Bloqueo mutuo detectado\n  Procesos: %s\n  Recursos: %s\n", 
		join(', ', keys %{$estado->{proc}}),
		join(', ', keys %{$estado->{rec}})
	);
}

sub hashes_auxiliares {
    my ($asignados, $solicitados);
    $asignados = {};
    $solicitados = {};

    for my $proc (keys %$procesos) {
	for my $asig (@{$procesos->{$proc}[0]}) {
	    # Un recurso puede estar sólo asignado a un proceso
	    if ($asignados->{$asig}) {
		die "Error: $asig está marcado como asignado a $asignados->{$asig} y a $proc: ";
	    }
	    $asignados->{$asig} = $proc;
	}

	# Pero varios procesos pueden estar solicitando un recurso
	for my $solic (@{$procesos->{$proc}[1]}) {
	    $solicitados->{$solic} ||= [];
	    push @{$solicitados->{$solic}}, $proc;
	}
    }

    return ($asignados, $solicitados);
}

sub debug {
    my $nivel = shift;
    return 0 unless $nivel <= $debug;
    print @_, "\n";
}
