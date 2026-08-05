<div align="center">

```text
  ____ ____  ____    ____   ___      _  ___              /\_____/\
 / ___|  _ \| __ )  |  _ \ / _ \    | |/ _ \            /  o   x  \
| |  _| | | |  _ \  | | | | | | |_  | | | | |          ( ==  ^  == )
| |_| | |_| | |_) | | |_| | |_| | |_| | |_| |           )_________(
 \____|____/|____/  |____/ \___/ \___/ \___/

 break -> run -> inspect -> understand
```

**Learn GDB by debugging real programs. Not by reading about it.**

[![CI](https://github.com/iztanos/gdb-dojo/actions/workflows/ci.yml/badge.svg)](https://github.com/iztanos/gdb-dojo/actions/workflows/ci.yml)
[![Container](https://img.shields.io/badge/ghcr.io-gdb--dojo-2496ED?logo=docker&logoColor=white)](https://github.com/iztanos/gdb-dojo/pkgs/container/gdb-dojo)
[![Codespaces](https://img.shields.io/badge/Codespaces-open-24292e?logo=github)](https://codespaces.new/iztanos/gdb-dojo)
[![Shell](https://img.shields.io/badge/pure-bash-4EAA25?logo=gnubash&logoColor=white)](lib/)

**[Quick start](#quick-start)** ·
**[See it](#see-it)** ·
**[Commands](#commands)** ·
**[Curriculum](#curriculum)** ·
**[Contributing](#contributing)**

</div>

---

<table>
<tr><td width="50%" valign="top">

### The problem

GDB is the tool everyone says to learn and almost nobody does. It needs code
signing on macOS, it is awkward on Windows, and the first hour goes to fighting
the installer instead of the bug.

</td><td width="50%" valign="top">

### The dojo

A working Ubuntu + GDB in a browser tab, and a pile of small C programs with
something hidden inside. Real debugger, real binaries, nothing simulated.

</td></tr>
</table>

---

<a id="quick-start"></a>

## ⚡ Quick start

<table>
<tr><th width="33%">Zero install</th><th width="33%">Zero Docker</th><th width="33%">From source</th></tr>
<tr valign="top"><td>

```bash
docker run --rm -it \
  -p 127.0.0.1:7681:7681 \
  --cap-add=SYS_PTRACE \
  --security-opt seccomp=unconfined \
  -v gdb-dojo-state:/home/dojo/.local/share \
  ghcr.io/iztanos/gdb-dojo
```

Open **localhost:7681**

</td><td>

Open in **GitHub Codespaces** —
`Code → Codespaces`, or just
press <kbd>.</kbd> on the repo.

Same image, built in the cloud.
Works where Docker Desktop is
blocked.

</td><td>

```bash
git clone https://github.com/iztanos/gdb-dojo
cd gdb-dojo
./start-dojo.sh     # Windows: start-dojo.bat
```

Pick this to edit exercises.

</td></tr>
</table>

<sub>Full setup, including running without Docker at all → **[docs/SETUP.md](docs/SETUP.md)**</sub>

---

<a id="see-it"></a>

## 👀 See it

**The loop.** Find the value. Prove it.

```console
dojo:/dojo$ dojo next
┌────────────────────────────────────────────────────────┐
│ NEXT EXERCISE                                          │
│ 03  Inspect Local Variables                            │
└────────────────────────────────────────────────────────┘

Skill
  Inspect variables that the program never prints.

dojo:/dojo$ cd levels/guided/00-basics/03-inspect-locals && start
```

The briefing gives you the goal — **not the commands**. From exercise 03 on,
the program never prints the value. The debugger is the only way in.

<table>
<tr><td width="50%" valign="top">

**Stuck is a normal state.**
Hints escalate one step at a time.

```console
$ hint

Hint 1 of 3
  The value lives in a local
  variable the program never prints.
  Stop while it is alive and look.

$ hint

Hint 2 of 3
  `break main` then `run` stops you
  at the top of main. The assignment
  has not run yet — step with `next`.
```

Never the whole solution at once.

</td><td width="50%" valign="top">

**Progress is yours.**
Tracked, and stored outside the repo.

```console
$ dojo list

Done  Exercise
[x]   00  Build and Run
[x]   01  Run in GDB
[x]   02  First Breakpoint
[ ]   03  Inspect Local Variables
[ ]   04  Step Into Functions
[ ]   05  Basics Capstone

Progress [############........] 3 of 6
```

</td></tr>
</table>

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

---

<a id="commands"></a>

## 🧭 Commands

| | |
|---|---|
| `dojo next` | the next exercise you have not finished |
| `dojo list` | every exercise, with completion state |
| `dojo show <name>` | detail for one exercise |
| `dojo tracks` | how far along each track is |
| `hint` | one more nudge on the exercise you are in |
| `dojo cheatsheet` | the GDB commands you have unlocked |
| `dojo doctor` | check that gcc, gdb, and make actually work |
| `make reset-progress` | start over |

<sub>State lives in `$DOJO_STATE_DIR`, `$XDG_DATA_HOME/gdb-dojo`, or `~/.local/share/gdb-dojo` — never in the checkout, so `git pull` and re-cloning leave it alone.</sub>

---

<a id="curriculum"></a>

## 🗺 Curriculum

| Track | Best for | Status |
|:--|:--|:--|
| **Guided Path** | First-time GDB users, in order | **Available** |
| Beginner | Standalone skill drills | Planned |
| Intermediate | Realistic debugging tasks | Planned |
| Advanced | Harder debugging scenarios | Planned |

<details open>
<summary><b>Guided Path → 00 Basics</b></summary>

<br>

| # | Exercise | Skill |
|:--|:--|:--|
| 00 | `build-and-run` | build and run a C program |
| 01 | `run-in-gdb` | start GDB, run, and quit |
| 02 | `first-breakpoint` | break at `main` and continue |
| 03 | `inspect-locals` | `info locals`, `print` |
| 04 | `step-into-functions` | `step`, `finish` |
| 05 | `basics-capstone` | combine all of it |

**00–02 walk you through the commands** — the mechanics are the point.
**03 onward gives you the goal only** and expects you to reach for the debugger.

Next up: **01 – Breakpoints** (conditional, line, `tbreak`, `watch`).

</details>

---

<a id="contributing"></a>

## 🔧 Contributing

An exercise is just a directory. Everything specific to it lives in `meta` —
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
# or, without a local GDB:
docker compose run --rm dojo tests/run-tests.sh
```

CI runs on every pull request. For each exercise it verifies the build is
warning-free, the checker rejects bad input, the answer never appears in
plaintext — and, driving **real GDB**, that the exercise is still solvable.

<details>
<summary><b>Good first contributions</b></summary>

<br>

- A standalone drill for `beginner/`
- A clearer hint on an existing exercise
- Testing the Docker path on a platform we have not tried
- Setup or wording fixes

Conventions and the full checklist → **[docs/CONTRIBUTING.md](docs/CONTRIBUTING.md)**

</details>

<details>
<summary><b>Project layout</b></summary>

<br>

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

---

<div align="center">
<sub><code>break main</code> · <code>run</code> · <code>info locals</code> · <code>print</code> · <code>step</code> · <code>finish</code> · <code>continue</code></sub>
</div>
