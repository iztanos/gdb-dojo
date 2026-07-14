#include <stdio.h>
#include <string.h>

static const char *choose_prefix(void)
{
    return "OPEN";
}

static const char *choose_suffix(void)
{
    return "DOJO";
}

static void build_exit_token(char *buffer, size_t size)
{
    const char *prefix = choose_prefix();
    const char *suffix = choose_suffix();

    snprintf(buffer, size, "%s-%s", prefix, suffix);
}

int main(void)
{
    char exit_token[32];

    build_exit_token(exit_token, sizeof(exit_token));

    puts("+------------------------------------------------------------+");
    puts("| LOBBY EXIT                                                 |");
    puts("+------------------------------------------------------------+");
    puts("");
    puts("The exit mechanism built a token, but did not display it.");
    puts("Inspect the program and find the value stored in exit_token.");

    if (strlen(exit_token) == 0) {
        puts("The exit mechanism failed.");
    }

    return 0;
}
