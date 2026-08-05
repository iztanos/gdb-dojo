#!/usr/bin/env bash
# Shared helpers for solution scripts.
#
# A solution script receives the exercise directory as $1 and the built binary
# name as $2, and prints the exercise answer on stdout. Solutions record the
# GDB *method* for reaching the answer, never the answer itself, so the test
# suite can prove each exercise is solvable without storing a spoiler.

set -uo pipefail

sol_run_gdb() {
    local dir="$1" target="$2"; shift 2
    local args=()
    for cmd in "$@"; do args+=(-ex "$cmd"); done
    (cd "$dir" && gdb -q -batch -nx "${args[@]}" "./$target" 2>/dev/null)
}

sol_run_plain() {
    local dir="$1" target="$2"
    (cd "$dir" && "./$target" 2>/dev/null)
}

# Value of the first GDB `print` result, e.g. `$1 = 7319` -> 7319
sol_print_value() {
    sed -nE 's/^\$[0-9]+ = (.*)$/\1/p' | head -1
}

# First double-quoted string inside the `print` result, e.g.
#   $1 = 0x555555556004 "RESULT-42"   -> RESULT-42
# Scoped to the `$N = ...` line so GDB's own banners (notably
# `Using host libthread_db library "..."`) cannot match first.
sol_quoted_string() {
    sol_print_value | sed -nE 's/[^"]*"([^"]*)".*/\1/p' | head -1
}
