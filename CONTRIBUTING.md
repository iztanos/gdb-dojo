# Contributing

## Current Status

GDB Dojo is early. Setup docs and the local browser terminal exist. Exercises are not added yet.

## Good First Contributions

- Improve setup instructions.
- Test Docker setup on Linux, macOS, or Windows.
- Report unclear README or setup wording.
- Suggest small beginner debugging exercises.
- Fix typos or broken commands.

## Future Exercise Contributions

Future exercise structure will likely look like:

```text
levels/00-example/
  README.md
  main.c
  Makefile
  check.sh
```

This structure may change because the project is early.

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
