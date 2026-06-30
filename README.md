# GDB Dojo

```text
  ____ ____  ____    ____   ___      _  ___
 / ___|  _ \| __ )  |  _ \ / _ \    | |/ _ \
| |  _| | | |  _ \  | | | | | | |_  | | | | |
| |_| | |_| | |_) | | |_| | |_| | |_| | |_| |
 \____|____/|____/  |____/ \___/ \___/ \___/

        break -> run -> inspect -> understand
```

GDB Dojo is an early-stage project for hands-on GDB practice focused on real software debugging.

This repository is early. Exercises and tooling have not been added yet.

```text
        .----------------.
        |  (gdb) run     |
        |  breakpoint 1  |
        |  frame #0      |
        '-------.--------'
                |
          [ debugger bot ]
              /|   |\
             /_|___|_\
               /   \
              /_____\
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

```bash
docker compose up --build
```

Then open:

```text
http://localhost:7681
```

This runs locally for development and future exercises. The terminal runs inside a Linux container with GDB, GCC, Make, Vim, and Nano installed. The repository is mounted at `/dojo`.

```text
  local practice only
  source -> build -> debug -> fix
```

All future practice content will be designed for local debugging scenarios.
