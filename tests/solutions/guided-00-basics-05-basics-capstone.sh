#!/usr/bin/env bash
# Skill: combine break/run/finish/print to read a buffer filled by a helper.
#
# `break main` lands on the opening brace when main declares a stack array, so
# the number of `next` steps needed is not stable. Breaking on the helper and
# using `finish` returns to main with the buffer already written.
. "$(dirname "${BASH_SOURCE[0]}")/_lib.sh"
sol_run_gdb "$1" "$2" "break build_final_value" "run" "finish" "print final_value" \
    | sol_quoted_string
