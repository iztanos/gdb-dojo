CC := gcc
CFLAGS := -g -O0 -Wall -Wextra
TARGET := first-breakpoint

.PHONY: all clean

all: $(TARGET)

$(TARGET): main.c
	$(CC) $(CFLAGS) -o $(TARGET) main.c

clean:
	rm -f $(TARGET)
