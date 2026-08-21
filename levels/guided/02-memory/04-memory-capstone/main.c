#include <stdio.h>

struct node {
    int value;
    struct node *next;
};

int main(void)
{
    struct node c = {.value = 91, .next = NULL};
    struct node b = {.value = 44, .next = &c};
    struct node a = {.value = 17, .next = &b};
    struct node *head = &a;

    puts("+------------------------------------------------------------+");
    puts("| MEMORY CAPSTONE                                            |");
    puts("+------------------------------------------------------------+");
    puts("");
    puts("head starts a linked list. Nothing about it is printed:");
    puts("not its length, not any node's value.");
    puts("");
    puts("Report the value in the LAST node.");

    if (head->value == 0) {
        puts("unreachable");
    }

    return 0;
}
