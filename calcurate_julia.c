#include "ruby.h"
#include <stdio.h>

static VALUE
fbar_len(VALUE self, VALUE arg)
{
    return rb_funcall(arg, rb_intern("size"), 0, 0); /* -> bar.size */
}

/* require 'bar' で Bar クラスと Bar#len メソッドが定義されるようにする。*/
void
Init_calcurate_julia(void)
{
    VALUE cBar = rb_define_class("Bar", rb_cObject); /* -> class Bar */

    rb_define_method(cBar, "len", fbar_len, 1); /* -> def len(arg) */
}