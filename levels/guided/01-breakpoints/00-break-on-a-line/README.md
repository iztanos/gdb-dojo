# 00: Break on a Line

## Skill

Stop on a specific source line, not just at a function.

## Goal

Report the value stage_two holds when execution reaches line 7.

## Start

```bash
start
```

## Manual commands

```bash
make
gdb -q ./break-on-line
```

Inside GDB:

```gdb
break main.c:7
run
info breakpoints
print stage_two
quit
```

## Submit

```bash
./check.sh STAGE_TWO
```

Stuck? `hint` reveals one step at a time.
