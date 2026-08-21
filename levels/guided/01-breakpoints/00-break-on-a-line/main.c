#include <stdio.h>

static int transform(int seed)
{
    int stage_one = seed * 3;
    int stage_two = stage_one + 17;
    int stage_three = stage_two * 2;

    return stage_three - seed;
}

int main(void)
{
    int result = transform(14);

    puts("+------------------------------------------------------------+");
    puts("| BREAK ON A LINE                                            |");
    puts("+------------------------------------------------------------+");
    puts("");
    puts("transform() computes three intermediate stages.");
    puts("Only the final result leaves the function, and it is not");
    puts("printed either.");
    puts("");
    puts("Stop on the line that computes stage_three and read the value");
    puts("stage_two is holding at that moment.");

    if (result == 0) {
        puts("unreachable");
    }

    return 0;
}
