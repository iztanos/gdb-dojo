# 04: Stamp Machine

The stamp value is returned from a helper function. Use GDB to step into the function and inspect the value returned into `stamp`.

> Functions are just rooms pretending not to have doors.

## Start

Browser terminal:

```bash
start
```

Manual:

```bash
./start
```

`start` only shows the briefing. It does not build, run GDB, submit, or reveal the answer.

## Build

```bash
make
```

## Debug

```bash
gdb -q ./stamp-machine
```

Inside GDB:

```gdb
break main
run
next
step
finish
next
print stamp
quit
```

## Submit

```bash
./check.sh STAMP_VALUE
```

Replace `STAMP_VALUE` with the value returned into `stamp`.
