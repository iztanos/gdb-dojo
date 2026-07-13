# 03: Seggy Fault

Normal output is not enough this time. The value is stored in a local variable, and GDB is how you inspect it.

> Some mistakes are bugs. Mine are Seggy faults.

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
gdb -q ./seggy-fault
```

Inside GDB:

```gdb
break main
run
next
next
info locals
print access_code
quit
```

## Submit

```bash
./check.sh ACCESS_CODE
```

Replace `ACCESS_CODE` with the value of the local variable.
