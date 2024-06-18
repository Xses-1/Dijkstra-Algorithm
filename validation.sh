#!/bin/bash
I=0
N=0
K=20

for I in {5..13}
do
	N=$((2 ** $I))

	echo "$N $K"

	GRAPH=$(echo "$N $K" | ./bin/graph_generator)
done
