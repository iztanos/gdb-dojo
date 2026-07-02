#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

static int use_terminal_style(void)
{
    return isatty(STDOUT_FILENO) && getenv("NO_COLOR") == NULL;
}

static void clear_screen(void)
{
    if (isatty(STDOUT_FILENO)) {
        printf("\033[2J\033[H");
    }
}

static void cyan(void)
{
    if (use_terminal_style()) {
        printf("\033[36m");
    }
}

static void green(void)
{
    if (use_terminal_style()) {
        printf("\033[32m");
    }
}

static void reset(void)
{
    if (use_terminal_style()) {
        printf("\033[0m");
    }
}

static const char *make_badge_word(void)
{
    return "WHISKER";
}

static void print_header(void)
{
    cyan();
    puts("+------------------------------------------------------------+");
    puts("| GDB DOJO LOBBY                                             |");
    puts("| First visit detected                                       |");
    puts("+------------------------------------------------------------+");
    reset();
    puts("");
}

static void print_lobby_scene(void)
{
    puts("The lobby terminal wakes.");
    puts("A temporary badge is waiting.");
    puts("");
}

static void print_badge_word(const char *badge_word)
{
    puts("Temporary badge word:");
    green();
    printf("  %s\n", badge_word);
    reset();
    puts("");
}

static void print_next_step(const char *badge_word)
{
    puts("\"If it compiles, congratulations. You have a suspect.\"");
    puts("");
    puts("Next:");
    green();
    printf("  ./check.sh %s\n", badge_word);
    reset();
}

int main(void)
{
    const char *badge_word = make_badge_word();

    clear_screen();
    print_header();
    print_lobby_scene();
    print_badge_word(badge_word);
    print_next_step(badge_word);

    return 0;
}
