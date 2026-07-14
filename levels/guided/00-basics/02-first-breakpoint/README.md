# 02: First Breakpoint

## Skill

Set a breakpoint at `main`, run the program, and continue execution.

## Goal

Stop at the start of `main`, then continue so the program can print its final status.

## Start

```bash
start
```

## Manual commands

```bash
make
gdb -q ./first-breakpoint
```

Inside GDB:

```gdb
break main
run
continue
quit
```

## Submit

```bash
./check.sh CONTINUED
```
