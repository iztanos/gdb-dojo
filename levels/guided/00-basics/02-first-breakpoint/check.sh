#!/usr/bin/env bash
set -e

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(cd "$script_dir/../../../.." && pwd)"
. "$repo_dir/lib/dojo-ui.sh"
. "$repo_dir/lib/dojo-check.sh"

dojo_require_answer $#

dojo_check "e5aa41f81278c3d0b35fb040c71a815cd0dbd3b4c24f1097cd4edf7e78d5eeba" \
    "$1" \
    "upper" \
    "break main" \
    "continue"
