# 02: Ignore Counts

## Skill

Skip a fixed number of breakpoint hits.

## Goal

Report the reading returned by the 250th call to sensor_reading().

## Start

```bash
start
```

## Manual commands

```bash
make
gdb -q ./ignore-counts
```

Inside GDB:

```gdb
break sensor_reading
ignore 1 249
run
finish
next
print reading
quit
```

## Submit

```bash
./check.sh READING
```

Stuck? `hint` reveals one step at a time.
