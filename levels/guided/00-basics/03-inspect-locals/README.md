# 03: Inspect Local Variables

## Skill

Use `info locals` and `print` to inspect variables that are not printed by the program.

## Goal

Find the value stored in `access_code`.

## Start

```bash
start
```

## Manual commands

```bash
make
gdb -q ./inspect-locals
```

Inside GDB:

```gdb
break main
run
next
info locals
print access_code
quit
```

## Submit

```bash
./check.sh ACCESS_CODE
```
