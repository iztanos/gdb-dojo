#!/usr/bin/env bash
set -e

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(cd "$script_dir/../../../.." && pwd)"
. "$repo_dir/lib/dojo-ui.sh"

dojo_clear

if [ $# -lt 1 ]; then
    dojo_error "Usage:"
    echo "  ./check.sh STAMP_VALUE"
    exit 1
fi

answer=$(printf '%s' "$1" | tr -d '[:space:]' | tr '[:lower:]' '[:upper:]')

if [ "$answer" = "STAMP-42" ]; then
    dojo_header "CORRECT"
    echo
    dojo_success "Stamp accepted."
    echo
    echo "Completed:"
    echo "  story/00-lobby/04-stamp-machine"
    echo
    echo "Next:"
    dojo_cmd "dojo paths"
    exit 0
fi

dojo_header "NOT QUITE"
echo
dojo_error "Inspect the returned value:"
dojo_cmd "step"
dojo_cmd "finish"
dojo_cmd "print stamp"
exit 1
