#!/usr/bin/env bash
#
# Repository layout helpers: locating the repo root, discovering exercises, and
# reading exercise metadata.
#
# Exercises are discovered from the filesystem rather than from hardcoded
# lists, so adding an exercise directory is all that is required for it to
# appear in the CLI, the Makefile, and the test suite.

# Callers may omit the starting directory and fall back to $PWD.
# shellcheck disable=SC2120
# Walk upward from a directory until the repo root (the directory holding the
# `dojo` script) is found. Depth-independent, so exercises can live at any
# nesting level under levels/.
dojo_find_root() {
    _dir="${1:-$PWD}"
    _dir="$(cd "$_dir" && pwd)"
    while [ "$_dir" != "/" ]; do
        if [ -f "$_dir/dojo" ] && [ -d "$_dir/levels" ]; then
            printf '%s' "$_dir"
            return 0
        fi
        _dir="$(dirname "$_dir")"
    done
    echo "dojo: could not locate the repository root" >&2
    return 1
}

# All exercise directories, repo-relative, in curriculum order.
# An exercise is any directory under levels/ containing a `meta` file.
dojo_exercises() {
    _root="${1:-$(dojo_find_root)}"
    (cd "$_root" && find levels -type f -name meta -print | sed 's|/meta$||' | LC_ALL=C sort)
}

# Exercises limited to one track, e.g. dojo_exercises_in guided
dojo_exercises_in() {
    _track="$1"
    _root="${2:-$(dojo_find_root)}"
    dojo_exercises "$_root" | grep "^levels/$_track/" || true
}

# Read one KEY from an exercise `meta` file.
#   dojo_meta levels/guided/00-basics/03-inspect-locals TITLE
dojo_meta() {
    _dir="$1"
    _key="$2"
    _root="${3:-$(dojo_find_root)}"
    _file="$_root/$_dir/meta"
    [ -f "$_file" ] || return 1
    sed -nE "s/^${_key}=(.*)$/\1/p" "$_file" | head -1
}

# Build target name for an exercise, read from its Makefile so the name is
# never duplicated in metadata.
dojo_target() {
    _dir="$1"
    _root="${2:-$(dojo_find_root)}"
    grep -E '^TARGET[[:space:]]*:?=' "$_root/$_dir/Makefile" 2>/dev/null \
        | head -1 | sed -E 's/.*[:=]=?[[:space:]]*//'
}

# Human-readable label, e.g. "03  Inspect Local Variables"
dojo_label() {
    _dir="$1"
    _root="${2:-$(dojo_find_root)}"
    _num="$(dojo_meta "$_dir" NUMBER "$_root")"
    _title="$(dojo_meta "$_dir" TITLE "$_root")"
    if [ -n "$_num" ]; then
        printf '%s  %s' "$_num" "$_title"
    else
        printf '%s' "$_title"
    fi
}

# Track name from an exercise path: levels/guided/00-basics/03-x -> guided
dojo_track_of() {
    printf '%s' "$1" | cut -d/ -f2
}
