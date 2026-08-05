#!/usr/bin/env bash
# Skill: stop on a specific source line, not just a function entry.
. "$(dirname "${BASH_SOURCE[0]}")/_lib.sh"
sol_run_gdb "$1" "$2" "break main.c:7" "run" "print stage_two" | sol_print_value
