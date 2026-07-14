CC := gcc
CFLAGS := -g -O0 -Wall -Wextra
TARGET := inspect-locals

.PHONY: all clean

all: $(TARGET)

$(TARGET): main.c
	$(CC) $(CFLAGS) -o $(TARGET) main.c

clean:
	rm -f $(TARGET)
