#!/usr/bin/env bash
# Skill: run the program from inside GDB.
. "$(dirname "${BASH_SOURCE[0]}")/_lib.sh"
sol_run_gdb "$1" "$2" "run" | grep -A1 'Debugger run status:' | tail -1 | tr -d '[:space:]'
