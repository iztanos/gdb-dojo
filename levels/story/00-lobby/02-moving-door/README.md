# 02: The Moving Door

The lobby door opens and closes too fast.

> Breakpoints are how we teach time to behave.

## Start

Browser terminal:

```bash
start
```

Manual:

```bash
./start
```

`start` only shows the briefing. It does not build, run, submit, or reveal the answer.

## Build

```bash
make
```

## Debug

```bash
gdb -q ./moving-door
```

Inside GDB:

```gdb
break main
run
continue
quit
```

## Submit

```bash
./check.sh DOOR_WORD
```

Replace `DOOR_WORD` with the door word printed by the program.
