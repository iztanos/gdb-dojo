#!/usr/bin/env bash
set -e

if [ $# -lt 1 ]; then
    echo "Usage: ./check.sh BADGE_WORD"
    exit 1
fi

answer=$(printf '%s' "$1" | tr -d '[:space:]' | tr '[:lower:]' '[:upper:]')

if [ "$answer" = "WHISKER" ]; then
    echo "Correct. Seggy stamps your temporary badge."
    exit 0
fi

echo "Incorrect. Seggy squints at the badge printer."
exit 1
