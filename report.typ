#import "@preview/plotst:0.2.0": *

= Bonus Assignment 1
Wiktor Tomanek [5625173] and  Nikita Soshnin [5571030]

== Using the program

The source code and instructions for compiling and using
are available on github:

- #link("https://github.com/Xses-1/Dijkstra-Algorithm")

== The graph

It is 10 minutes before the deadline.
I don't know how to do log ticks using plotst.
Dijkstra's worst case grows with $n^2$,
but for sparse graphs like the ones we used, it should be more or less linear,
which is more or less what the graph shows.
Near the start it doesn't look so linear though,
likely due to the overhead of reading the input.
The y axis is the "user" execution time, in seconds, reported by
the `time` shell utility.

// read csv
#let dat = (
	csv("results.csv")
	.map(row => (float(row.at(0)), float(row.at(2))))  // convert to float
)

// calculate range for graph
#let dat_xmin = calc.min(..dat.map(row => row.at(0)))
#let dat_xmax = calc.max(..dat.map(row => row.at(0)))
#let dat_ymin = calc.min(..dat.map(row => row.at(1)))
#let dat_ymax = calc.max(..dat.map(row => row.at(1)))

#let x_axis = axis(
	min: dat_xmin,
	max: dat_xmax,
	step: 500,
	location: "bottom",
	helper_lines: false,
	invert_markings: false,
	title: "Number of nodes"
)

#let y_axis = axis(
	min: dat_ymin,
	max: dat_ymax,
	step: 0.0625,
	location: "left",
	helper_lines: false,
	invert_markings: false,
	title: "User compute time"
)

// Combine the axes and the data and feed it to the plot render function.
#let pl = plot(data: dat, axes: (x_axis, y_axis))
#scatter_plot(pl, (100%, 20%), caption: "Number of nodes vs time")

