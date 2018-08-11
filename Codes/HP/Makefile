build:
	g++ -c -lm -O3 quadResidue.cpp basics.cpp uint192_t.cpp main.cpp
	g++ -o main -lm -O3 basics.o uint192_t.o quadResidue.o main.o
buildtest:
	g++ -c -lm -O3 test.cpp uint192_t.cpp basics.cpp
	g++ -o test -lm -O3 uint192_t.o test.o basics.o

run:
	./main 
clean:
	rm -rf main basics.o quadResidue.o uint192_t.o main.o
buildprimes:
	mpicxx -fopenmp -o hybrid hybrid.cpp -lm -O3
runprimes:
	mpirun -np 1 ./hybrid -n 500000
	rm -rf hybrid
cleanprimes:
	rm -rf hybrid markers.yo primesText.txt primesBin.yo
cleantest:
	rm -rf test test.o
all:
	mpicxx -fopenmp -o hybrid hybrid.cpp -lm -O3
	mpirun -np 1 ./hybrid -n 500000
	rm -rf hybrid
	g++ -c -lm -O3 quadResidue.cpp basics.cpp uint192_t.cpp main.cpp
	g++ -o main -lm -O3 basics.o uint192_t.o quadResidue.o main.o
	./main 
	rm -rf main quadResidue.o uint192_t.o main.o basics.o

