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

echo -n > results.csv

for I in {5..13}
do
	N=$((2 ** $I))
	GRAPH=$(echo "$N $K" | ./bin/graph_generator)

	# Run 20 times in order to compute average
	for J in {1..20}
	do
		# Picking up the random nodes
		A=$(shuf -i 0-$N -n 1)
		B=$(shuf -i 0-$N -n 1)

		while [ $A == $B ]
		do
			A=$(shuf -i 0-$N -n 1)
			B=$(shuf -i 0-$N -n 1)
		done


		TIMED=$( (time -p "echo "$A $B $GRAPH" | ./bin/dijkstra") 2>&1)

		RDURATION=$(echo "$TIMED" | grep real | awk '{print $2}')
		RTOTAL_DURATION=$(bc -l <<< "$RTOTAL_DURATION + $RDURATION")

		UDURATION=$(echo "$TIMED" | grep user | awk '{print $2}')
		UTOTAL_DURATION=$(bc -l <<< "$UTOTAL_DURATION + $UDURATION")

		SDURATION=$(echo "$TIMED" | grep sys | awk '{print $2}')
		STOTAL_DURATION=$(bc -l <<< "$STOTAL_DURATION + $SDURATION")

	done

	RTOTAL_DURATION=$(bc -l <<< "$RTOTAL_DURATION/20")
	UTOTAL_DURATION=$(bc -l <<< "$UTOTAL_DURATION/20")
	STOTAL_DURATION=$(bc -l <<< "$STOTAL_DURATION/20")
	echo "$N,$RTOTAL_DURATION,$UTOTAL_DURATION,$STOTAL_DURATION" \
		| tee -a results.csv

	RTOTAL_DURATION=0
	UTOTAL_DURATION=0
	STOTAL_DURATION=0
done

