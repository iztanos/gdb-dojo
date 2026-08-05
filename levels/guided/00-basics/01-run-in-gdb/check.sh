#!/usr/bin/env bash
set -e

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(cd "$script_dir/../../../.." && pwd)"
. "$repo_dir/lib/dojo-ui.sh"
. "$repo_dir/lib/dojo-check.sh"

dojo_require_answer $#

dojo_check "d80ffc8dc07953482a2f9f5fbff9a9cecea5d0022155f32af0b56e91d1bee7d3" \
    "$1" \
    "upper" \
    "run" \
    "quit"
