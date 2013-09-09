# Los datos provienen de esta tabla (calculada desde org-mode):
#
# #+tblname: mov_cabeza_por_algoritmo
# | Tiempo | FIFO | Despl FIFO | SSTF | Despl SSTF | SCAN | Despl SCAN | LOOK | Despl LOOK | C-SCAN | Despl C-SCAN |
# |--------+------+------------+------+------------+------+------------+------+------------+--------+--------------|
# |      0 |   53 |          0 |   53 |          0 |   53 |          0 |   53 |          0 |     53 |            0 |
# |      1 |   98 |         45 |   65 |         12 |   37 |         16 |   37 |         16 |     37 |           16 |
# |      2 |  183 |        130 |   67 |         14 |   14 |         39 |   14 |         39 |     14 |           39 |
# |      3 |   37 |        276 |   37 |         44 |    0 |         53 |   65 |         90 |    183 |          208 |
# |      4 |  122 |        361 |   14 |         67 |   65 |        118 |   67 |         92 |    124 |          267 |
# |      5 |   14 |        469 |   98 |        151 |   67 |        120 |   98 |        123 |    122 |          269 |
# |      6 |  124 |        579 |  122 |        175 |   98 |        151 |  122 |        147 |     98 |          293 |
# |      7 |   65 |        638 |  124 |        177 |  122 |        175 |  124 |        149 |     67 |          324 |
# |      8 |   67 |        640 |  183 |        236 |  124 |        177 |  183 |        208 |     65 |          326 |
# |      9 |      |            |      |            |  183 |        236 |      |            |        |              |
# #+TBLFM: @3$3..@10$3=@-1$3 + abs(@-1$2 - @0$2)::@3$5..@10$5=@-1$5 + abs(@-1$4 - @0$4)::@3$7..@11$7=@-1$7 + abs(@-1$6 - @0$6)::@3$9..@10$9=@-1$9 + abs(@-1$8 - @0$8)::@3$11..@10$11=@-1$11 + abs(@-1$10 - @0$10)

reset
set term pngcairo fontscale 1.5 size 1024,768
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
