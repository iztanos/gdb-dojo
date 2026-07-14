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

Future standalone exercise structure will likely look like:

```text
levels/beginner/00-example/
  README.md
  main.c
  Makefile
  check.sh
```

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
