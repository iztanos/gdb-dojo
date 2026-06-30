# Playground

This is a playground, not a level.

Use it to confirm that the browser terminal, compiler, and GDB are working.

```bash
make
./hello
gdb ./hello
```

Simple GDB commands to try:

```gdb
break main
run
next
print message_count
quit
```

Clean up the compiled program:

```bash
make clean
```
