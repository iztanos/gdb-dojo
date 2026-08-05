#!/usr/bin/env bash
#
# Shared terminal UI helpers. Sourced by ./dojo, lib/dojo-start.sh, and every
# exercise check.sh.

# The color variables below are consumed by the scripts that source this file,
# which shellcheck cannot see from here.
# shellcheck disable=SC2034

dojo_use_color() {
    { [ -t 1 ] || [ -n "${FORCE_COLOR:-}" ]; } && [ -z "${NO_COLOR:-}" ]
}

if dojo_use_color; then
    RESET='\033[0m'
    BOLD='\033[1m'
    DIM='\033[2m'
    CYAN='\033[36m'
    YELLOW='\033[33m'
    GREEN='\033[32m'
    RED='\033[31m'
else
    RESET=''
    BOLD=''
    DIM=''
    CYAN=''
    YELLOW=''
    GREEN=''
    RED=''
fi

DOJO_WIDTH=60

dojo_clear() {
    if [ -t 1 ]; then
        printf '\033[2J\033[H'
    fi
}

dojo_rule() {
    printf '%b%s%b\n' "$DIM" "$(printf '%*s' "$DOJO_WIDTH" '' | tr ' ' '-')" "$RESET"
}

dojo_header() {
    _title="$1"
    _subtitle="${2:-}"
    _inner=$((DOJO_WIDTH - 2))
    _bar="$(printf '%*s' "$_inner" '' | tr ' ' '-')"

    printf "%b+%s+%b\n" "$CYAN" "$_bar" "$RESET"
    printf "%b| %-*s |%b\n" "$CYAN" "$((_inner - 2))" "$_title" "$RESET"
    if [ -n "$_subtitle" ]; then
        printf "%b| %-*s |%b\n" "$CYAN" "$((_inner - 2))" "$_subtitle" "$RESET"
    fi
    printf "%b+%s+%b\n" "$CYAN" "$_bar" "$RESET"
}

dojo_section() {
    printf '%b%s%b\n' "$BOLD$CYAN" "$1" "$RESET"
}

dojo_cmd() {
    printf "%b  %s%b\n" "$GREEN" "$1" "$RESET"
}

dojo_success() {
    printf "%b%s%b\n" "$GREEN" "$1" "$RESET"
}

dojo_error() {
    printf "%b%s%b\n" "$RED" "$1" "$RESET"
}

dojo_warn() {
    printf "%b%s%b\n" "$YELLOW" "$1" "$RESET"
}

dojo_dim() {
    printf "%b%s%b\n" "$DIM" "$1" "$RESET"
}

# Render a table from tab-separated rows on stdin, sizing every column to its
# widest cell. Replaces the hand-counted printf widths that misaligned as soon
# as an exercise name grew.
#
#   printf 'A\tB\n1\t2\n' | dojo_table
dojo_table() {
    awk -F'\t' -v bold="$BOLD" -v dim="$DIM" -v reset="$RESET" '
        { for (i = 1; i <= NF; i++) { cell[NR, i] = $i;
              if (length($i) > w[i]) w[i] = length($i) }
          if (NF > maxf) maxf = NF; rows = NR }
        END {
            for (r = 1; r <= rows; r++) {
                line = ""
                for (i = 1; i <= maxf; i++) {
                    pad = w[i] - length(cell[r, i])
                    line = line cell[r, i]
                    if (i < maxf) { line = line sprintf("%*s", pad + 2, "") }
                }
                if (r == 1) printf "%s%s%s\n", bold, line, reset
                else        printf "%s\n", line
            }
        }'
}
