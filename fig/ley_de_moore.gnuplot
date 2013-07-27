reset
set term png fontscale 1.5 size 1024,1024
data='fig/ley_de_moore.gnuplot.data'
set key bottom right
set grid

set xlabel "Fecha de entrada al mercado"
set xrange [1970:2015]

set logscale y
set yrange [1000:6000000000]
set ytics rotate by 70
set ytics ("1,000" 1000, \
    "10,000" 10000, \
    "100,000" 100000, \
    "1,000,000" 1000000, \
    "10,000,000" 10000000, \
    "100,000,000" 100000000, \
    "1,000,000,000" 1000000000)
set ylabel "Número de transistores"

moore(x) = (x > 1970) ? 1.42**(x-1950) : 1/0

plot data using 3:2 with points linetype rgb "#770000" title "8 bits", \
     data using 4:2 with points linetype rgb "#007700" title "x86/32", \
     data using 5:2 with points linetype rgb "#000077" title "x86/64", \
     data using 6:2 with points linetype rgb "#777700" title "IA64 (Itanium)", \
     data using 7:2 with points linetype rgb "#007777" title "ARM", \
     data using 8:2 with points linetype rgb "#777777" title "PowerPC", \
     data using 9:2 with points linetype rgb "#770077" title "Otros", \
     moore(x) with lines linetype rgb "#ff6666" notitle
