reset
clear
set term pngcairo  size 640,480
set yrange [0:6]
set xrange [1:20]
set xlabel "Número de procesadores"
set ylabel "Ganancia"
set key left top title "Porcentaje\nde ejecución\nparalela" box linewidth 0.2
set grid

plot 1/(0.05 + 0.95/x) title "95%",\
     1/(0.2 + 0.8/x) title "80%",\
     1/(0.4 + 0.6/x) title "60%",\
     1/(0.6 + 0.4/x) title "40%", \
     1/(0.8 + 0.2/x) title "20%", \
     1 linetype rgb "#000000" title "0%" 
