reset
clear
set term pngcairo size 640,480
set yrange [0:6]
set xrange [0:14]
set xlabel "Tiempo"
set ylabel "Duración del quantum"
set boxwidth 0.9 relative
set style fill solid 0.75

acum1 = acum2 = acum3 = 2 # Valor inicial

data = 'fig/promedio_exponencial.gnuplot.data'
f1(x) = (factor=0.9, anterior1 = acum1, acum1 = (x * (1-factor) + acum1 * factor), anterior1)
f2(x) = (factor=0.7, anterior2 = acum2, acum2 = (x * (1-factor) + acum2 * factor), anterior2)
f3(x) = (factor=0.5, anterior3 = acum3, acum3 = (x * (1-factor) + acum3 * factor), anterior3)

plot data using 1:2 with boxes title "Último quantum" linetype rgb "#AAAAAA", \
     data using ($1-0.5):(f1($2)) title "Predicción con f=0.9" with lines linewidth 2 linetype rgb "#888888", \
     data using ($1-0.5):(f2($2)) title "Predicción con f=0.7" with lines linewidth 2 linetype rgb "#444444", \
     data using ($1-0.5):(f3($2)) title "Predicción con f=0.5" with lines linewidth 2 linetype rgb "#000000"

