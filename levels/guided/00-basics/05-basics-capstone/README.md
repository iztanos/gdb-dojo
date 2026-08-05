# 05: Basics Capstone

## Skill

Combine the Basics commands: break, run, next, step, finish, print, continue, and quit.

## Goal

Trace how the program builds `final_value`, then submit the value stored there.

## Start

```bash
start
```

## Manual commands

```bash
make
gdb -q ./basics-capstone
```

Inside GDB:

```gdb
break build_final_value
run
finish
print final_value
quit
```

## Submit

```bash
./check.sh FINAL_VALUE
```
