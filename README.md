# GDB Dojo

```text
  ____ ____  ____    ____   ___      _  ___              /\_____/\
 / ___|  _ \| __ )  |  _ \ / _ \    | |/ _ \            /  o   x  \
| |  _| | | |  _ \  | | | | | | |_  | | | | |          ( ==  ^  == )
| |_| | |_| | |_) | | |_| | |_| | |_| | |_| |           )   ___   (
 \____|____/|____/  |____/ \___/ \___/ \___/           /___/   \___\
                                                        _/  /_\  \_
        break -> run -> inspect -> understand        .- paw on frame #0 -.
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
                  )   ___   (       four paws on the ground
                 /___/   \___\
                  _/  /_\  \_

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

```bash
docker compose up --build
```

Then open:

```text
http://localhost:7681
```

This runs locally for development and future exercises. The terminal runs inside a Linux container with GDB, GCC, Make, Vim, and Nano installed. The repository is mounted at `/dojo`.

Detailed setup instructions are in [SETUP.md](SETUP.md). Contribution notes are in [CONTRIBUTING.md](CONTRIBUTING.md).

```text
  local practice only
  source -> build -> debug -> fix
```

All future practice content will be designed for local debugging scenarios.
