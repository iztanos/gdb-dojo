# 03: Struct Inspect

## Skill

Read a field of a struct that is only reachable through a pointer.

## Goal

Report the balance field.

## Start

```bash
start
```

## Manual commands

```bash
make
gdb -q ./struct-inspect
```

Inside GDB:

```gdb
break main
run
next
next
next
print entry_ptr->balance
quit
```

## Submit

```bash
./check.sh BALANCE
```

Stuck? `hint` reveals one step at a time.
