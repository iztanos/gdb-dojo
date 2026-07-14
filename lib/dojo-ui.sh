#!/usr/bin/env bash

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

dojo_hr() {
    echo "------------------------------------------------------------"
}

dojo_clear() {
    if [ -t 1 ]; then
        printf '\033[2J\033[H'
    fi
}

dojo_header() {
    title="$1"
    subtitle="${2:-}"

    printf "%b+------------------------------------------------------------+%b\n" "$CYAN" "$RESET"
    printf "%b| %-58s |%b\n" "$CYAN" "$title" "$RESET"
    if [ -n "$subtitle" ]; then
        printf "%b| %-58s |%b\n" "$CYAN" "$subtitle" "$RESET"
    fi
    printf "%b+------------------------------------------------------------+%b\n" "$CYAN" "$RESET"
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

dojo_print_file_list() {
    cat <<'EOF'
  README.md   full written instructions
  main.c      source code
  Makefile    build rules
  check.sh    answer checker
  start       this briefing
EOF
}

dojo_print_header() { dojo_header "$@"; }
dojo_print_command() { dojo_cmd "$@"; }
dojo_print_success() { dojo_success "$@"; }
dojo_print_error() { dojo_error "$@"; }
