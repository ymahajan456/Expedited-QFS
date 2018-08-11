build:
	g++ -c -lm -O3 quadResidue.cpp basics.cpp
	#g++ -o quadResidue -lm -O3 basics.o quadResidue.o
run:
	./quadResidue 
clean:
	rm -rf quadResidue basics.o quadResidue.o
buildprimes:
	mpicxx -fopenmp -o hybrid hybrid.cpp -lm -O3
runprimes:
	mpirun -np 1 ./hybrid -n 5000
	rm -rf hybrid
cleanprimes:
	rm -rf hybrid markers.yo primesText.txt primesBin.yo
all:
	mpicxx -fopenmp -o hybrid hybrid.cpp -lm -O3
	mpirun -np 1 ./hybrid -n 5000
	rm -rf hybrid
	g++ -c -lm -O3 quadResidue.cpp basics.cpp
	g++ -o quadResidue -lm -O3 basics.o quadResidue.o
	./quadResidue 
	rm -rf quadResidue basics.o quadResidue.o

