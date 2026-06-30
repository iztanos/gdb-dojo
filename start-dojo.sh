#!/usr/bin/env bash
set -e

URL="http://localhost:7681"

open_browser() {
    if [[ "$(uname -s)" == "Darwin" ]] && command -v open >/dev/null 2>&1; then
        open "$URL" >/dev/null 2>&1 || true
    elif grep -qi microsoft /proc/version 2>/dev/null && command -v cmd.exe >/dev/null 2>&1; then
        cmd.exe /c start "$URL" >/dev/null 2>&1 || true
    elif command -v xdg-open >/dev/null 2>&1; then
        xdg-open "$URL" >/dev/null 2>&1 || true
    else
        return 0
    fi
}

print_panel() {
    cat <<EOF
+--------------------------------------------------+
| GDB Dojo                                         |
| Local browser terminal                           |
+--------------------------------------------------+

Repo:        $(pwd)
Mounted at:  /dojo
Terminal:    $URL
Container:   gdb-dojo
Tools:       gdb, gcc, g++, make, vim, nano

Press Ctrl+C to stop, then run docker compose down if needed.

EOF
}

if ! command -v docker >/dev/null 2>&1; then
    echo "Docker was not found. Install Docker, then try again."
    exit 1
fi

if ! docker info >/dev/null 2>&1; then
    echo "Docker is installed but not running. Start Docker, then try again."
    exit 1
fi

if docker compose version >/dev/null 2>&1; then
    print_panel
    echo "Building image quietly..."
    docker compose build --quiet
    echo "Opening browser..."
    (sleep 2; open_browser) &
    echo "Starting terminal..."
    echo
    docker compose up
elif command -v docker-compose >/dev/null 2>&1; then
    print_panel
    echo "Building image..."
    docker-compose build
    echo "Opening browser..."
    (sleep 2; open_browser) &
    echo "Starting terminal..."
    echo
    docker-compose up
else
    echo "Docker Compose was not found. Install or update Docker."
    exit 1
fi
