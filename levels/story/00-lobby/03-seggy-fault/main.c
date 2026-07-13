#include <stdio.h>
#include <unistd.h>

static void clear_screen(void)
{
    if (isatty(STDOUT_FILENO)) {
        printf("\033[2J\033[H");
    }
}

static void print_scene(void)
{
    clear_screen();
    puts("+------------------------------------------------------------+");
    puts("| ACCESS PANEL                                               |");
    puts("+------------------------------------------------------------+");
    puts("");
    puts("The access panel is waiting.");
    puts("");
    puts("The code exists in a local variable, but the program never");
    puts("prints it.");
    puts("");
    puts("Variable:");
    puts("  access_code");
    puts("");
}

int main(void)
{
    print_scene();

    int access_code = 7319;

    puts("The access panel is still waiting.");
    puts("The value was stored locally, but never printed.");

    if (access_code == 0) {
        puts("unreachable");
    }

    return 0;
}
