#!/usr/bin/env bash
# Skill: let the helper return, then inspect the value it produced.
. "$(dirname "${BASH_SOURCE[0]}")/_lib.sh"
sol_run_gdb "$1" "$2" "break main" "run" "next" "print result" \
    | sol_quoted_string
