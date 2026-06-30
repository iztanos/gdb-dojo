#include <stdio.h>

static void print_message(const char *name, int count)
{
    printf("Hello, %s.\n", name);
    printf("This message has been printed %d time%s.\n",
           count,
           count == 1 ? "" : "s");
}

int main(void)
{
    const char *name = "GDB Dojo";
    int message_count = 1;

    puts("GDB Dojo playground");
    puts("Build, run, and inspect this program with GDB.");

    print_message(name, message_count);

    message_count = message_count + 1;
    printf("Updated message_count: %d\n", message_count);

    return 0;
}
