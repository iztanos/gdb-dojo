#include <stdio.h>

int main(void)
{
    int scores[8] = {41, 87, 63, 12, 99, 28, 74, 56};
    int target_index = 4;

    puts("+------------------------------------------------------------+");
    puts("| ARRAY WALK                                                  |");
    puts("+------------------------------------------------------------+");
    puts("");
    puts("scores holds 8 values. None of them are printed.");
    puts("target_index says which one matters. It is not printed either.");
    puts("");
    puts("Report scores[target_index].");

    if (scores[target_index] == 0) {
        puts("unreachable");
    }

    return 0;
}
