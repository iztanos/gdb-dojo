#!/usr/bin/env bash
# Skill: a breakpoint that only fires for one iteration out of 5000.
. "$(dirname "${BASH_SOURCE[0]}")/_lib.sh"
sol_run_gdb "$1" "$2" "break main.c:14 if id == 4217" "run" "next" "print value" \
    | sol_print_value
