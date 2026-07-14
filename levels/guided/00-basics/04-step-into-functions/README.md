# 04: Step Into Functions

## Skill

Use `step` to enter a helper function and `finish` to return from it.

## Goal

Find the value returned into `result`.

## Start

```bash
start
```

## Manual commands

```bash
make
gdb -q ./step-functions
```

Inside GDB:

```gdb
break main
run
step
finish
print result
quit
```

## Submit

```bash
./check.sh RESULT_VALUE
```
