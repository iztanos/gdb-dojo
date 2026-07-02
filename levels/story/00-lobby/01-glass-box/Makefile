CC := gcc
CFLAGS := -g -O0 -Wall -Wextra

.PHONY: all clean

all: glassbox

glassbox: main.c
	$(CC) $(CFLAGS) -o glassbox main.c

clean:
	rm -f glassbox
