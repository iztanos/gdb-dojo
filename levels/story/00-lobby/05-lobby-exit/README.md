# 05: Lobby Exit

This is the Level 0 capstone. It reviews the GDB commands you have already used by tracing how the lobby exit token is built.

> You know enough now to become dangerous to small programs.

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
gdb -q ./lobby-exit
```

Inside GDB:

```gdb
break main
run
next
step
finish
next
print exit_token
continue
quit
```

## Submit

```bash
./check.sh EXIT_TOKEN
```

Replace `EXIT_TOKEN` with the value stored in `exit_token`.
