#include <stdio.h>

static int access_level = 1;

static void audit_pass(void)
{
    int i;

    for (i = 0; i < 3; i++) {
        /* deliberately does not touch access_level */
    }
}

static void apply_policy(void)
{
    access_level = 42;
}

static void finalize(void)
{
    access_level = access_level - 5;
}

int main(void)
{
    puts("+------------------------------------------------------------+");
    puts("| WATCHPOINTS                                                |");
    puts("+------------------------------------------------------------+");
    puts("");
    puts("access_level starts at 1 and is never printed.");
    puts("Something changes it, then something else changes it again.");
    puts("");
    puts("Report the value it holds immediately after the FIRST change.");
    puts("");
    puts("Stepping through every function is slow. Ask GDB to stop when");
    puts("the variable itself is written.");

    audit_pass();
    apply_policy();
    finalize();

    return 0;
}
