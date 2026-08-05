#!/usr/bin/env bash
set -e

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_dir="$(cd "$script_dir/../../../.." && pwd)"
. "$repo_dir/lib/dojo-ui.sh"
. "$repo_dir/lib/dojo-check.sh"

dojo_require_answer $#

dojo_check "cd91c5876cd288087223b6e1b844a78dfeb0d2298d56814e3388934274fb9277" \
    "$1" \
    "digits" \
    "info locals" \
    "print access_code"
