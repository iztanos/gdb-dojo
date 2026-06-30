# Contributing

## Current Status

GDB Dojo is early. Setup docs, the local browser terminal, and the first Story Mode exercise exist.

## Good First Contributions

- Improve setup instructions.
- Test Docker setup on Linux, macOS, or Windows.
- Report unclear README or setup wording.
- Suggest or add small standalone debugging exercises.
- Fix typos or broken commands.

## Future Exercise Contributions

Standalone exercises should go under the right mode folder:

| Contribution type | Where it goes | Notes |
|---|---|---|
| Beginner exercise | `levels/beginner/` | One focused GDB concept |
| Intermediate exercise | `levels/intermediate/` | More realistic debugging task |
| Advanced exercise | `levels/advanced/` | Harder scenario, added later |
| Story idea | `levels/story/` | Discuss first to keep the guided path consistent |
| Docs/setup fix | README or docs | Keep changes short and practical |

Future standalone exercise structure will likely look like:

```text
levels/beginner/00-example/
  README.md
  main.c
  Makefile
  check.sh
```

This structure may change because the project is early.

Story Mode contributions should be discussed or opened as an issue first because Story Mode needs a consistent sequence and tone.

Exercise contribution guidelines:

- Keep exercises small.
- Teach one main GDB concept at a time.
- Include clear build, debug, and submit instructions.
- Avoid hiding the answer in comments or filenames.
- Prefer deterministic behavior.
- Keep C code readable.
- Make exercises runnable locally.
- Make exercises compatible with the browser terminal when possible.

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
