CC := gcc
CFLAGS := -g -O0 -Wall -Wextra
TARGET := build-and-run

.PHONY: all clean

all: $(TARGET)

$(TARGET): main.c
	$(CC) $(CFLAGS) -o $(TARGET) main.c

clean:
	rm -f $(TARGET)
