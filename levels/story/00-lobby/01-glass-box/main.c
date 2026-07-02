#include <stdio.h>

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

    print_header();
    print_scene();
    print_observation(phrase);

    return 0;
}
