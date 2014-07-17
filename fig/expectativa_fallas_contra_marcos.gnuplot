clear
reset
set term pngcairo fontscale 1.5 size 640,320
unset key

set xrange [0:8]
set xlabel "Número de marcos de memoria disponibles"

set yrange [0:14]
set ylabel "Fallos de Página"

plot (x>1 && x<7.5) ? 2/((x-0.5)/3)+4 : 1/0
