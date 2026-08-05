#!/usr/bin/env bash
#
# Answer checking.
#
# Expected answers are stored as SHA-256 hashes in each exercise `meta` file so
# that reading the exercise directory does not reveal the answer.
#
# Normalization modes:
#   upper   strip whitespace, uppercase   (default; word answers)
#   digits  strip whitespace              (numeric answers)
#   exact   strip whitespace              (case-sensitive answers)

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
    _value="$(printf '%s' "$1" | tr -d '[:space:]')"
    case "${2:-upper}" in
        upper)          printf '%s' "$_value" | tr '[:lower:]' '[:upper:]' ;;
        exact | digits) printf '%s' "$_value" ;;
        *)              echo "dojo: unknown normalization mode: $2" >&2; return 1 ;;
    esac
}

# dojo_check_exercise <exercise-dir> [submitted-answer]
#
# Reads ANSWER / MODE / HINTS from the exercise `meta` file, compares, prints
# the result, and records completion on success.
dojo_check_exercise() {
    _dir="$(cd "$1" && pwd)"
    shift

    _root="$(dojo_find_root "$_dir")" || return 1
    _rel="${_dir#"$_root"/}"

    if [ "$#" -lt 1 ] || [ -z "${1:-}" ]; then
        dojo_clear
        dojo_error "Usage:"
        echo "  ./check.sh ANSWER"
        echo
        echo "Re-read the briefing with:"
        dojo_cmd "start"
        return 1
    fi

    _expected="$(dojo_meta "$_rel" ANSWER "$_root")"
    if [ -z "$_expected" ]; then
        dojo_error "This exercise has no ANSWER recorded in its meta file."
        return 1
    fi
    _mode="$(dojo_meta "$_rel" MODE "$_root")"
    _mode="${_mode:-upper}"

    _normalized="$(dojo_normalize "$1" "$_mode")" || return 1
    _actual="$(dojo_sha256 "$_normalized")" || return 1

    dojo_clear

    if [ "$_actual" = "$_expected" ]; then
        dojo_progress_mark "$_rel" "$_root"

        dojo_header "CORRECT" "$(dojo_meta "$_rel" TITLE "$_root")"
        echo
        dojo_success "Exercise complete."
        echo

        _total="$(dojo_exercises "$_root" | wc -l | tr -d '[:space:]')"
        _done="$(dojo_exercises "$_root" | dojo_progress_count "$_root")"
        printf 'Progress  %s of %s\n\n' "$_done" "$_total"

        _next="$(dojo_progress_next "$_root")"
        if [ -n "$_next" ]; then
            echo "Next"
            dojo_cmd "cd $_root/$_next && start"
        else
            dojo_success "Every exercise is complete. Well done."
        fi
        return 0
    fi

    dojo_header "NOT QUITE" "$(dojo_meta "$_rel" TITLE "$_root")"
    echo
    _hints="$(dojo_meta "$_rel" HINTS "$_root")"
    if [ -n "$_hints" ]; then
        dojo_error "Try:"
        printf '%s' "$_hints" | tr '|' '\n' | while IFS= read -r _h; do
            [ -n "$_h" ] && dojo_cmd "$_h"
        done
    else
        dojo_error "That is not the expected value."
    fi
    return 1
}
