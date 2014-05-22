# Los datos provienen de esta tabla (calculada desde org-mode):
#
# #+tblname: mov_cabeza_por_algoritmo
# | Tiempo | FIFO | Despl FIFO | SSTF | Despl SSTF | SCAN | Despl SCAN | LOOK | Despl LOOK | C-SCAN | Despl C-SCAN |
# |--------+------+------------+------+------------+------+------------+------+------------+--------+--------------|
# |      0 |   60 |          0 |   60 |          0 |   60 |          0 |   60 |          0 |     60 |              |
# |      1 |   83 |         23 |   41 |         19 |   40 |         20 |   40 |         20 |     40 |           20 |
# |      2 |  175 |        115 |   42 |         20 |   15 |         45 |   15 |         45 |     15 |           45 |
# |      3 |   40 |        250 |   40 |         22 |    0 |         60 |   41 |         71 |    175 |          205 |
# |      4 |  120 |        330 |   15 |         47 |   41 |        101 |   42 |         72 |    121 |          259 |
# |      5 |   15 |        435 |   83 |        115 |   42 |        102 |   83 |        113 |    120 |          260 |
# |      6 |  121 |        541 |  120 |        152 |   83 |        143 |  120 |        150 |     83 |          297 |
# |      7 |   41 |        621 |  121 |        153 |  120 |        180 |  121 |        151 |     42 |          338 |
# |      8 |   42 |        622 |  175 |        207 |  121 |        181 |  175 |        205 |     41 |          339 |
# |      9 |      |            |      |            |  175 |        235 |      |            |        |              |
# #+TBLFM: @3$3..@10$3=@-1$3 + abs(@-1$2 - @0$2)::@3$5..@10$5=@-1$5 + abs(@-1$4 - @0$4)::@3$7..@11$7=@-1$7 + abs(@-1$6 - @0$6)::@3$9..@10$9=@-1$9 + abs(@-1$8 - @0$8)::@3$11..@10$11=@-1$11 + abs(@-1$10 - @0$10)

reset
set term pngcairo  size 1024,768
data='fig/mov_cabeza_por_algoritmo.gnuplot.data'
set multiplot

set origin 0.0, 0.5
set size 1, 0.5
unset xlabel
set ylabel 'Cilindro actual'
set xtics nomirror
set ytics nomirror
set border 1+2
unset key

plot data using 1:2 with linespoints linetype rgb "#880000" linewidth 2, \
     data using 1:4 with linespoints linetype rgb "#888800" linewidth 2, \
     data using 1:6 with linespoints linetype rgb "#880088" linewidth 2, \
     data using 1:8 with linespoints linetype rgb "#008888" linewidth 2, \
     data using 1:10 with linespoints linetype rgb "#008800" linewidth 2

set origin 0.0, 0.0
set size 1, 0.5
set xlabel 'Operaciones'
set ylabel 'Cilindros totales recorridos'
set key top left
set xtics nomirror
set ytics nomirror
set border 1+2

plot data using 1:3 with linespoints linetype rgb "#880000" linewidth 2 title 'FIFO', \
     data using 1:5 with linespoints linetype rgb "#888800" linewidth 2 title 'SSTF', \
     data using 1:7 with linespoints linetype rgb "#880088" linewidth 2 title 'SCAN', \
     data using 1:9 with linespoints linetype rgb "#008888" linewidth 2 title 'LOOK', \
     data using 1:11 with linespoints linetype rgb "#008800" linewidth 2 title 'C-SCAN'
