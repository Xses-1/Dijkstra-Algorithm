SRCDIR=./src
BINDIR=./bin
COMPILER=fpc

DIJKSTRA=dijkstra
GENERATOR=graph_generator

$(DIJKSTRA):
	@mkdir -p $(BINDIR)
	${COMPILER} $(SRCDIR)/$(DIJKSTRA).pas -FE$(BINDIR)

generator:
	@mkdir -p $(BINDIR)
	${COMPILER} $(SRCDIR)/$(GENERATOR).pas -FE$(BINDIR)

clean:
	@rm -r $(BINDIR)

