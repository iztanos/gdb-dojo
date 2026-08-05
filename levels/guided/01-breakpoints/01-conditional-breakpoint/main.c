#include <stdio.h>

static long checksum(int id)
{
    return ((long)id * 7919L) % 100003L;
}

int main(void)
{
    long value = 0;
    int id;

    for (id = 1; id <= 5000; id++) {
        value = checksum(id);
    }

    puts("+------------------------------------------------------------+");
    puts("| CONDITIONAL BREAKPOINT                                     |");
    puts("+------------------------------------------------------------+");
    puts("");
    puts("The loop runs 5000 times and keeps no history.");
    puts("");
    puts("Find the value that checksum() returned for record 4217.");
    puts("");
    puts("Continuing 4217 times by hand is not the intended route.");

    if (value < 0) {
        puts("unreachable");
    }

    return 0;
}
