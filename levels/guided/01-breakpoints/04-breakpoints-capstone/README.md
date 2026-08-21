# 04: Breakpoints Capstone

## Skill

Combine conditional breakpoints with finish to read a running total.

## Goal

Report total_manifest immediately after crate 777 has been loaded.

## Start

```bash
start
```

## Manual commands

```bash
make
gdb -q ./breakpoints-capstone
```

Inside GDB:

```gdb
break load_crate if crate == 777
run
finish
print total_manifest
quit
```

## Submit

```bash
./check.sh TOTAL
```

Stuck? `hint` reveals one step at a time.
