clear
reset
set term png fontscale 1.5 size 640,320
unset key

set xrange [0:8]
set xlabel "Número de marcos de memoria disponibles"

set yrange [0:14]
set ylabel "Fallos de Página"

plot (x>0.5 && x<7.5) ? 1/(x-0.5)+4 : 1/0
