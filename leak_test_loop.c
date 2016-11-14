
#include <caml/mlvalues.h>
#include <caml/callback.h>
#include <caml/memory.h>
#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include <unistd.h>


void load_unload(int i, char *argv[])
{
        void *h = dlopen("./leak_test_loop_dll.so", RTLD_LAZY);

        void (*startup) (char**) = dlsym(h, "caml_startup_pooled");
        void (*shutdown) (void) = dlsym(h, "caml_shutdown");
        value* (*named_value) (char*) = dlsym(h, "caml_named_value");
        value (*callback2) (value, value, value) = dlsym(h, "caml_callback2");

        startup(argv);
        startup(argv);
        value* adder = named_value("adder");
        int res = callback2(*adder, Val_long(i), Val_long(10));
        printf("%d: %d\n", i, Long_val(res));
        shutdown();
        shutdown();

        dlclose(h);
}


int main(int argc, char *argv[])
{
        int i;
        for (i = 0; i < 100000; i++) {
                sleep(1);
                load_unload(i, argv);
        }
        return 0;
}
