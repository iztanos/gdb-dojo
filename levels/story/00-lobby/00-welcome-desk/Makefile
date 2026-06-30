CC := gcc
CFLAGS := -g -O0 -Wall -Wextra

.PHONY: all clean

all: welcome

welcome: main.c
	$(CC) $(CFLAGS) -o welcome main.c

clean:
	rm -f welcome
