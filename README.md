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

Windows:

```powershell
.\start-dojo.bat
```

macOS/Linux:

```bash
./start-dojo.sh
```

For full setup instructions, see [docs/SETUP.md](docs/SETUP.md).

Inside the browser terminal:

```bash
dojo
dojo paths
```

## Modes

| Mode | Best for | Status |
|---|---|---|
| Guided Path | First-time GDB users | Available |
| Beginner | Standalone skill drills | Planned |
| Intermediate | Realistic debugging tasks | Planned |
| Advanced | Harder debugging scenarios | Planned |

## Guided Path

| Level | Focus | Link |
|---|---|---|
| 00 - Basics | Build, run, inspect, step, and combine fundamentals | [levels/guided/00-basics](levels/guided/00-basics) |

## First exercise

```text
levels/guided/00-basics/00-build-and-run
```

Inside the exercise directory:

```bash
start
```

## Contributing

People can contribute standalone exercises, improve existing exercises, or propose additions to the Guided Path.

See [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md).
