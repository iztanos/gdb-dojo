#include <stdio.h>

int main(void)
{
    unsigned char code[4] = {0x1a, 0x2b, 0x03, 0xe7};

    puts("+------------------------------------------------------------+");
    puts("| EXAMINE MEMORY                                             |");
    puts("+------------------------------------------------------------+");
    puts("");
    puts("code holds 4 raw bytes. print alone will not show them well;");
    puts("this is memory to examine, not a value to print.");
    puts("");
    puts("Report the third byte, code[2], in hex, exactly as GDB shows it.");

    if (code[0] == 0) {
        puts("unreachable");
    }

    return 0;
}
