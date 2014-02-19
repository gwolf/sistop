reset
set term pngcairo dashed size 640,320
unset key
set yrange [0:5]
set ylabel "Proceso o hilo"
set xrange [0:6]
set xlabel "Tiempo"

set arrow from 0.25,1 to 1,1 linecolor rgb "#000077" filled
set arrow from 1,1 to 2,1 linecolor rgb "red" linewidth 2 filled
set arrow from 2,1 to 3.7,1 linecolor rgb "#000077" filled
set arrow nohead from 3.7,1 to 4.5,1 linetype 3 linecolor rgb "red" linewidth 2 filled
set arrow from 4.5,1 to 5,1 linecolor rgb "red" linewidth 2 filled
set arrow from 5,1 to 5.7,1 linecolor rgb "#000077" filled

set arrow from 0.5,2 to 1.5,2 linecolor rgb "#007700" filled
set arrow nohead from 1.5,2 to 2,2 linetype 3 linecolor rgb "red" linewidth 2 filled
set arrow from 2,2 to 3,2 linecolor rgb "red" linewidth 2 filled
set arrow from 3,2 to 3.6,2 linecolor rgb "#007700" filled
set arrow nohead from 3.6,2 to 4,2 linetype 3 linecolor rgb "red" linewidth 2 filled
set arrow from 4,2 to 4.5,2 linecolor rgb "red" linewidth 2 filled
set arrow from 4.5,2 to 6,2 linecolor rgb "#007700" filled

set arrow from 0.5,3 to 1.5,3 linecolor rgb "#555555" filled
set arrow nohead from 1.5,3 to 3,3 linetype 3 linecolor rgb "red" linewidth 2 filled
set arrow from 3,3 to 3.5,3 linecolor rgb "red" linewidth 2 filled
set arrow from 3.5,3 to 5.3,3 linecolor rgb "#555555" filled

set arrow from 1.5,4 to 3,4 linecolor rgb "#007777" filled
set arrow nohead from 3,4 to 3.5,4 linetype 3 linecolor rgb "red" linewidth 2 filled
set arrow from 3.5,4 to 4,4 linecolor rgb "red" linewidth 2 filled
set arrow from 4,4 to 5,4 linecolor rgb "#007777" filled

set arrow nohead from 2,0.6 to 2,2.4 linetype 3 linecolor rgb "black"
set arrow nohead from 3,1.6 to 3,3.4 linetype 3 linecolor rgb "black"
set arrow nohead from 3.5,2.6 to 3.5,4.4 linetype 3 linecolor rgb "black"
set arrow nohead from 4,1.6 to 4,4.4 linetype 3 linecolor rgb "black"
set arrow nohead from 4.5,0.6 to 4.5,2.4 linetype 3 linecolor rgb "black"

plot "-" using 1:2 pointtype 7 with points
5.7	1
6	2
5.3	3
5	4
e
