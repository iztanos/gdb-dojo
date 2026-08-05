#!/usr/bin/env bash
# Skill: break at main, then continue to completion.
. "$(dirname "${BASH_SOURCE[0]}")/_lib.sh"
sol_run_gdb "$1" "$2" "break main" "run" "continue" \
    | grep -A1 'Execution status:' | tail -1 | tr -d '[:space:]'
