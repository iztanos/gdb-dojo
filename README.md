# GDB Dojo

```text
  ____ ____  ____    ____   ___      _  ___              /\_____/\
 / ___|  _ \| __ )  |  _ \ / _ \    | |/ _ \            /  o   x  \
| |  _| | | |  _ \  | | | | | | |_  | | | | |          ( ==  ^  == )
| |_| | |_| | |_) | | |_| | |_| | |_| | |_| |           )_________(
 \____|____/|____/  |____/ \___/ \___/ \___/

 break -> run -> inspect -> understand
```

GDB Dojo is a hands-on GDB practice project for learning real software debugging.

It includes a local browser terminal, a guided Story Mode, and space for standalone beginner/intermediate/advanced exercises.

## Start Here

For the browser terminal:

Windows:

```powershell
.\start-dojo.bat
```

macOS/Linux:

```bash
./start-dojo.sh
```

Then open, if it does not open automatically:

[http://localhost:7681](http://localhost:7681)

For detailed setup, see [docs/SETUP.md](docs/SETUP.md).

## Modes

| Mode | Status | Best for | Link |
|---|---|---|---|
| Story Mode | Started | First-time GDB users who want a guided path | [levels/story](levels/story) |
| Beginner | Planned | Official and community exercises focused on one GDB skill at a time | [levels/beginner](levels/beginner) |
| Intermediate | Planned | Official and community exercises with more realistic debugging tasks | [levels/intermediate](levels/intermediate) |
| Advanced | Planned | Official and community exercises with harder debugging scenarios | [levels/advanced](levels/advanced) |

## Story Mode

Story Mode is the guided path. Start here if you are new to GDB.

| Level | Status | Teaches | Link |
|---|---|---|---|
| Level 0: The Lobby | Started | build, run, first inspection, basic GDB flow | [levels/story/00-lobby](levels/story/00-lobby) |

Current first exercise:

| Option | Use when | Start |
|---|---|---|
| Browser terminal | You want the built-in environment | Run `./start-dojo.sh` or `.\start-dojo.bat`, then open [localhost:7681](http://localhost:7681) |
| Manual | You already have GCC and Make | `cd levels/story/00-lobby/00-welcome-desk && make && ./welcome` |

```bash
cd levels/story/00-lobby/00-welcome-desk
make
./welcome
./check.sh BADGE_WORD
```

## Local Browser Terminal

The browser terminal runs locally in Docker. The repo is mounted at `/dojo`.

Useful commands inside the terminal:

```bash
cd /dojo
cd levels/story/00-lobby/00-welcome-desk
make
./welcome
```

Docker is only required for the browser terminal path. Future exercises can also be downloaded or run directly with a local GDB/GCC setup.

## Resetting

If you only want to clean build files:

```bash
make clean-story-0
```

If you changed one exercise too much:

```bash
git restore levels/story/00-lobby/00-welcome-desk
```

If you want to reset Story Mode progress:

```bash
make reset-progress
```

PowerShell:

```powershell
Remove-Item -Recurse -Force .dojo
```

If you want to reset all tracked files:

```bash
git restore .
```

Use this carefully. It discards local changes to tracked files.

## Contributing

People can contribute their own debugging exercises, improve existing ones, or suggest new Story Mode ideas. See [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md) for the exercise format and pull request guidelines.

All future practice content will be designed for local debugging scenarios.
