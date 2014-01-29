#!/usr/bin/gnuplot -persist

variable="`echo $VARIABLE`"
out="TOP`echo $VARIABLE`.png"
in_data="TOP`echo $VARIABLE`.1"
title="Top 10 `echo $VARIABLE`"

blue_075 = "#2F3F60"
text_color = "#6a6a6a"

set terminal png nocrop font small size 640,480
set output out
set style data histograms
set title title
set xlabel variable textcolor rgb text_color
set ylabel "frequency" textcolor rgb text_color

set style histogram gap 4
set xtics rotate by -40
set xtics font "Times-Roman ,12" textcolor rgb blue_075

plot in_data using 1:xticlabels(2) notitle
