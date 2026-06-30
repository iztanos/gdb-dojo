# Setup

## Current Status

GDB Dojo is early. The local browser terminal exists, but exercises have not been added yet.

## Option 1: Local Browser Terminal With Docker

This is the easiest setup once Docker is installed. The launcher scripts start Docker Compose and open the browser automatically.

```bash
git clone https://github.com/iztanos/gdb-dojo.git
cd gdb-dojo
```

On Windows, run:

```powershell
.\start-dojo.bat
```

You can also double-click `start-dojo.bat`.

On macOS/Linux, run:

```bash
chmod +x start-dojo.sh
./start-dojo.sh
```

Manual fallback:

```bash
docker compose up --build
```

If the browser does not open automatically, visit:

[http://localhost:7681](http://localhost:7681)

The repo is mounted at `/dojo`. The container includes GDB, GCC, G++, Make, Vim, Nano, binutils, and related tools. This avoids installing GDB directly on the host system.

To stop the container:

```bash
docker compose down
```

## Option 2: Debug Files On Your Own System

When exercises are added, they should be simple enough that users can download or copy the program files and debug locally without the browser terminal. This is useful for people who already have GDB and a compiler installed.

Typical commands may look like:

```bash
gcc -g -O0 -Wall -Wextra -o program main.c
gdb ./program
```

Exact commands may vary per exercise. Each exercise should eventually include its own build instructions.

## Linux Setup

Debian/Ubuntu:

```bash
sudo apt update
sudo apt install build-essential gdb make gcc g++ binutils file
```

Fedora:

```bash
sudo dnf install gcc gcc-c++ gdb make binutils file
```

Arch:

```bash
sudo pacman -S base-devel gdb binutils file
```

## macOS Setup

The Docker browser terminal is the recommended path on macOS for consistent GDB behavior.

Native macOS debugging often uses LLDB instead of GDB. GDB on macOS may require extra code-signing setup, so this project should not depend on native macOS GDB as the default path.

With Homebrew:

```bash
brew install gdb
```

Extra setup may still be required.

## Windows Setup

Recommended options:

1. Docker Desktop with the local browser terminal.
2. WSL2 with Ubuntu and the Linux setup commands.

For WSL2 Ubuntu:

```bash
sudo apt update
sudo apt install build-essential gdb make gcc g++ binutils file
```

Native Windows GDB setups vary. Docker or WSL2 is recommended for consistency.

## Verifying Tools

```bash
gdb --version
gcc --version
make --version
```

## Troubleshooting

Port `7681` already in use: stop the other process or change the Compose port mapping.

Docker not running: start Docker Desktop or your Docker service, then retry.

Permission issues with mounted files: check host file permissions and whether Docker can access the repo folder.

`gdb` command not found on host: use the Docker browser terminal or install GDB for your system.

Browser terminal starts but repo files are missing: confirm you ran Docker Compose from the repo root.
