#!/usr/bin/env bash
# Skill: index into an array at a position found in the debugger.
. "$(dirname "${BASH_SOURCE[0]}")/_lib.sh"
sol_run_gdb "$1" "$2" "break main" "run" "next" "next" "next" "print scores[target_index]" | sol_print_value
