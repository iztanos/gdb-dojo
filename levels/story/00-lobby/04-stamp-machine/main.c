#include <stdio.h>
#include <unistd.h>

static void clear_screen(void)
{
    if (isatty(STDOUT_FILENO)) {
        printf("\033[2J\033[H");
    }
}

static const char *make_stamp(void)
{
    const char *generated_stamp = "STAMP-42";
    return generated_stamp;
}

int main(void)
{
    clear_screen();

    const char *stamp = make_stamp();

    puts("+------------------------------------------------------------+");
    puts("| STAMP MACHINE                                              |");
    puts("+------------------------------------------------------------+");
    puts("");
    puts("The machine completed its work.");
    puts("The final stamp was returned by make_stamp().");
    puts("");
    puts("Inspect the function and the local variable named stamp.");

    if (stamp == NULL) {
        puts("The machine failed.");
    }

    return 0;
}
