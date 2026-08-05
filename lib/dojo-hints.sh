#!/usr/bin/env bash
#
# Progressive hints.
#
# Each exercise defines HINT1..HINTn in its `meta` file, ordered from a gentle
# nudge to a near-complete walkthrough. Hints are revealed one at a time, either
# because a submitted answer was wrong or because the learner asked with
# `dojo hint`.
#
# The reveal count lives in .dojo/hints so that a learner who steps away does
# not lose their place, and so an exercise never dumps its full solution the
# moment someone guesses once.

dojo_hints_file() {
    printf '%s/.dojo/hints' "${1:-$(dojo_find_root)}"
}

# Total hints defined for an exercise.
dojo_hint_total() {
    _dir="$1"
    _root="${2:-$(dojo_find_root)}"
    grep -cE '^HINT[0-9]+=.' "$_root/$_dir/meta" 2>/dev/null || printf '0'
}

# How many hints have been revealed so far.
dojo_hint_shown() {
    _dir="$1"
    _root="${2:-$(dojo_find_root)}"
    _file="$(dojo_hints_file "$_root")"
    [ -f "$_file" ] || { printf '0'; return; }
    _n="$(awk -F'\t' -v d="$_dir" '$1 == d { print $2 }' "$_file" | tail -1)"
    printf '%s' "${_n:-0}"
}

# Reveal one more hint. Prints the new count, capped at the total.
dojo_hint_advance() {
    _dir="$1"
    _root="${2:-$(dojo_find_root)}"
    _total="$(dojo_hint_total "$_dir" "$_root")"
    _shown="$(dojo_hint_shown "$_dir" "$_root")"

    if [ "$_shown" -ge "$_total" ]; then
        printf '%s' "$_total"
        return
    fi

    _next=$((_shown + 1))
    _file="$(dojo_hints_file "$_root")"
    mkdir -p "$(dirname "$_file")" 2>/dev/null || { printf '%s' "$_next"; return; }

    if [ -f "$_file" ] && awk -F'\t' -v d="$_dir" '$1 != d' "$_file" > "$_file.tmp"; then
        mv "$_file.tmp" "$_file"
    fi
    printf '%s\t%s\n' "$_dir" "$_next" >> "$_file"
    printf '%s' "$_next"
}

dojo_hint_reset() {
    _dir="$1"
    _root="${2:-$(dojo_find_root)}"
    _file="$(dojo_hints_file "$_root")"
    [ -f "$_file" ] || return 0
    awk -F'\t' -v d="$_dir" '$1 != d' "$_file" > "$_file.tmp" && mv "$_file.tmp" "$_file"
}

# Print every hint revealed so far, newest last.
dojo_hints_print() {
    _dir="$1"
    _root="${2:-$(dojo_find_root)}"
    _shown="$(dojo_hint_shown "$_dir" "$_root")"
    _total="$(dojo_hint_total "$_dir" "$_root")"

    [ "$_shown" -gt 0 ] || return 0

    _i=1
    while [ "$_i" -le "$_shown" ]; do
        _text="$(dojo_meta "$_dir" "HINT$_i" "$_root")"
        if [ -n "$_text" ]; then
            printf '%bHint %s of %s%b\n' "$BOLD$YELLOW" "$_i" "$_total" "$RESET"
            printf '%s\n' "$_text" | tr '|' '\n' | while IFS= read -r _line; do
                [ -n "$_line" ] && printf '  %s\n' "$_line"
            done
            echo
        fi
        _i=$((_i + 1))
    done
}

# Footer telling the learner how to get more help, or that there is none left.
dojo_hints_footer() {
    _dir="$1"
    _root="${2:-$(dojo_find_root)}"
    _shown="$(dojo_hint_shown "$_dir" "$_root")"
    _total="$(dojo_hint_total "$_dir" "$_root")"

    if [ "$_total" -eq 0 ]; then
        return 0
    fi
    if [ "$_shown" -lt "$_total" ]; then
        printf '%bStuck?%b  %s hint(s) left\n' "$DIM" "$RESET" "$((_total - _shown))"
        dojo_cmd "dojo hint"
    else
        printf '%bAll hints shown. The full walkthrough is in README.md%b\n' "$DIM" "$RESET"
    fi
}
