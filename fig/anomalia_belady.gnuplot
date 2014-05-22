reset
set term pngcairo  size 640,320
set xrange [0:8]
set xlabel "Número de marcos de memoria disponibles"
set yrange [0:14]
set ylabel "Fallos de página"
unset key
plot "-" using 1:2 with linespoints linewidth 2
1	12
2	12
3	9
4	10
5	5
6	5
7	5
e
