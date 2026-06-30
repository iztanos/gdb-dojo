#include <stdio.h>

static const char *make_badge_word(void)
{
    return "WHISKER";
}

int main(void)
{
    const char *badge_word = make_badge_word();

    puts("Welcome to the GDB Dojo lobby.");
    puts("Seggy watches from the welcome desk.");
    puts("The badge printer coughs, clicks, and produces a word.");
    printf("Your temporary badge word is: %s\n", badge_word);
    puts("Seggy taps the desk twice. That means you may proceed.");

    return 0;
}
