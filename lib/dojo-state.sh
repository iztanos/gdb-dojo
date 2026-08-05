#!/usr/bin/env bash
#
# Learner state location.
#
# Progress and revealed hints used to live in .dojo/ inside the repository,
# which meant deleting the clone lost your progress and `git pull` for new
# content ran into local state. State now lives outside the checkout.
#
# Resolution order:
#   1. $DOJO_STATE_DIR          explicit override
#   2. $XDG_DATA_HOME/gdb-dojo  when XDG_DATA_HOME is set
#   3. ~/.local/share/gdb-dojo  the default
#   4. <repo>/.dojo             last resort when there is no writable HOME
#
# A pre-existing <repo>/.dojo is migrated on first use so nobody loses
# progress on upgrade.

dojo_state_dir() {
    _root="${1:-$(dojo_find_root)}"

    if [ -n "${DOJO_STATE_DIR:-}" ]; then
        printf '%s' "$DOJO_STATE_DIR"
        return 0
    fi
    if [ -n "${XDG_DATA_HOME:-}" ]; then
        printf '%s/gdb-dojo' "$XDG_DATA_HOME"
        return 0
    fi
    if [ -n "${HOME:-}" ]; then
        printf '%s/.local/share/gdb-dojo' "$HOME"
        return 0
    fi
    printf '%s/.dojo' "$_root"
}

# Move a legacy in-repo .dojo directory to the resolved state directory once.
dojo_state_migrate() {
    _root="${1:-$(dojo_find_root)}"
    _legacy="$_root/.dojo"
    _target="$(dojo_state_dir "$_root")"

    [ -d "$_legacy" ] || return 0
    [ "$_legacy" != "$_target" ] || return 0

    mkdir -p "$_target" 2>/dev/null || return 0
    for _f in progress hints; do
        if [ -f "$_legacy/$_f" ] && [ ! -f "$_target/$_f" ]; then
            cp "$_legacy/$_f" "$_target/$_f" 2>/dev/null || true
        fi
    done
    rm -rf "$_legacy" 2>/dev/null || true
}

# Absolute path to a state file, with the directory created and any legacy
# state migrated first.
dojo_state_file() {
    _name="$1"
    _root="${2:-$(dojo_find_root)}"
    dojo_state_migrate "$_root"
    _dir="$(dojo_state_dir "$_root")"
    mkdir -p "$_dir" 2>/dev/null || true
    printf '%s/%s' "$_dir" "$_name"
}
