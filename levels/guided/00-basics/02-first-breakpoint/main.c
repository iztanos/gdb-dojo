#include <stdio.h>

static const char *status_after_continue(void)
{
    return "CONTINUED";
}

int main(void)
{
    puts("+------------------------------------------------------------+");
    puts("| FIRST BREAKPOINT                                           |");
    puts("+------------------------------------------------------------+");
    puts("");
    puts("Set a breakpoint at main, run the program, then continue.");
    puts("");
    puts("Execution status:");
    printf("  %s\n", status_after_continue());

    return 0;
}
