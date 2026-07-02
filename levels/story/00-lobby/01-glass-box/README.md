# 01: The Glass Box

A program sits inside a glass case in the lobby.

> Run it again. This time, watch.

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
gdb ./glassbox
```

Inside GDB:

```gdb
run
quit
```

## Submit

```bash
./check.sh PHRASE
```

Replace `PHRASE` with the observation phrase printed by the program.
