#include <stdio.h>

static const char *compute_result(void)
{
    const char *computed_result = "RESULT-42";
    return computed_result;
}

int main(void)
{
    const char *result = compute_result();

    puts("+------------------------------------------------------------+");
    puts("| STEP INTO FUNCTIONS                                        |");
    puts("+------------------------------------------------------------+");
    puts("");
    puts("A helper function returned a value.");
    puts("Inspect the value stored in result.");

    if (result == NULL) {
        puts("No result was computed.");
    }

    return 0;
}
