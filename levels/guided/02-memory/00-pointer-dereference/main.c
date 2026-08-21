#include <stdio.h>

int main(void)
{
    int secret_level = 4931;
    int *level_ptr = &secret_level;

    puts("+------------------------------------------------------------+");
    puts("| POINTER DEREFERENCE                                        |");
    puts("+------------------------------------------------------------+");
    puts("");
    puts("level_ptr points at secret_level. Neither is printed.");
    puts("");
    puts("Report the value level_ptr points to.");

    if (*level_ptr == 0) {
        puts("unreachable");
    }

    return 0;
}
