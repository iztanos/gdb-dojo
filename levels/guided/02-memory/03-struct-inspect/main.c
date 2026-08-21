#include <stdio.h>

struct record {
    int id;
    int balance;
};

int main(void)
{
    struct record entry = {.id = 7, .balance = 5820};
    struct record *entry_ptr = &entry;

    puts("+------------------------------------------------------------+");
    puts("| STRUCT INSPECT                                             |");
    puts("+------------------------------------------------------------+");
    puts("");
    puts("entry_ptr points at a struct record. Its fields are not printed.");
    puts("");
    puts("Report the balance field.");

    if (entry_ptr->balance == 0) {
        puts("unreachable");
    }

    return 0;
}
