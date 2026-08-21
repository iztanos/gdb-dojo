#!/usr/bin/env bash
# Skill: chase a pointer chain to its end.
. "$(dirname "${BASH_SOURCE[0]}")/_lib.sh"
sol_run_gdb "$1" "$2" "break main" "run" "next" "next" "next" "next" "next" \
    "print head->next->next->value" | sol_print_value
