# Dijkstra Algorithm Implementation

The goal of this project is to implement the Dijkstra algorithm and estimate it efficiency.

## Dependencies

This project is mainly written in Pascal with some BASH, therfore a machine running BASH and Pascal compiler are needed. Below is the list of all of the dependecies:

* FPC - Free Pascal Compiler
* BASH
* Make

## Compilation

```bash
make
```

## Run instructions

The validation.sh script runs the Erdős Rényi random graph generation program
from the binary file in bin directory (bin/graph\_generator) and does it in a
loop for N's from 2^5 to 2^13 and fixed value of avarage degree equal to 20.
The random graphs are passed to the binary running the Dijkstra algorithm
(bin/dijkstra).<br>
<br>
The output of the script is the execution times of 20
passes from one random node to the other of the Dijkstra algorithm for N from
2^5 to 2^13. There are 3 times in one line. The last one is the system time, so
the time it takes to run only the algorithm from the binary in the Kernel. The
second one is the user time, so kernel time + execution of any library and
system calls. The first one is the real time, so the user time + the I/O, which
in reality takes most of the execution time, but does not represent the actual
efficiency of the implementation, and creates an nonlinear error.<br>
<br>
So at the end execution of the validation.sh script runs all of the tests and
outputs the performance metricts. Run command:

```
./validate.sh
```

## Performance analysis
As we can see the time for the execution of the algorithm grows in an non-linear
way. The complexity of the Dijkstra algorithm is N^2 thus it will take much
longer time to finish the execution for the bigger networks.


## License

You should have received a copy of the CC0 Public Domain Dedication
along with this software.
If not, see http://creativecommons.org/publicdomain/zero/1.0/.

COPYLEFT 🄯 2024 MAYBETREE AND XSES ALL WRONGS DESERVED.

