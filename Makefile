
CLIBS = -lm -ldl -ltinfo -lnums -lbigarray -lunix -lcamlstr
BYTELIBS = nums.cma bigarray.cma unix.cma str.cma
OPTLIBS = nums.cmxa bigarray.cmxa unix.cmxa str.cmxa


leak_test_loop_dll.so: leak.ml
	ocamlc -g -output-obj -o leak_test_loop_dll.so $(BYTELIBS) leak.ml

leak_test_loop: leak_test_loop_dll.so leak_test_loop.c
	cc -L`ocamlc -where` -I`ocamlc -where` -o leak_test_loop leak_test_loop.c $(CLIBS)

leak_test: leak.ml leak_test.c
	ocamlc -g -output-obj -linkall -o leak.o $(BYTELIBS) leak.ml
	ocamlc -g -c leak_test.c -o leak_test.o
	cc -L`ocamlc -where` -o leak_test leak.o leak_test.o -lcamlrund $(CLIBS)

leak_test.opt: leak.ml leak_test.c
	ocamlopt -g -output-obj -linkall -o leak.opt.o $(OPTLIBS) leak.ml
	ocamlopt -g -c leak_test.c -o leak_test.o
	cc -L`ocamlc -where` -o leak_test.opt leak.opt.o leak_test.o -lasmrund $(CLIBS)

clean:
	rm -f *.so *.o *.cmi *.cmo *.cmx *.cds leak_test leak_test.opt leak_test_loop
