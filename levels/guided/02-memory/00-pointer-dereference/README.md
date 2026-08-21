# 00: Pointer Dereference

## Skill

Read the value a pointer points to, not the pointer itself.

## Goal

Report the value level_ptr points to.

## Start

```bash
start
```

## Manual commands

```bash
make
gdb -q ./pointer-dereference
```

Inside GDB:

```gdb
break main
run
next
next
next
print *level_ptr
quit
```

## Submit

```bash
./check.sh SECRET_LEVEL
```

Stuck? `hint` reveals one step at a time.
