#!/usr/bin/env bash
set -e

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(cd "$script_dir/../../../.." && pwd)"
. "$repo_dir/lib/dojo-ui.sh"

dojo_clear

if [ $# -lt 1 ]; then
    dojo_error "Usage:"
    echo "  ./check.sh DOOR_WORD"
    exit 1
fi

answer=$(printf '%s' "$1" | tr -d '[:space:]' | tr '[:lower:]' '[:upper:]')

if [ "$answer" = "HINGE" ]; then
    mkdir -p "$repo_dir/.dojo/completed" "$repo_dir/.dojo/unlocked"
    touch "$repo_dir/.dojo/completed/story-00-lobby-02-moving-door"
    touch "$repo_dir/.dojo/unlocked/story-00-lobby-03-seggy-fault"

    dojo_header "CORRECT"
    echo
    dojo_success "Door word accepted."
    echo
    echo "Progress:"
    echo "  completed  story/00-lobby/02-moving-door"
    echo "  unlocked   story/00-lobby/03-seggy-fault"
    echo
    echo "Next:"
    echo "  story/00-lobby/03-seggy-fault is planned."
    exit 0
fi

dojo_header "NOT QUITE"
echo
dojo_error "Door word did not match."
echo
echo "Try again:"
dojo_cmd "./moving-door"
dojo_cmd "./check.sh DOOR_WORD"
exit 1
