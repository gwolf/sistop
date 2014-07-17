reset
set term pngcairo dashed fontscale 1.4
unset key
set xlabel "Proceso A"
set xrange [0:11]
set ylabel "Proceso B"
set yrange [0:10]

set label "Scanner" at 4.5,0.55 center
set arrow nohead from 2,0 to 2,9 linetype 3 linecolor rgb "black"
set arrow nohead from 7,0 to 7,9 linetype 3 linecolor rgb "black"
set arrow heads filled from 2,0.3 to 7,0.3 linewidth 1.5

set label "Impresora" at 5.3,1.3 center
set arrow nohead from 3,0 to 3,9 linetype 3 linecolor rgb "black"
set arrow nohead from 7.5,0 to 7.5,9 linetype 3 linecolor rgb "black"
set arrow heads filled from 3,1 to 7.5,1 linewidth 1.5

set label "Impresora" at 0.55,4 center rotate by 90
set arrow nohead from 0,2 to 9,2 linetype 3 linecolor rgb "black"
set arrow nohead from 0,6 to 9,6 linetype 3 linecolor rgb "black"
set arrow heads filled from 0.3,2 to 0.3,6 linewidth 1.5

set label "Scanner" at 1.3,5.5 center rotate by 90
set arrow nohead from 0,4 to 9,4 linetype 3 linecolor rgb "black"
set arrow nohead from 0,7 to 9,7 linetype 3 linecolor rgb "black"
set arrow heads filled from 1,4 to 1,7 linewidth 1.5

set object rectangle from 2,2 to 7.5,7 fillcolor rgb "yellow"
set label "Región Inalcanzable" at 4.75,6.5 center

set object rectangle from 2,2 to 7,6 fillcolor rgb "orange"
set label "Bloqueo\ninevitable" at 4.5,3.5 center

set object rectangle from 3,4 to 7,6 fillcolor rgb "red"
set label "Bloqueo\nmutuo" at 5,5.25 center

set label "Ambos\nprocesos\nconcluyen" at 8.2,8.7

plot "-" using 1:2 with linespoints linewidth 1.5
0	0
0.5	0
0.5	0.7
1	0.7
1	1.3
1.7	1.3

8	8
e

