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

static void yellow(void)
{
    if (use_terminal_style()) {
        printf("\033[33m");
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
    puts("The lobby terminal flickers.");
    puts("A one-eyed cat looks up from behind the welcome desk.");
    puts("");
    yellow();
    puts("Seggy:");
    puts("  \"You ran the program. Good.");
    puts("   Most mysteries start by doing the obvious thing.\"");
    reset();
    puts("");
}

static void print_badge_printer(void)
{
    puts("The badge printer clicks once.");
    puts("Then twice.");
    puts("Then makes a noise no printer should make.");
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
    yellow();
    puts("Seggy:");
    puts("  \"Submit that word before the printer develops opinions.\"");
    reset();
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
    print_badge_printer();
    print_badge_word(badge_word);
    print_next_step(badge_word);

    return 0;
}
