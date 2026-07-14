#!/usr/bin/env bash
set -e

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(cd "$script_dir/../../../.." && pwd)"
. "$repo_dir/lib/dojo-ui.sh"

dojo_clear

if [ $# -lt 1 ]; then
    dojo_error "Usage:"
    echo "  ./check.sh EXIT_TOKEN"
    exit 1
fi

answer=$(printf '%s' "$1" | tr -d '[:space:]' | tr '[:lower:]' '[:upper:]')

if [ "$answer" = "OPEN-DOJO" ]; then
    dojo_header "CORRECT"
    echo
    dojo_success "Lobby exit accepted."
    echo
    echo "Level 0 complete."
    echo
    echo "Next:"
    dojo_cmd "dojo paths"
    exit 0
fi

dojo_header "NOT QUITE"
echo
dojo_error "Inspect the token variable:"
dojo_cmd "print exit_token"
exit 1
