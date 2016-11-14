
#include <caml/mlvalues.h>
#include <caml/callback.h>
#include <caml/memory.h>
#include <stdio.h>
#include <stdlib.h>


int main(int argc, char *argv[])
{
        caml_startup_pooled(argv);
        caml_startup_pooled(argv);
        value* adder = caml_named_value("adder");
        int res = caml_callback2(*adder, Val_long(5), Val_long(10));
        printf("%d\n", Long_val(res));
        caml_shutdown();
        caml_shutdown();
        return 0;
}
