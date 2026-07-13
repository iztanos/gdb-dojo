#!/usr/bin/env bash
set -e

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(cd "$script_dir/../../../.." && pwd)"
. "$repo_dir/lib/dojo-ui.sh"

dojo_clear

if [ $# -lt 1 ]; then
    dojo_error "Usage:"
    echo "  ./check.sh ACCESS_CODE"
    exit 1
fi

answer=$(printf '%s' "$1" | tr -d '[:space:]')

if [ "$answer" = "7319" ]; then
    dojo_header "CORRECT"
    echo
    dojo_success "Access granted."
    echo
    echo "Completed:"
    echo "  story/00-lobby/03-seggy-fault"
    echo
    echo "Next:"
    dojo_cmd "dojo paths"
    exit 0
fi

dojo_header "NOT QUITE"
echo
dojo_error "Inspect the local variable:"
dojo_cmd "access_code"
exit 1
