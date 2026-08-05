# Contributing

## Current Status

GDB Dojo is early. Setup docs, the local browser terminal, and the Guided Path Basics exercises exist.

## Good First Contributions

- Improve setup instructions.
- Test Docker setup on Linux, macOS, or Windows.
- Report unclear README or setup wording.
- Suggest or add small standalone debugging exercises.
- Fix typos or broken commands.

## Contribution Areas

| Contribution | Location |
|---|---|
| Guided curriculum exercise | `levels/guided/` |
| Beginner drill | `levels/beginner/` |
| Intermediate lab | `levels/intermediate/` |
| Advanced lab | `levels/advanced/` |
| Setup/docs improvement | `docs/` or root README |

The Guided Path is curated and ordered. Open an issue before changing its sequence or adding to it.

Beginner, Intermediate, and Advanced exercises are standalone and may be contributed more freely.

## Standalone Exercise Guidelines

New standalone exercises should:

- teach a clear debugging skill
- stay small and deterministic
- run locally with GDB, GCC, and Make
- include clear build, debug, and submit instructions
- avoid hiding the answer in comments or filenames
- keep C code readable
- work in the browser terminal when possible

Exercise structure:

```text
levels/beginner/00-example/
  README.md     full walkthrough, including the commands
  main.c        source
  Makefile      must define TARGET
  meta          everything that makes this exercise distinct
  check.sh      shared stub, copy it verbatim
  start         shared stub, copy it verbatim
```

`start` and `check.sh` are identical across every exercise — copy them from an
existing one. All the per-exercise content lives in `meta`.

Plus one solution script used by the test suite:

```text
tests/solutions/beginner-00-example.sh
```

The filename is the exercise path with `levels/` removed and `/` replaced by
`-`.

### The meta File

```
TRACK=Guided Path
LEVEL=Basics
NUMBER=03
TITLE=Inspect Local Variables
SKILL=Inspect variables that the program never prints.
GOAL=Find the value stored in access_code.
SUBMIT=ACCESS_CODE
GDB=break main|run|next|info locals|print access_code
ANSWER=cd91c587...
MODE=digits
```

`TRACK`, `TITLE`, `SKILL`, `GOAL`, and `ANSWER` are required; the suite fails
without them.

### Answers Are Hashed

Never store the answer in plaintext — anyone can read the exercise directory.
`ANSWER` holds the SHA-256 of the *normalized* answer:

```bash
printf '%s' "ANSWER" | sha256sum
```

`MODE` controls normalization: `upper` (strip whitespace, uppercase — the
default for word answers), `digits` (strip whitespace, for numbers), or `exact`
(strip whitespace only, case-sensitive).

The suite greps the built answer back out of `check.sh`, `README.md`, and
`meta` as a whole word, so a leak fails CI rather than shipping.

### Progressive Hints

Every exercise defines `HINT1`, `HINT2`, ... in `meta`, ordered from a gentle
nudge to a near-complete walkthrough. One more is revealed each time an answer
is wrong, or when the learner runs `dojo hint`. Split a hint across lines with
`|`.

```
HINT1=The value lives in a local variable the program never prints.|Stop while that variable is alive and look at it.
HINT2=`break main` then `run` stops you at the top of main.
HINT3=`info locals` lists every local in scope.
```

Numbering must be contiguous from 1 — the test suite enforces this, because a
gap silently stops later hints from ever appearing.

Hint prose must not contain the answer as a word. The suite checks this too,
which is why one hint says "executes under the debugger" rather than "running".

Two more keys shape the experience:

```
BRIEFING=full   # start lists the GDB commands (mechanics drills)
BRIEFING=goal   # start states the goal only; commands come from hints
TEACHES=break main:stop when execution reaches main|continue:resume
```

`BRIEFING=goal` is the default for anything past the introductory exercises, so
learners solve rather than transcribe. `TEACHES` feeds `dojo cheatsheet`, which
only lists commands from exercises the learner has actually completed.

### Solution Scripts

Every exercise needs a solution script so CI can prove it is still solvable.
It receives the exercise directory and the built binary name, and prints the
answer on stdout:

```bash
#!/usr/bin/env bash
. "$(dirname "${BASH_SOURCE[0]}")/_lib.sh"
sol_run_gdb "$1" "$2" "break main" "run" "next" "print value" | sol_print_value
```

Record the GDB *method*, never a literal answer — that keeps the repo free of
spoilers while still testing the exercise end to end.

Prefer `break <helper>` plus `finish` over counting `next` steps. When `main`
declares a stack array, `break main` lands on the opening brace rather than the
first statement, so step counts are not portable.

## Testing

```bash
tests/run-tests.sh              # everything
tests/run-tests.sh 03-inspect   # only matching exercises
```

For each exercise the suite checks that required files exist, `start` and
`check.sh` are executable, `make` builds with no compiler warnings, the binary
runs and is gitignored, `check.sh` rejects both a missing and a wrong answer,
`check.sh` accepts the answer produced by the solution script, and the answer
does not appear in plaintext in `check.sh` or `README.md`.

It needs bash 4+ and, for the solve step, `gdb`. macOS ships bash 3.2 and has
no usable GDB, so run the suite in the container:

```bash
docker compose run --rm dojo tests/run-tests.sh
```

CI runs the same suite on every push and pull request, plus `shellcheck` over
all shell scripts.

## Pull Request Checklist

- README/setup text is accurate.
- Commands were tested if changed.
- New files are necessary.
- No large generated files.
- No unrelated formatting churn.

## Development Notes

Use Docker Compose to test the browser terminal:

```bash
docker compose up --build
```

Validate Compose config:

```bash
docker compose config
```

Stop the container:

```bash
docker compose down
```
