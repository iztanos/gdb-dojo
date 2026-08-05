#!/usr/bin/env bash
#
# Generic exercise briefing renderer.
#
# Every exercise `start` file is a small stub that hands its own directory to
# this script. The briefing content comes from the exercise `meta` file, so the
# six near-identical 40-line start scripts that used to exist are now data.
#
# Usage: dojo-start.sh <exercise-dir>

set -euo pipefail

exercise_dir="$(cd "$1" && pwd)"

repo_dir="$exercise_dir"
while [ ! -f "$repo_dir/dojo" ] && [ "$repo_dir" != "/" ]; do
    repo_dir="$(dirname "$repo_dir")"
done
if [ ! -f "$repo_dir/dojo" ]; then
    echo "dojo: could not locate the repository root from $exercise_dir" >&2
    exit 1
fi

# shellcheck source=lib/dojo-ui.sh
. "$repo_dir/lib/dojo-ui.sh"
# shellcheck source=lib/dojo-paths.sh
. "$repo_dir/lib/dojo-paths.sh"
# shellcheck source=lib/dojo-state.sh
. "$repo_dir/lib/dojo-state.sh"
# shellcheck source=lib/dojo-progress.sh
. "$repo_dir/lib/dojo-progress.sh"
# shellcheck source=lib/dojo-hints.sh
. "$repo_dir/lib/dojo-hints.sh"

rel="${exercise_dir#"$repo_dir"/}"

title="$(dojo_meta "$rel" TITLE "$repo_dir")"
number="$(dojo_meta "$rel" NUMBER "$repo_dir")"
track="$(dojo_meta "$rel" TRACK "$repo_dir")"
level="$(dojo_meta "$rel" LEVEL "$repo_dir")"
skill="$(dojo_meta "$rel" SKILL "$repo_dir")"
goal="$(dojo_meta "$rel" GOAL "$repo_dir")"
submit="$(dojo_meta "$rel" SUBMIT "$repo_dir")"
commands="$(dojo_meta "$rel" GDB "$repo_dir")"
briefing="$(dojo_meta "$rel" BRIEFING "$repo_dir")"
target="$(dojo_target "$rel" "$repo_dir")"

banner="$track"
[ -n "$level" ] && banner="$track / $level"
subtitle="$title"
[ -n "$number" ] && subtitle="Exercise $number: $title"

dojo_clear
dojo_header "$(printf '%s' "$banner" | tr '[:lower:]' '[:upper:]')" "$subtitle"

if dojo_progress_done "$rel" "$repo_dir"; then
    echo
    dojo_success "Already completed. Re-run it any time."
fi

echo
printf 'Skill\n  %s\n\n' "$skill"
printf 'Goal\n  %s\n\n' "$goal"

echo "Build"
dojo_cmd "make"
echo

echo "Debug"
dojo_cmd "gdb -q ./$target"
echo

# A "full" briefing walks through the GDB commands, which is what a first-time
# user needs. From the point the curriculum expects independence, the briefing
# states the goal only and the commands come from `dojo hint` on request, so the
# exercise is solved rather than transcribed.
if [ "${briefing:-full}" = "full" ] && [ -n "$commands" ]; then
    echo "Inside GDB"
    printf '%s\n' "$commands" | tr '|' '\n' | while IFS= read -r c; do
        [ -n "$c" ] && dojo_cmd "$c"
    done
    echo
fi

echo "Submit"
dojo_cmd "./check.sh ${submit:-ANSWER}"
echo

dojo_hints_print "$rel" "$repo_dir"
dojo_hints_footer "$rel" "$repo_dir"
echo

printf '%bFiles%b\n' "$DIM" "$RESET"
printf '%b  README.md  full walkthrough, including the commands\n' "$DIM"
printf '  main.c     source\n'
printf '  Makefile   build rules\n'
printf '  check.sh   answer checker%b\n' "$RESET"
