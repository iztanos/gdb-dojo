#!/usr/bin/env bash
# Skill: read the value a pointer points to, not the pointer itself.
. "$(dirname "${BASH_SOURCE[0]}")/_lib.sh"
sol_run_gdb "$1" "$2" "break main" "run" "next" "next" "next" "print *level_ptr" | sol_print_value
