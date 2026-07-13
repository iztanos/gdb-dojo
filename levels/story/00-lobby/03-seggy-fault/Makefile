CC := gcc
CFLAGS := -g -O0 -Wall -Wextra

.PHONY: all clean

all: seggy-fault

seggy-fault: main.c
	$(CC) $(CFLAGS) -o seggy-fault main.c

clean:
	rm -f seggy-fault
