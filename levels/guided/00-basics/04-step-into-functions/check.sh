#!/usr/bin/env bash
set -e

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(cd "$script_dir/../../../.." && pwd)"
. "$repo_dir/lib/dojo-ui.sh"
. "$repo_dir/lib/dojo-check.sh"

dojo_require_answer $#

dojo_check "462646ecaf6e6205d86fee3b92ba75d39db2e1961d6b6d7f7bd2221c4bfc9695" \
    "$1" \
    "upper" \
    "step" \
    "print result"
