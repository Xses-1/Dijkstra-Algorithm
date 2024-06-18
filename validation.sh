#!/bin/bash
LC_ALL=C
I=0
J=0

A=0
B=0

N=0
K=20
RDURATION=0
RTOTAL_DURATION=0

UDURATION=0
UTOTAL_DURATION=0

SDURATION=0
STOTAL_DURATION=0

for I in {5..13}
do
	N=$((2 ** $I))
	GRAPH=$(echo "$N $K" | ./bin/graph_generator)

	for J in {1..20}
	do
		# Picking up the random nodes
		A=$(shuf -i 0-$N -n 1)
		B=$(shuf -i 0-$N -n 1)

		RDURATION=$( (time "echo "$A $B $GRAPH $EOF" | ./bin/dijkstra") 2>&1 \
					| grep real | tail -c 7 | head -c -2)

		RTOTAL_DURATION=$(bc -l <<< "$RTOTAL_DURATION + $RDURATION")



		UDURATION=$( (time "echo "$A $B $GRAPH $EOF" | ./bin/dijkstra") 2>&1 \
					| grep user | tail -c 7 | head -c -2)

		UTOTAL_DURATION=$(bc -l <<< "$UTOTAL_DURATION + $UDURATION")



		SDURATION=$( (time "echo "$A $B $GRAPH $EOF" | ./bin/dijkstra") 2>&1 \
					| grep sys | tail -c 7 | head -c -2)

		STOTAL_DURATION=$(bc -l <<< "$STOTAL_DURATION + $SDURATION")
	done

	RTOTAL_DURATION=$(bc -l <<< "$RTOTAL_DURATION/20")
	UTOTAL_DURATION=$(bc -l <<< "$UTOTAL_DURATION/20")
	STOTAL_DURATION=$(bc -l <<< "$STOTAL_DURATION/20")
	echo "$N $RTOTAL_DURATION $UTOTAL_DURATION $STOTAL_DURATION"

	RTOTAL_DURATION=0
	UTOTAL_DURATION=0
	STOTAL_DURATION=0
done
