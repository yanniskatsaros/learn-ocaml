clean: exercises.cmi exercises.cmx exercises.exe exercises.o
	rm exercises.cmi exercises.cmx exercises.exe exercises.o

build: exercises.ml
	ocamlopt -o exercises.exe exercises.ml

run: exercises.exe
	./exercises.exe
