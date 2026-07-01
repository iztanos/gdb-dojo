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

## Start

Windows:

```powershell
.\start-dojo.bat
```

macOS/Linux:

```bash
./start-dojo.sh
```

Then follow the terminal welcome message.

For full setup instructions, see [docs/SETUP.md](docs/SETUP.md).

## Modes

| Mode | Best for | Status | Link |
|---|---|---|---|
| Story Mode | First-time GDB users | Started | [levels/story](levels/story) |
| Beginner | Standalone skill drills | Planned | [levels/beginner](levels/beginner) |
| Intermediate | Realistic debugging tasks | Planned | [levels/intermediate](levels/intermediate) |
| Advanced | Harder scenarios | Planned | [levels/advanced](levels/advanced) |

## First Exercise

`levels/story/00-lobby/00-welcome-desk`

See the exercise README for instructions.

## Resetting

For reset and restore commands, see [docs/SETUP.md](docs/SETUP.md#resetting).

## Contributing

People can contribute their own debugging exercises, improve existing ones, or suggest new Story Mode ideas. See [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md).

All future practice content will be designed for local debugging scenarios.
