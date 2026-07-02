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
    dojo_header "CORRECT"
    echo
    dojo_success "Observation accepted."
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
