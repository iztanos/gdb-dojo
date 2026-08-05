#!/usr/bin/env bash
#
# Shared answer-checking helpers for exercise check.sh scripts.
#
# Expected answers are stored as SHA-256 hashes so that reading check.sh does
# not reveal the answer. Exercises call dojo_check with the hash of the
# normalized answer.
#
# Normalization modes:
#   upper   strip all whitespace, uppercase   (default; for word answers)
#   exact   strip all whitespace only         (for case-sensitive answers)
#   digits  strip all whitespace              (for numeric answers)

dojo_sha256() {
    if command -v sha256sum >/dev/null 2>&1; then
        printf '%s' "$1" | sha256sum | cut -d' ' -f1
    elif command -v shasum >/dev/null 2>&1; then
        printf '%s' "$1" | shasum -a 256 | cut -d' ' -f1
    elif command -v openssl >/dev/null 2>&1; then
        printf '%s' "$1" | openssl dgst -sha256 | awk '{print $NF}'
    else
        echo "dojo: no SHA-256 tool found (need sha256sum, shasum, or openssl)" >&2
        return 1
    fi
}

dojo_normalize() {
    _value="$1"
    _mode="${2:-upper}"

    _value=$(printf '%s' "$_value" | tr -d '[:space:]')

    case "$_mode" in
        upper)
            printf '%s' "$_value" | tr '[:lower:]' '[:upper:]'
            ;;
        exact | digits)
            printf '%s' "$_value"
            ;;
        *)
            echo "dojo: unknown normalization mode: $_mode" >&2
            return 1
            ;;
    esac
}

# dojo_check <expected_sha256> <submitted> [mode] [hint...]
#
# Prints the standard correct/incorrect UI and returns 0 on a match, 1 otherwise.
dojo_check() {
    _expected="$1"
    _submitted="$2"
    _mode="${3:-upper}"
    shift 3 2>/dev/null || shift $#

    _normalized=$(dojo_normalize "$_submitted" "$_mode") || return 1
    _actual=$(dojo_sha256 "$_normalized") || return 1

    dojo_clear

    if [ "$_actual" = "$_expected" ]; then
        dojo_header "CORRECT"
        echo
        dojo_success "Exercise complete."
        echo
        echo "Next:"
        dojo_cmd "dojo paths"
        return 0
    fi

    dojo_header "NOT QUITE"
    echo
    if [ "$#" -gt 0 ]; then
        dojo_error "Try:"
        for _hint in "$@"; do
            dojo_cmd "$_hint"
        done
    else
        dojo_error "That is not the expected value."
    fi
    return 1
}

# dojo_require_answer <argc> — prints usage and exits when no answer was given.
dojo_require_answer() {
    if [ "$1" -lt 1 ]; then
        dojo_clear
        dojo_error "Usage:"
        echo "  ./check.sh ANSWER"
        exit 1
    fi
}
