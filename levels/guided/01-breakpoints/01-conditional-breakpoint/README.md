# 01: Conditional Breakpoint

## Skill

Stop only when a condition holds, instead of on every hit.

## Goal

Report the value checksum() returned for record 4217.

## Start

```bash
start
```

## Manual commands

```bash
make
gdb -q ./conditional-break
```

Inside GDB:

```gdb
break main.c:14 if id == 4217
run
next
print value
quit
```

## Submit

```bash
./check.sh CHECKSUM
```

Stuck? `hint` reveals one step at a time.
