# 04: Memory Capstone

## Skill

Chase a pointer chain to its end, combining dereference, indexing, and struct
access.

## Goal

Report the value in the LAST node.

## Start

```bash
start
```

## Manual commands

```bash
make
gdb -q ./memory-capstone
```

Inside GDB:

```gdb
break main
run
next
next
next
next
next
print *head
print *head->next
print *head->next->next
quit
```

## Submit

```bash
./check.sh LAST_VALUE
```

Stuck? `hint` reveals one step at a time.
