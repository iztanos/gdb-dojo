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
  README.md     instructions
  main.c        source
  Makefile      must define TARGET
  check.sh      answer checker
  start         briefing shown by the `start` command
```

Plus one solution script used by the test suite:

```text
tests/solutions/beginner-00-example.sh
```

The filename is the exercise path with `levels/` removed and `/` replaced by
`-`.

### Answers Are Hashed

`check.sh` must never contain the answer in plaintext — anyone can read the
file. Store a SHA-256 hash instead and let `lib/dojo-check.sh` do the
comparison:

```bash
#!/usr/bin/env bash
set -e

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(cd "$script_dir/../../.." && pwd)"
. "$repo_dir/lib/dojo-ui.sh"
. "$repo_dir/lib/dojo-check.sh"

dojo_require_answer $#

dojo_check "<sha256-of-normalized-answer>" \
    "$1" \
    "upper" \
    "hint command" \
    "another hint"
```

Generate the hash from the *normalized* answer:

```bash
printf '%s' "ANSWER" | sha256sum
```

Normalization modes: `upper` (strip whitespace, uppercase — the default for
word answers), `digits` (strip whitespace, for numbers), `exact` (strip
whitespace only, for case-sensitive answers).

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
