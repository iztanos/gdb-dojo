# Guided Path 00 - Basics

Basics introduces the core workflow: build a program, run it, stop it in GDB,
inspect values, and step through functions.

| Exercise | Skill |
|----------|-------|
| `00-build-and-run` | build and run a C program |
| `01-run-in-gdb` | start GDB, run, and quit |
| `02-first-breakpoint` | break at `main` and continue |
| `03-inspect-locals` | use `info locals` and `print` |
| `04-step-into-functions` | use `step` and `finish` |
| `05-basics-capstone` | combine the Basics commands |

Exercises 00 to 02 drill the mechanics, so the program prints the value you
submit. From 03 onward the value is never printed and GDB is the only way to
read it.

Each exercise directory holds a `meta` file describing the briefing, the hints,
and the SHA-256 of the expected answer. `start` and `check.sh` are shared
stubs, so exercises differ only in their C source and their metadata.
