#+begin_src gnuplot :exports results :file ltxpng/hiperpaginacion.png
reset
clear
set term png size 800,400 fontscale 1.5

set multiplot
unset key
unset xtics
unset ytics
set yrange[0:2]

set ylabel "Uso del procesador"
set xlabel " "
set origin 0.0,0.0
set size 0.4,1
set lmargin 3
set rmargin 0
set border 1+2
set xrange[0:4]
plot 2-(1/x)

unset ylabel
set xlabel "Grado de multiprogramación"
set origin 0.4,0.0
set size 0.25,1
set lmargin 0
set rmargin 0
set border 1
set xrange[-0.2:0.2]
plot 1.79-(x*x)

set xlabel " "
set origin 0.65,0.0
set size 0.1,1
set lmargin 0
set rmargin 0
set border 1
set xrange[-4:-0.6]
set arrow from -4,1.85 to 3,1.85 size 1,15 filled
set label 1 "Hiperpaginación" at -4, 2
plot (1/x)+2

unset label 1
set xlabel " "
set origin 0.75,0.0
set size 0.25,1
set lmargin 0
set rmargin 2
set xrange[3:100]
plot (1/x)
#+end_src
