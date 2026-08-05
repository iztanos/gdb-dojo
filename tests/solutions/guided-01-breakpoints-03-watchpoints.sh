#!/usr/bin/env bash
# Skill: stop when a variable is written, rather than at a code location.
. "$(dirname "${BASH_SOURCE[0]}")/_lib.sh"
sol_run_gdb "$1" "$2" "watch access_level" "run" | sol_watch_new
