#!/usr/bin/env bash
# Skill: step into a helper, finish back out, then read the assigned value.
#
# `finish` returns to main with the call complete but the assignment to
# `result` not yet retired, so one `next` is needed before printing.
. "$(dirname "${BASH_SOURCE[0]}")/_lib.sh"
sol_run_gdb "$1" "$2" "break main" "run" "step" "finish" "next" "print result" \
    | sol_quoted_string
