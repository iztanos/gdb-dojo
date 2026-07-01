# 00: The Welcome Desk Is Watching

You enter the GDB Dojo lobby.

Seggy is sitting on the welcome desk, one eye open, one paw resting on the badge printer. The printer has produced a temporary badge word. Your job is to build the program, run it, read the badge word, and submit it.

If it compiles, that only proves it compiles.

No GDB is required yet.

## Start This Exercise

| Option | Use when | Start |
|---|---|---|
| Browser terminal | You want the built-in environment | Run `./start-dojo.sh` or `.\start-dojo.bat`, then open [localhost:7681](http://localhost:7681) |
| Manual | You already have GCC and Make | Run the manual commands below |

## Browser Terminal

```bash
cd /dojo/levels/story/00-lobby/00-welcome-desk
make
./welcome
```

## Manual

```bash
cd levels/story/00-lobby/00-welcome-desk
make
./welcome
```

## Submit

```bash
./check.sh BADGE_WORD
```

Replace `BADGE_WORD` with the word printed by the program.

## What This Teaches

- entering an exercise directory
- building a C program
- running a compiled program
- submitting an answer with `check.sh`
