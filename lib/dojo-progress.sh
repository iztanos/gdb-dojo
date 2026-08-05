#!/usr/bin/env bash
#
# Progress tracking.
#
# Completed exercises are recorded one per line in .dojo/progress at the repo
# root. The directory is gitignored, so progress is local to each learner and
# never ends up in a commit. `make reset-progress` removes it.

dojo_progress_file() {
    _root="${1:-$(dojo_find_root)}"
    printf '%s/.dojo/progress' "$_root"
}

# dojo_progress_mark <exercise-dir> [root]
dojo_progress_mark() {
    _dir="$1"
    _root="${2:-$(dojo_find_root)}"
    _file="$(dojo_progress_file "$_root")"
    mkdir -p "$(dirname "$_file")" 2>/dev/null || return 0
    if ! dojo_progress_done "$_dir" "$_root"; then
        printf '%s\n' "$_dir" >> "$_file"
    fi
}

# dojo_progress_done <exercise-dir> [root] — returns 0 when already completed.
dojo_progress_done() {
    _dir="$1"
    _root="${2:-$(dojo_find_root)}"
    _file="$(dojo_progress_file "$_root")"
    [ -f "$_file" ] || return 1
    grep -qxF "$_dir" "$_file"
}

# Marker shown in listings.
dojo_progress_mark_for() {
    if dojo_progress_done "$1" "${2:-}"; then
        printf '[x]'
    else
        printf '[ ]'
    fi
}

# Count of completed exercises among those given on stdin.
dojo_progress_count() {
    _root="${1:-$(dojo_find_root)}"
    _n=0
    while IFS= read -r _line; do
        [ -n "$_line" ] || continue
        dojo_progress_done "$_line" "$_root" && _n=$((_n + 1))
    done
    printf '%s' "$_n"
}

# First exercise not yet completed, or empty when everything is done.
dojo_progress_next() {
    _root="${1:-$(dojo_find_root)}"
    dojo_exercises "$_root" | while IFS= read -r _ex; do
        if ! dojo_progress_done "$_ex" "$_root"; then
            printf '%s' "$_ex"
            return 0
        fi
    done
}
