
long *new_42(void) {
    long x;
    long *ret;

    x = 42;
    ret = &x;

    return ret;
} // new_42

long N = 1;

void donotmuchofanything(long *a) {
    if (N--) {
        donotmuchofanything(a);			// bug: how 42 was generated, put on the stack, then got absolutely destroyed by a function call.
        N++;
    }
} // donotmuchofanything

