#include <stdio.h>

static int sensor_reading(int tick)
{
    int base = (tick * 37) % 971;

    return base + (tick % 13);
}

int main(void)
{
    int reading = 0;
    int tick;

    for (tick = 1; tick <= 900; tick++) {
        reading = sensor_reading(tick);
    }

    puts("+------------------------------------------------------------+");
    puts("| IGNORE COUNTS                                              |");
    puts("+------------------------------------------------------------+");
    puts("");
    puts("sensor_reading() is called 900 times.");
    puts("");
    puts("Report the reading returned on the 250th call.");
    puts("");
    puts("A breakpoint can be told to skip a number of hits before it");
    puts("stops. Use that instead of continuing by hand.");

    if (reading < 0) {
        puts("unreachable");
    }

    return 0;
}
