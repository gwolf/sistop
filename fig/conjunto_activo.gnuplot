reset
clear
set term pngcairo size 800,400 

unset key
set border 1+2

set xlabel "Tiempo"
set xtics nomirror
set xrange [0:10]

set ylabel "Tasa de fallos de página"
set ytics nomirror
set yrange [0:1]


set arrow from 4.35,0.85 to 7.6,0.85 heads size screen 0.01,90
set arrow from 4.35,0.8 to 4.35,0 linetype 0 nohead
set arrow from 7.6,0.8 to 7.6,0 linetype 0 nohead
set label 1 "Conjunto activo" at 4.4, 0.9
plot (abs(tan(x)))/40 + rand(0)/10
