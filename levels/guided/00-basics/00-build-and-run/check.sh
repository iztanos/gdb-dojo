#!/usr/bin/env bash
set -e

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(cd "$script_dir/../../../.." && pwd)"
. "$repo_dir/lib/dojo-ui.sh"
. "$repo_dir/lib/dojo-check.sh"

dojo_require_answer $#

dojo_check "c2e3ac47f4a325469c1a2d5f117e463ec943c721986d5d9f09ac4540b7d80526" \
    "$1" \
    "upper" \
    "start"
