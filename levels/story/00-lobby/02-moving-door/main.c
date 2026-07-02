#include <stdio.h>
#include <unistd.h>

static void clear_screen(void)
{
    if (isatty(STDOUT_FILENO)) {
        printf("\033[2J\033[H");
    }
}

static const char *door_word(void)
{
    return "HINGE";
}

static void print_header(void)
{
    puts("+------------------------------------------------------------+");
    puts("| THE MOVING DOOR                                            |");
    puts("+------------------------------------------------------------+");
    puts("");
}

static void print_scene(void)
{
    puts("The lobby door slides open.");
    puts("Then closed.");
    puts("Then open again.");
    puts("");
    puts("\"Breakpoints are how we teach time to behave.\"");
    puts("");
}

int main(void)
{
    const char *word = door_word();

    clear_screen();
    print_header();
    print_scene();
    puts("Door word:");
    printf("  %s\n", word);

    return 0;
}
