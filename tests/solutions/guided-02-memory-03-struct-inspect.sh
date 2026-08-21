#!/usr/bin/env bash
# Skill: read a struct field through a pointer.
. "$(dirname "${BASH_SOURCE[0]}")/_lib.sh"
sol_run_gdb "$1" "$2" "break main" "run" "next" "next" "next" "print entry_ptr->balance" | sol_print_value
