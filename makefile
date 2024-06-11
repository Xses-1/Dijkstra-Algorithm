SRCDIR=./src
BINDIR=./bin
COMPILER=fpc


default:
	${COMPILER} $(SRCDIR)/*
	mv $(SRCDIR)/* $(BINDIR)
	mv ${BINDIR}/*.pas ${SRCDIR}
