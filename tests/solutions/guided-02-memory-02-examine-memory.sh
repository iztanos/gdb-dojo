#!/usr/bin/env bash
# Skill: read raw memory with x when print does not decode it usefully.
. "$(dirname "${BASH_SOURCE[0]}")/_lib.sh"
sol_run_gdb "$1" "$2" "break main" "run" "next" "next" "x/4xb code" | sol_x_values | awk '{print $3}'
