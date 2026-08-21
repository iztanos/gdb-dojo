#include <stdio.h>

static int shipment_weight(int crate)
{
    return ((crate * 53) % 617) + (crate % 7);
}

static int total_manifest = 0;

static void load_crate(int crate)
{
    total_manifest = total_manifest + shipment_weight(crate);
}

int main(void)
{
    int crate;

    puts("+------------------------------------------------------------+");
    puts("| BREAKPOINTS CAPSTONE                                       |");
    puts("+------------------------------------------------------------+");
    puts("");
    puts("1200 crates are loaded. Nothing is printed.");
    puts("");
    puts("Report the value of total_manifest immediately after crate");
    puts("777 has been loaded.");
    puts("");
    puts("Combine what you know: stop only for the crate you care about,");
    puts("then read the running total.");

    for (crate = 1; crate <= 1200; crate++) {
        load_crate(crate);
    }

    if (total_manifest < 0) {
        puts("unreachable");
    }

    return 0;
}
