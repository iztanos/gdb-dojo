CC := gcc
CFLAGS := -g -O0 -Wall -Wextra

.PHONY: all clean

all: hello

hello: hello.c
	$(CC) $(CFLAGS) -o hello hello.c

clean:
	rm -f hello
