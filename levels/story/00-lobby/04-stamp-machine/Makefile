CC := gcc
CFLAGS := -g -O0 -Wall -Wextra

.PHONY: all clean

all: stamp-machine

stamp-machine: main.c
	$(CC) $(CFLAGS) -o stamp-machine main.c

clean:
	rm -f stamp-machine
