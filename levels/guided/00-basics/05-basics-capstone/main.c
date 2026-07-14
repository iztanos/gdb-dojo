#include <stdio.h>
#include <string.h>

static const char *select_prefix(void)
{
    return "GDB";
}

static const char *select_suffix(void)
{
    return "BASICS";
}

static void build_final_value(char *buffer, size_t size)
{
    const char *prefix = select_prefix();
    const char *suffix = select_suffix();

    snprintf(buffer, size, "%s-%s", prefix, suffix);
}

int main(void)
{
    char final_value[32];

    build_final_value(final_value, sizeof(final_value));

    puts("+------------------------------------------------------------+");
    puts("| BASICS CAPSTONE                                            |");
    puts("+------------------------------------------------------------+");
    puts("");
    puts("The program built a final value.");
    puts("The value was stored in final_value.");
    puts("Use GDB to inspect it.");

    if (strlen(final_value) == 0) {
        puts("No final value was built.");
    }

    return 0;
}
