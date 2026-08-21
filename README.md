<div align="center">

# GDB Dojo

```
 ██████╗ ██████╗ ██████╗     ██████╗  ██████╗      ██╗ ██████╗ 
██╔════╝ ██╔══██╗██╔══██╗    ██╔══██╗██╔═══██╗     ██║██╔═══██╗
██║  ███╗██║  ██║██████╔╝    ██║  ██║██║   ██║     ██║██║   ██║
██║   ██║██║  ██║██╔══██╗    ██║  ██║██║   ██║██   ██║██║   ██║
╚██████╔╝██████╔╝██████╔╝    ██████╔╝╚██████╔╝╚█████╔╝╚██████╔╝
 ╚═════╝ ╚═════╝ ╚═════╝     ╚═════╝  ╚═════╝  ╚════╝  ╚═════╝ 

              break → run → inspect → understand
```

**Learn GDB by debugging real programs. Not by reading about it.**

[![CI](https://github.com/iztanos/gdb-dojo/actions/workflows/ci.yml/badge.svg)](https://github.com/iztanos/gdb-dojo/actions/workflows/ci.yml)
[![Container](https://img.shields.io/badge/ghcr.io-gdb--dojo-2496ED?logo=docker&logoColor=white)](https://github.com/iztanos/gdb-dojo/pkgs/container/gdb-dojo)
[![Codespaces](https://img.shields.io/badge/Codespaces-open-24292e?logo=github)](https://codespaces.new/iztanos/gdb-dojo)
[![Bash](https://img.shields.io/badge/pure-bash-4EAA25?logo=gnubash&logoColor=white)](lib/)

[Quick start](#quick-start) · [See it](#see-it) · [Commands](#commands) · [Curriculum](#curriculum) · [Contributing](#contributing)

</div>

---

GDB is the tool everyone says to learn and almost nobody does. It needs code
signing on macOS, it is awkward on Windows, and the first hour goes to fighting
the installer instead of the bug.

**GDB Dojo removes that hour.** You get a working Ubuntu + GDB in a browser tab
and a pile of small C programs with something hidden inside. Real debugger, real
binaries, nothing simulated — so what you learn transfers straight to real work.

<a id="quick-start"></a>

## Quick start

### Zero install

Needs only Docker. No clone, no build.

```bash
docker run --rm -it -p 127.0.0.1:7681:7681 \
  --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
  -v gdb-dojo-state:/home/dojo/.local/share \
  ghcr.io/iztanos/gdb-dojo
```

Open **<http://localhost:7681>**. The named volume keeps your progress between runs.

### Zero Docker

Open the repo in **GitHub Codespaces** — `Code → Codespaces`, or press <kbd>.</kbd>
The devcontainer builds the same environment in the cloud, which works on
machines where Docker Desktop is blocked.

### From source

Pick this if you want to edit exercises or contribute.

```bash
git clone https://github.com/iztanos/gdb-dojo
cd gdb-dojo
./start-dojo.sh          # Windows: .\start-dojo.bat
```

> Running without Docker at all, plus troubleshooting → **[docs/SETUP.md](docs/SETUP.md)**

<a id="see-it"></a>

## See it

Find the value. Prove it.

```console
dojo:/dojo$ dojo next

+------------------------------------------------------------+
| NEXT EXERCISE                                               |
| 03  Inspect Local Variables                                 |
+------------------------------------------------------------+

Skill
  Inspect variables that the program never prints.

Go there
  cd levels/guided/00-basics/03-inspect-locals
  start
```

The briefing gives you the goal — **not the commands**. From exercise 03 onward
the program never prints the value, so the debugger is the only way in.

**Stuck is a normal state.** Hints escalate one step at a time, never the whole
solution at once:

```console
dojo:/dojo$ hint

Hint 1 of 3
  The value lives in a local variable the program never prints.
  You need to stop while that variable is alive and look at it.

dojo:/dojo$ hint

Hint 2 of 3
  `break main` then `run` stops you at the top of main.
  The assignment has not run yet, so step one line with `next`.
```

**Progress is tracked**, and every listing is generated from the filesystem, so
it never goes stale:

```console
dojo:/dojo$ dojo list

Done  Level        Exercise                  Path
[x]   Basics       00  Build and Run         levels/guided/00-basics/00-build-and-run
[x]   Basics       01  Run in GDB            levels/guided/00-basics/01-run-in-gdb
[x]   Basics       02  First Breakpoint      levels/guided/00-basics/02-first-breakpoint
[ ]   Basics       03  Inspect Locals        levels/guided/00-basics/03-inspect-locals
[ ]   Breakpoints  01  Conditional Break     levels/guided/01-breakpoints/01-conditional-breakpoint
[ ]   Breakpoints  03  Watchpoints           levels/guided/01-breakpoints/03-watchpoints

Progress  [####....................] 3 of 16
```

**You build your own reference.** `dojo cheatsheet` lists only what you earned:

```console
Command     What it does                          From
make        build the program using its Makefile  00  Build and Run
run         start the program from inside GDB     01  Run in GDB
quit        leave GDB                             01  Run in GDB
break main  stop when execution reaches main      02  First Breakpoint
continue    resume until the next stop or exit    02  First Breakpoint
```

> Answers are stored as **SHA-256 hashes**. Reading `check.sh` gets you nothing.

<a id="commands"></a>

## Commands

| Command | What it does |
|:--|:--|
| `dojo next` | the next exercise you have not finished |
| `dojo list` | every exercise, with completion state |
| `dojo show <name>` | detail for one exercise |
| `dojo tracks` | how far along each track is |
| `hint` | one more nudge on the exercise you are in |
| `dojo cheatsheet` | the GDB commands you have unlocked |
| `dojo doctor` | check that gcc, gdb, and make actually work |
| `make reset-progress` | start over |

Progress and hints live in `$DOJO_STATE_DIR`, `$XDG_DATA_HOME/gdb-dojo`, or
`~/.local/share/gdb-dojo` — never in the checkout, so `git pull` and re-cloning
leave them alone.

<a id="curriculum"></a>

## Curriculum

| Track | Best for | Status |
|:--|:--|:--|
| **Guided Path** | First-time GDB users, in order | **Available** |
| Beginner | Standalone skill drills | Planned |
| Intermediate | Realistic debugging tasks | Planned |
| Advanced | Harder debugging scenarios | Planned |

### 00 – Basics

| # | Exercise | Skill |
|:--|:--|:--|
| 00 | `build-and-run` | build and run a C program |
| 01 | `run-in-gdb` | start GDB, run, and quit |
| 02 | `first-breakpoint` | break at `main` and continue |
| 03 | `inspect-locals` | `info locals`, `print` |
| 04 | `step-into-functions` | `step`, `finish` |
| 05 | `basics-capstone` | combine all of it |

Exercises **00–02 walk you through the commands** — the mechanics are the point.
**03 onward gives you the goal only** and expects you to reach for the debugger.

### 01 – Breakpoints

Stopping exactly where and when you want, in programs where continuing by hand
is not viable.

| # | Exercise | Skill |
|:--|:--|:--|
| 00 | `break-on-a-line` | `break FILE:LINE`, `info breakpoints` |
| 01 | `conditional-breakpoint` | `break ... if COND` — one iteration out of 5000 |
| 02 | `ignore-counts` | `ignore N COUNT`, `finish` |
| 03 | `watchpoints` | `watch` — stop on data, not on code |
| 04 | `breakpoints-capstone` | conditions plus `finish` |

### 02 – Memory

Real bugs often live one step removed from a named variable — behind a
pointer, inside an array at a position you have to work out, in raw bytes
`print` won't decode, or several hops down a chain of pointers.

| # | Exercise | Skill |
|:--|:--|:--|
| 00 | `pointer-dereference` | `print *ptr`, `print &var` |
| 01 | `array-walk` | `print arr[i]` — indexing with a value found at runtime |
| 02 | `examine-memory` | `x` — reading raw bytes `print` does not decode |
| 03 | `struct-inspect` | `ptype`, `print ptr->field` |
| 04 | `memory-capstone` | chase a pointer chain, combining all of it |

<a id="contributing"></a>

## Contributing

An exercise is just a directory. Everything specific to it lives in `meta`;
`start` and `check.sh` are shared stubs you copy unchanged.

```text
levels/beginner/00-example/
├── README.md   full walkthrough, including the commands
├── main.c      the program
├── Makefile    must define TARGET
├── meta        title, skill, goal, hints, answer hash
├── check.sh    shared stub, copied verbatim
└── start       shared stub, copied verbatim
```

Nothing is hardcoded anywhere else. The CLI, the Makefile, and the test suite
all discover exercises from the filesystem — **adding the directory is enough.**

```bash
tests/run-tests.sh
docker compose run --rm dojo tests/run-tests.sh   # if you have no local GDB
```

CI runs on every pull request. For each exercise it verifies that the build is
warning-free, that the checker rejects bad input, that the answer never appears
in plaintext — and, driving **real GDB**, that the exercise is still solvable.

<details>
<summary><b>Good first contributions</b></summary>

- a standalone drill for `beginner/`
- a clearer hint on an existing exercise
- testing the Docker path on a platform we have not tried
- setup or wording fixes

Conventions and the full checklist → **[docs/CONTRIBUTING.md](docs/CONTRIBUTING.md)**

</details>

<details>
<summary><b>Project layout</b></summary>

```text
dojo            the CLI
lib/            shared shell libraries — ui, paths, state, progress, hints, checking
levels/         exercises, grouped by track
playground/     scratch program for sanity-checking your toolchain
tests/          test suite and per-exercise GDB solutions
docker/         image and browser-terminal entrypoint
docs/           setup and contributing guides
```

</details>
