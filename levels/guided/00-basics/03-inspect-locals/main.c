#include <stdio.h>

int main(void)
{
    int access_code = 7319;

    puts("+------------------------------------------------------------+");
    puts("| INSPECT LOCAL VARIABLES                                    |");
    puts("+------------------------------------------------------------+");
    puts("");
    puts("The program stored a value in:");
    puts("");
    puts("  access_code");
    puts("");
    puts("The value is not printed.");
    puts("Use GDB to inspect it.");

    if (access_code == 0) {
        puts("unreachable");
    }

    return 0;
}
