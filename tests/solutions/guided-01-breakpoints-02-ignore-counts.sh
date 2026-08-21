#!/usr/bin/env bash
# Skill: skip the first N hits of a breakpoint instead of continuing by hand.
. "$(dirname "${BASH_SOURCE[0]}")/_lib.sh"
sol_run_gdb "$1" "$2" "break sensor_reading" "ignore 1 249" "run" "finish" "next" \
    "print reading" | sol_print_value
