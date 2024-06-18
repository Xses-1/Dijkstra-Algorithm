SRCDIR=./src
BINDIR=./bin
COMPILER=fpc

DIJKSTRA=dijkstra
GENERATOR=graph_generator

default: dijkstra generator

dijkstra: bindir
	${COMPILER} $(SRCDIR)/$(DIJKSTRA).pas -FE$(BINDIR)

generator: bindir
	${COMPILER} $(SRCDIR)/$(GENERATOR).pas -FE$(BINDIR)

bindir:
	@mkdir -p $(BINDIR)

clean:
	@rm -r $(BINDIR)
