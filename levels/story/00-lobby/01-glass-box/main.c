#include <stdio.h>
#include <unistd.h>

static void clear_screen(void)
{
    if (isatty(STDOUT_FILENO)) {
        printf("\033[2J\033[H");
    }
}

static const char *observation_phrase(void)
{
    return "BLINK";
}

static void print_header(void)
{
    puts("+------------------------------------------------------------+");
    puts("| THE GLASS BOX                                              |");
    puts("+------------------------------------------------------------+");
    puts("");
}

static void print_scene(void)
{
    puts("The program runs inside the glass box.");
    puts("This time, you watched it from GDB.");
    puts("");
    puts("\"Run it again. This time, watch.\"");
    puts("");
}

static void print_observation(const char *phrase)
{
    puts("Observation phrase:");
    printf("  %s\n", phrase);
}

int main(void)
{
    const char *phrase = observation_phrase();

    clear_screen();
    print_header();
    print_scene();
    print_observation(phrase);

    return 0;
}
