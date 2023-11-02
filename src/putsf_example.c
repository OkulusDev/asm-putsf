typedef long long int int64_t;

extern void c_exit(int ret);
extern int64_t c_putsf(char *fmt, ...);

void _start(void) {
    char *string = "PutsF";
    int64_t decimal = 123;
    char symbol = '!';

    int64_t ret = c_putsf(
        "{ %s, %d, %c }\n",
        string, decimal, symbol
    );
    c_putsf("%d\n", ret); // 3

    c_exit(0);
}
