#!/usr/bin/env bash
set -e

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(cd "$script_dir/../../../.." && pwd)"
. "$repo_dir/lib/dojo-ui.sh"

dojo_clear

if [ $# -lt 1 ]; then
    dojo_error "Usage:"
    echo "  ./check.sh ANSWER"
    exit 1
fi

answer=$(printf '%s' "$1" | tr -d '[:space:]' | tr '[:lower:]' '[:upper:]')

if [ "$answer" = "GDB-BASICS" ]; then
    dojo_header "CORRECT"
    echo
    dojo_success "Exercise complete."
    echo
    echo "Next:"
    dojo_cmd "dojo paths"
    exit 0
fi

dojo_header "NOT QUITE"
echo
dojo_error "Try:"
dojo_cmd "step"
dojo_cmd "print final_value"
exit 1
