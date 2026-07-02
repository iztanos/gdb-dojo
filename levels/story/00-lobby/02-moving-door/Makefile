CC := gcc
CFLAGS := -g -O0 -Wall -Wextra

.PHONY: all clean

all: moving-door

moving-door: main.c
	$(CC) $(CFLAGS) -o moving-door main.c

clean:
	rm -f moving-door
