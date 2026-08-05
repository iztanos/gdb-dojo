#!/usr/bin/env bash
# Skill: conditional breakpoint plus finish to read a running total.
. "$(dirname "${BASH_SOURCE[0]}")/_lib.sh"
sol_run_gdb "$1" "$2" "break load_crate if crate == 777" "run" "finish" \
    "print total_manifest" | sol_print_value
