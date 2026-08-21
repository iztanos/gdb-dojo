# 02: Examine Memory

## Skill

Read raw memory with the `x` command when `print` does not decode it usefully.

## Goal

Report the third byte, code[2], in hex, exactly as GDB shows it.

## Start

```bash
start
```

## Manual commands

```bash
make
gdb -q ./examine-memory
```

Inside GDB:

```gdb
break main
run
next
next
x/4xb code
quit
```

## Submit

```bash
./check.sh 0xNN
```

Stuck? `hint` reveals one step at a time.
