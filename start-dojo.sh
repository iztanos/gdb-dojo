#!/usr/bin/env bash
set -e

echo "GDB Dojo local browser terminal"
echo

if ! command -v docker >/dev/null 2>&1; then
    echo "Docker was not found. Install Docker, then try again."
    exit 1
fi

if ! docker info >/dev/null 2>&1; then
    echo "Docker is installed but not running. Start Docker, then try again."
    exit 1
fi

if docker compose version >/dev/null 2>&1; then
    echo "Open http://localhost:7681"
    docker compose up --build
elif command -v docker-compose >/dev/null 2>&1; then
    echo "Open http://localhost:7681"
    docker-compose up --build
else
    echo "Docker Compose was not found. Install or update Docker."
    exit 1
fi
