# 01: Array Walk

## Skill

Index into an array at a position you found in the debugger, not in the source.

## Goal

Report scores[target_index].

## Start

```bash
start
```

## Manual commands

```bash
make
gdb -q ./array-walk
```

Inside GDB:

```gdb
break main
run
next
next
next
print target_index
print scores[target_index]
quit
```

## Submit

```bash
./check.sh SCORE
```

Stuck? `hint` reveals one step at a time.
