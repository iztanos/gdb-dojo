# GDB Dojo

```text
  ____ ____  ____    ____   ___      _  ___              /\_____/\
 / ___|  _ \| __ )  |  _ \ / _ \    | |/ _ \            /  o   x  \
| |  _| | | |  _ \  | | | | | | |_  | | | | |          ( ==  ^  == )
| |_| | |_| | |_) | | |_| | |_| | |_| | |_| |           )_________(
 \____|____/|____/  |____/ \___/ \___/ \___/

 break -> run -> inspect -> understand
```

GDB Dojo is a hands-on GDB practice project for learning practical software debugging.

It provides:

- a local browser terminal
- a Guided Path for first-time GDB users
- standalone Beginner, Intermediate, and Advanced exercises

## Start

**Fastest — no clone, no build:**

```bash
docker run --rm -it -p 127.0.0.1:7681:7681 \
  --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
  -v gdb-dojo-state:/home/dojo/.local/share \
  ghcr.io/iztanos/gdb-dojo
```

Then open <http://localhost:7681>. The named volume keeps your progress
between runs.

**In the browser, nothing to install:** open the repo in GitHub Codespaces.
The devcontainer builds the same image and drops you straight into the dojo.

**From a clone**, if you want to edit exercises:

| Platform | Command |
|---|---|
| Windows | `.\start-dojo.bat` |
| macOS / Linux | `./start-dojo.sh` |

For full setup instructions, see [docs/SETUP.md](docs/SETUP.md).

Inside the browser terminal:

```bash
dojo doctor       # confirm gcc, gdb, and make work
dojo next         # go to the next unfinished exercise
dojo list         # every exercise and what you have completed
dojo hint         # one more nudge on the exercise you are in
dojo cheatsheet   # the GDB commands you have unlocked so far
```

## Tracks

| Track | Best for | Status |
|---|---|---|
| Guided Path | First-time GDB users | Available |
| Beginner | Standalone skill drills | Planned |
| Intermediate | Realistic debugging tasks | Planned |
| Advanced | Harder debugging scenarios | Planned |

Run `dojo tracks` for live counts. Every listing in the CLI is generated from
the filesystem, so it never goes stale.

## Guided Path

| Level | Focus | Link |
|---|---|---|
| 00 - Basics | Build, run, inspect, step, and combine fundamentals | [levels/guided/00-basics](levels/guided/00-basics) |

## First exercise

```bash
dojo next
```

That prints the next exercise you have not finished. Inside the exercise
directory:

```bash
start        # briefing
make         # build
./check.sh ANSWER
```

Progress is stored locally in `.dojo/` and is never committed. Clear it with
`make reset-progress`.

## Contributing

People can contribute standalone exercises, improve existing exercises, or propose additions to the Guided Path.

See [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md).
