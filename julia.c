#include <ruby.h>
#include <math.h>

#define WIDTH 600
#define HEIGHT 600
#define MAX_ITER 50
#define MAX_K 100
#define VARIATION 10

// ジュリア集合の計算、各ピクセルの配色データを持つ配列を作成
static VALUE
set_julia(VALUE self, VALUE minX, VALUE maxX, VALUE minY, VALUE maxY, VALUE real, VALUE imag) {

    double xmin = NUM2DBL(minX);
    double xmax = NUM2DBL(maxX);
    double ymin = NUM2DBL(minY);
    double ymax = NUM2DBL(maxY);
    double realPart = NUM2DBL(real);
    double imagPart = NUM2DBL(imag);
    double deltaX = (xmax - xmin) / WIDTH;
    double deltaY = (ymax - ymin) / HEIGHT;
    VALUE result = rb_ary_new();

    for (int x = 0; x < WIDTH; x++) {
        for (int y = 0; y < HEIGHT; y++) {
            double zx = xmin + x * deltaX;
            double zy = ymax - y * deltaY;
            int iter = 0;
            while (iter < MAX_ITER) {
                if (sqrt(zx * zx + zy * zy) > MAX_K) {
                    rb_ary_push(result, INT2NUM(iter * VARIATION));
                    break;
                }

                double newZx = zx * zx - zy * zy + realPart;
                double newZy = 2.0 * zx * zy + imagPart;
                zx = newZx;
                zy = newZy;

                iter++;
            }
            
            if (iter == MAX_ITER) {
                rb_ary_push(result, INT2NUM(0));
            }
        }
    }
    return result;
}

void
Init_julia(void)
{
    VALUE cJulia = rb_define_class("Julia", rb_cObject);

    rb_define_method(cJulia, "calculate", set_julia, 6);
}