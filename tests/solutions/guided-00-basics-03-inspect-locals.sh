#!/usr/bin/env bash
# Skill: stop at main, step past the assignment, inspect a local.
. "$(dirname "${BASH_SOURCE[0]}")/_lib.sh"
sol_run_gdb "$1" "$2" "break main" "run" "next" "print access_code" \
    | sol_print_value | tr -d '[:space:]'
