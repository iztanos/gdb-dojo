#!/usr/bin/env bash
set -e

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(cd "$script_dir/../../../.." && pwd)"
. "$repo_dir/lib/dojo-ui.sh"

dojo_clear

if [ $# -lt 1 ]; then
    dojo_error "Usage:"
    echo "  ./check.sh PHRASE"
    exit 1
fi

answer=$(printf '%s' "$1" | tr -d '[:space:]' | tr '[:lower:]' '[:upper:]')

if [ "$answer" = "BLINK" ]; then
    mkdir -p "$repo_dir/.dojo/completed" "$repo_dir/.dojo/unlocked"
    touch "$repo_dir/.dojo/completed/story-00-lobby-01-glass-box"
    touch "$repo_dir/.dojo/unlocked/story-00-lobby-02-moving-door"

    dojo_header "CORRECT"
    echo
    dojo_success "Observation accepted."
    echo
    echo "Progress:"
    echo "  completed  story/00-lobby/01-glass-box"
    echo "  unlocked   story/00-lobby/02-moving-door"
    echo
    echo "Next:"
    dojo_cmd "./dojo lobby"
    exit 0
fi

dojo_header "NOT QUITE"
echo
dojo_error "Observation phrase did not match."
echo
echo "Try again:"
dojo_cmd "./glassbox"
dojo_cmd "./check.sh PHRASE"
exit 1
