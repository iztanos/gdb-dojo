# 03: Watchpoints

## Skill

Stop when a variable is written, rather than at a code location.

## Goal

Report the value access_level holds immediately after the first write to it.

## Start

```bash
start
```

## Manual commands

```bash
make
gdb -q ./watchpoints
```

Inside GDB:

```gdb
watch access_level
run
continue
quit
```

## Submit

```bash
./check.sh ACCESS_LEVEL
```

Stuck? `hint` reveals one step at a time.
