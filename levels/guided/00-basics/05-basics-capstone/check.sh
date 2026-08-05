#!/usr/bin/env bash
set -e

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(cd "$script_dir/../../../.." && pwd)"
. "$repo_dir/lib/dojo-ui.sh"
. "$repo_dir/lib/dojo-check.sh"

dojo_require_answer $#

dojo_check "9d7d2e3793b5f9c970e1749e8311c3fb17bb63befc8b7e6716d741040401f2a0" \
    "$1" \
    "upper" \
    "step" \
    "print final_value"
