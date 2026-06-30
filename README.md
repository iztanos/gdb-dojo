# GDB Dojo

```text
  ____ ____  ____    ____   ___      _  ___              /\_____/\
 / ___|  _ \| __ )  |  _ \ / _ \    | |/ _ \            /  o   x  \
| |  _| | | |  _ \  | | | | | | |_  | | | | |          ( ==  ^  == )
| |_| | |_| | |_) | | |_| | |_| | |_| | |_| |           )   ___   (
 \____|____/|____/  |____/ \___/ \___/ \___/           /___/   \___\

 break -> run -> inspect -> understand       
```

GDB Dojo is an early-stage project for hands-on GDB practice focused on real software debugging.

This repository is early. Exercises and tooling have not been added yet.

```text
        .-----------------------------.
        | (gdb) bt                    |
        | #0  check_the_state()       |
        | #1  follow_the_value()      |
        '---------------.-------------'
                        |
                   /\_____/\
                  /  o   x  \
                 ( ==  ^  == )      one good eye on the stack
                  )_________(      

  . . . break . . . step . . . print . . . fix
```

## Scope

Planned topics:

```text
  first steps                 deeper debugging
  -----------                 ----------------
  run                         backtrace
  break                       core files
  next / step                 memory lifetime
  print                       optimized builds
  info locals                 threads
```

- breakpoints
- stepping
- variable inspection
- stack frames
- crash debugging
- core dumps
- memory lifetime and buffer-boundary bugs
- optimized-build debugging
- binary inspection
- threads

## Local browser terminal

Docker is only required for the browser terminal path. It gives the most consistent environment, but it is not the only way to use future exercises.

The launcher scripts start Docker and open the browser automatically.

Windows:

```powershell
.\start-dojo.bat
```

macOS/Linux:

```bash
./start-dojo.sh
```

Manual fallback:

```bash
docker compose up --build
```

If the browser does not open automatically, visit:

[http://localhost:7681](http://localhost:7681)

This runs locally for development and future exercises. The terminal runs inside a Linux container with GDB, GCC, Make, Vim, and Nano installed. The repository is mounted at `/dojo`.

The browser terminal starts in `/dojo` with a small welcome screen, a `dojo:` prompt, and a few shortcuts such as `ll`, `c`, `root`, `playground`, and `gdbq`.

## Local/manual path

If you already have GDB, GCC, and Make installed, you can use the playground directly without Docker:

```bash
cd playground
make
./hello
gdb ./hello
```

Future exercises can also be downloaded or run directly with a local GDB/GCC setup.

Detailed setup instructions are in [docs/SETUP.md](docs/SETUP.md). Contribution notes are in [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md).

```text
  local practice only
  source -> build -> debug -> fix
```

All future practice content will be designed for local debugging scenarios.
