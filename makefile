SRCDIR=./src
BINDIR=./bin
COMPILER=fpc


default:
	@mkdir -p $(BINDIR)
	${COMPILER} $(SRCDIR)/* -FE$(BINDIR)

clean:
	@rm -r $(BINDIR)

