#!/usr/bin/env bash
#
# GDB Dojo test suite.
#
# For every exercise (any directory under levels/ containing check.sh) this
# verifies that:
#
#   1. the expected files exist and start/check.sh are executable
#   2. `make` builds cleanly with no compiler warnings
#   3. the built binary runs and exits 0
#   4. the binary is covered by .gitignore
#   5. check.sh rejects a missing answer and a wrong answer
#   6. check.sh accepts the answer produced by solving the exercise with GDB
#   7. check.sh does not contain the answer in plaintext
#
# Step 6 requires gdb. Without it those checks are skipped, not failed, so the
# suite still gives useful signal on machines without a working GDB.
#
# Usage:
#   tests/run-tests.sh            # all exercises
#   tests/run-tests.sh 03-inspect # only exercises whose path matches

set -uo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_dir" || exit 1

filter="${1:-}"

# Run against a throwaway state directory. Before this the suite deleted
# .dojo/ in the repo, which destroyed real progress; now that state lives
# under $HOME by default, clobbering it would be worse.
DOJO_STATE_DIR="$(mktemp -d)"
export DOJO_STATE_DIR
trap 'rm -rf "$DOJO_STATE_DIR"' EXIT

reset_state() { rm -rf "${DOJO_STATE_DIR:?}"; mkdir -p "$DOJO_STATE_DIR"; }

pass_count=0
fail_count=0
skip_count=0
failures=()

if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
    C_RESET=$'\033[0m'; C_GREEN=$'\033[32m'; C_RED=$'\033[31m'
    C_YELLOW=$'\033[33m'; C_BOLD=$'\033[1m'; C_DIM=$'\033[2m'
else
    C_RESET=''; C_GREEN=''; C_RED=''; C_YELLOW=''; C_BOLD=''; C_DIM=''
fi

ok()   { pass_count=$((pass_count + 1)); printf '  %sPASS%s %s\n' "$C_GREEN" "$C_RESET" "$1"; }
bad()  { fail_count=$((fail_count + 1)); failures+=("$1"); printf '  %sFAIL%s %s\n' "$C_RED" "$C_RESET" "$1"; [ $# -gt 1 ] && printf '       %s%s%s\n' "$C_DIM" "$2" "$C_RESET"; return 0; }
skip() { skip_count=$((skip_count + 1)); printf '  %sSKIP%s %s\n' "$C_YELLOW" "$C_RESET" "$1"; }

if [ -z "${BASH_VERSINFO:-}" ] || [ "${BASH_VERSINFO[0]}" -lt 4 ]; then
    echo "tests/run-tests.sh needs bash 4 or newer (found ${BASH_VERSION:-unknown})." >&2
    echo "On macOS: brew install bash, or run the suite in the Docker container." >&2
    exit 1
fi

have_gdb=0
command -v gdb >/dev/null 2>&1 && have_gdb=1

have_git=0
command -v git >/dev/null 2>&1 && have_git=1

# ---------------------------------------------------------------- discovery --

mapfile -t exercises < <(find levels -type f -name meta -print0 | xargs -0 -n1 dirname | LC_ALL=C sort)

if [ "${#exercises[@]}" -eq 0 ]; then
    echo "No exercises found under levels/." >&2
    exit 1
fi

# --------------------------------------------------------------- exercise ---

test_exercise() {
    local dir="$1"
    local slug="${dir//\//-}"
    slug="${slug#levels-}"

    printf '\n%s%s%s\n' "$C_BOLD" "$dir" "$C_RESET"

    # 1. structure
    local missing=()
    for f in README.md main.c Makefile check.sh start meta; do
        [ -f "$dir/$f" ] || missing+=("$f")
    done
    if [ "${#missing[@]}" -eq 0 ]; then
        ok "required files present"
    else
        bad "required files present" "missing: ${missing[*]}"
        return
    fi

    local meta_missing=()
    for key in TRACK TITLE SKILL GOAL ANSWER; do
        grep -qE "^${key}=." "$dir/meta" || meta_missing+=("$key")
    done
    if [ "${#meta_missing[@]}" -eq 0 ]; then
        ok "meta has required keys"
    else
        bad "meta has required keys" "missing: ${meta_missing[*]}"
    fi

    local hint_total
    hint_total="$(grep -cE '^HINT[0-9]+=.' "$dir/meta" || true)"
    if [ "${hint_total:-0}" -ge 1 ]; then
        ok "has progressive hints ($hint_total)"
    else
        bad "has progressive hints" "define HINT1..HINTn in $dir/meta"
    fi

    # HINT numbering must be contiguous from 1, or hints silently stop showing.
    local gap=0 i=1
    while [ "$i" -le "${hint_total:-0}" ]; do
        grep -qE "^HINT$i=." "$dir/meta" || gap=1
        i=$((i + 1))
    done
    if [ "$gap" -eq 0 ]; then
        ok "hint numbering is contiguous"
    else
        bad "hint numbering is contiguous" "HINT1..HINT$hint_total must all exist"
    fi

    for f in check.sh start; do
        if [ -x "$dir/$f" ]; then
            ok "$f is executable"
        else
            bad "$f is executable" "chmod +x $dir/$f"
        fi
    done

    # 2. build with no warnings
    local build_log
    build_log="$(make -C "$dir" clean >/dev/null 2>&1; make -C "$dir" 2>&1)"
    local build_rc=$?
    if [ "$build_rc" -ne 0 ]; then
        bad "builds" "$(printf '%s' "$build_log" | tail -5)"
        return
    fi
    ok "builds"

    if printf '%s' "$build_log" | grep -qiE 'warning:'; then
        bad "builds without warnings" "$(printf '%s' "$build_log" | grep -iE 'warning:' | head -3)"
    else
        ok "builds without warnings"
    fi

    # locate the produced binary via the Makefile TARGET
    local target
    target="$(grep -E '^TARGET[[:space:]]*:?=' "$dir/Makefile" | head -1 | sed -E 's/.*[:=]=?[[:space:]]*//')"
    if [ -z "$target" ] || [ ! -x "$dir/$target" ]; then
        bad "produces TARGET binary" "TARGET='$target' not found in $dir"
        return
    fi
    ok "produces TARGET binary ($target)"

    # 3. binary runs
    if (cd "$dir" && "./$target" >/dev/null 2>&1); then
        ok "binary runs and exits 0"
    else
        bad "binary runs and exits 0"
    fi

    # 4. binary is gitignored
    if [ "$have_git" -eq 0 ]; then
        skip "binary is gitignored (git not installed)"
    elif git check-ignore -q "$dir/$target" 2>/dev/null; then
        ok "binary is gitignored"
    else
        bad "binary is gitignored" "add a rule covering $dir/$target"
    fi

    # 5. checker rejects bad input
    if (cd "$dir" && ./check.sh >/dev/null 2>&1); then
        bad "check.sh rejects missing answer" "expected non-zero exit"
    else
        ok "check.sh rejects missing answer"
    fi

    if (cd "$dir" && ./check.sh __DEFINITELY_WRONG__ >/dev/null 2>&1); then
        bad "check.sh rejects wrong answer" "expected non-zero exit"
    else
        ok "check.sh rejects wrong answer"
    fi

    # 6. checker accepts the GDB-derived answer
    local solution="tests/solutions/$slug.sh"
    if [ ! -f "$solution" ]; then
        bad "has a solution script" "expected $solution"
    elif [ "$have_gdb" -eq 0 ]; then
        skip "check.sh accepts solved answer (gdb not installed)"
    else
        local answer
        answer="$(bash "$solution" "$dir" "$target" 2>/dev/null)"
        if [ -z "$answer" ]; then
            bad "solution script produces an answer" "$solution returned nothing"
        elif (cd "$dir" && ./check.sh "$answer" >/dev/null 2>&1); then
            ok "check.sh accepts solved answer"

            # 7. answer must not appear in plaintext anywhere in the exercise
            if grep -qiwF -- "$answer" "$dir/check.sh"; then
                bad "answer not leaked in check.sh" "found '$answer' in check.sh"
            else
                ok "answer not leaked in check.sh"
            fi
            if grep -qiwF -- "$answer" "$dir/README.md"; then
                bad "answer not leaked in README.md" "found '$answer' in README.md"
            else
                ok "answer not leaked in README.md"
            fi
            if grep -qiwF -- "$answer" "$dir/meta"; then
                bad "answer not leaked in meta/hints" "found '$answer' in meta"
            else
                ok "answer not leaked in meta/hints"
            fi

            # A wrong answer must reveal exactly one more hint.
            reset_state
            (cd "$dir" && ./check.sh __WRONG__ >/dev/null 2>&1) || true
            local shown
            shown="$(hint_count_for "$dir")"
            if [ "${shown:-0}" = "1" ]; then
                ok "a wrong answer reveals one hint"
            else
                bad "a wrong answer reveals one hint" "hint counter was '${shown:-unset}'"
            fi
            (cd "$dir" && ./check.sh __WRONG__ >/dev/null 2>&1) || true
            shown="$(hint_count_for "$dir")"
            if [ "${shown:-0}" = "2" ]; then
                ok "hints escalate on repeated wrong answers"
            else
                bad "hints escalate on repeated wrong answers" "hint counter was '${shown:-unset}'"
            fi
            reset_state
        else
            bad "check.sh accepts solved answer" "solution produced '$answer', rejected by check.sh"
        fi
    fi

    make -C "$dir" clean >/dev/null 2>&1 || true
}

# ------------------------------------------------------------------ repo -----

dojo_first_exercise() { printf '%s' "${exercises[0]}"; }

# Revealed-hint counter for an exercise, or 0 when nothing is recorded.
hint_count_for() {
    [ -f "$DOJO_STATE_DIR/hints" ] || { printf '0'; return; }
    awk -F'\t' -v d="$1" '$1 == d { n = $2 } END { print (n == "" ? 0 : n) }' "$DOJO_STATE_DIR/hints"
}

test_repo() {
    printf '\n%srepository%s\n' "$C_BOLD" "$C_RESET"

    # every discovered exercise must be reachable from `dojo paths`
    local paths_out
    paths_out="$(NO_COLOR=1 ./dojo paths 2>/dev/null)"
    local unlisted=()
    for dir in "${exercises[@]}"; do
        printf '%s' "$paths_out" | grep -qF "$dir" || unlisted+=("$dir")
    done
    if [ "${#unlisted[@]}" -eq 0 ]; then
        ok "all exercises listed by 'dojo paths'"
    else
        bad "all exercises listed by 'dojo paths'" "unlisted: ${unlisted[*]}"
    fi

    # dojo subcommands must not error
    for sub in help next list tracks paths doctor cheatsheet; do
        if NO_COLOR=1 ./dojo "$sub" >/dev/null 2>&1; then
            ok "dojo $sub exits 0"
        else
            bad "dojo $sub exits 0"
        fi
    done

    if NO_COLOR=1 ./dojo definitely-not-a-command >/dev/null 2>&1; then
        bad "dojo rejects unknown command" "expected non-zero exit"
    else
        ok "dojo rejects unknown command"
    fi

    # progress tracking round-trip
    local first
    first="$(dojo_first_exercise)"
    if [ -n "$first" ]; then
        # Output is captured before matching: piping straight into `grep -q`
        # makes grep exit on first match, and the resulting SIGPIPE would be
        # reported as a pipeline failure under `set -o pipefail`.
        local out
        reset_state
        out="$(NO_COLOR=1 ./dojo next 2>/dev/null)"
        if printf '%s' "$out" | grep -qF "$first"; then
            ok "dojo next points at the first unfinished exercise"
        else
            bad "dojo next points at the first unfinished exercise"
        fi

        reset_state && printf '%s\n' "$first" > "$DOJO_STATE_DIR/progress"
        out="$(NO_COLOR=1 ./dojo next 2>/dev/null)"
        if printf '%s' "$out" | grep -qF "$first"; then
            bad "dojo next skips a completed exercise" "still points at $first"
        else
            ok "dojo next skips a completed exercise"
        fi

        out="$(NO_COLOR=1 ./dojo list 2>/dev/null)"
        if printf '%s' "$out" | grep -F "$first" | grep -q '\[x\]'; then
            ok "dojo list marks completed exercises"
        else
            bad "dojo list marks completed exercises"
        fi

        out="$(NO_COLOR=1 ./dojo show 00-build 2>/dev/null || true)"
        if printf '%s' "$out" | grep -q 'Skill'; then
            ok "dojo show renders an exercise"
        else
            bad "dojo show renders an exercise"
        fi
        if NO_COLOR=1 ./dojo show definitely-no-such-exercise >/dev/null 2>&1; then
            bad "dojo show rejects an unknown exercise" "expected non-zero exit"
        else
            ok "dojo show rejects an unknown exercise"
        fi
        # cheatsheet only lists commands from completed exercises
        reset_state
        out="$(NO_COLOR=1 ./dojo cheatsheet 2>/dev/null)"
        if printf '%s' "$out" | grep -q 'Nothing unlocked yet'; then
            ok "cheatsheet is empty before any exercise is done"
        else
            bad "cheatsheet is empty before any exercise is done"
        fi
        reset_state && printf '%s\n' "$first" > "$DOJO_STATE_DIR/progress"
        out="$(NO_COLOR=1 ./dojo cheatsheet 2>/dev/null)"
        if printf '%s' "$out" | grep -q 'Nothing unlocked yet'; then
            bad "cheatsheet lists commands after completion"
        else
            ok "cheatsheet lists commands after completion"
        fi

        out="$(NO_COLOR=1 ./dojo hint "$(basename "$first")" 2>/dev/null || true)"
        if printf '%s' "$out" | grep -q 'Hint 1 of'; then
            ok "dojo hint reveals the first hint"
        else
            bad "dojo hint reveals the first hint"
        fi

        # Regression: the CLI cd's to the repo root, so it must remember where
        # it was invoked from or `dojo hint` inside an exercise finds nothing.
        reset_state
        out="$(cd "$first" && NO_COLOR=1 "$repo_dir/dojo" hint 2>/dev/null || true)"
        if printf '%s' "$out" | grep -q 'Hint 1 of'; then
            ok "dojo hint works from inside an exercise directory"
        else
            bad "dojo hint works from inside an exercise directory" "needs no argument when cwd is an exercise"
        fi
        reset_state
    fi

    # state must stay out of the checkout
    reset_state
    (cd "${exercises[0]}" && ./check.sh __WRONG__ >/dev/null 2>&1) || true
    if [ -e .dojo ]; then
        bad "learner state stays out of the repo" ".dojo/ was created in the checkout"
    else
        ok "learner state stays out of the repo"
    fi
    if [ -s "$DOJO_STATE_DIR/hints" ]; then
        ok "state is written to DOJO_STATE_DIR"
    else
        bad "state is written to DOJO_STATE_DIR" "nothing landed in $DOJO_STATE_DIR"
    fi
    reset_state

    # shell scripts must pass shellcheck when it is available
    if command -v shellcheck >/dev/null 2>&1; then
        local sc_targets
        mapfile -t sc_targets < <(
            { find . -path ./.git -prune -o -name '*.sh' -print
              find levels -type f -name start -print
              echo ./dojo; } | sort -u
        )
        local sc_out
        if sc_out="$(shellcheck -S warning -e SC1090,SC1091 "${sc_targets[@]}" 2>&1)"; then
            ok "shellcheck clean (${#sc_targets[@]} scripts)"
        else
            bad "shellcheck clean" "$(printf '%s' "$sc_out" | head -12)"
        fi
    else
        skip "shellcheck (not installed)"
    fi
}

# ------------------------------------------------------------------ run ------

printf '%sGDB Dojo test suite%s\n' "$C_BOLD" "$C_RESET"
printf '%s%d exercises discovered · gdb %s%s\n' "$C_DIM" "${#exercises[@]}" \
    "$([ "$have_gdb" -eq 1 ] && echo present || echo missing)" "$C_RESET"

test_repo

for dir in "${exercises[@]}"; do
    if [ -n "$filter" ] && [[ "$dir" != *"$filter"* ]]; then
        continue
    fi
    test_exercise "$dir"
done

printf '\n%s------------------------------------------------------------%s\n' "$C_DIM" "$C_RESET"
printf '%spassed %d%s' "$C_GREEN" "$pass_count" "$C_RESET"
[ "$skip_count" -gt 0 ] && printf ' · %sskipped %d%s' "$C_YELLOW" "$skip_count" "$C_RESET"
[ "$fail_count" -gt 0 ] && printf ' · %sfailed %d%s' "$C_RED" "$fail_count" "$C_RESET"
printf '\n'

if [ "$fail_count" -gt 0 ]; then
    printf '\n%sFailures:%s\n' "$C_RED" "$C_RESET"
    for f in "${failures[@]}"; do printf '  - %s\n' "$f"; done
    exit 1
fi

exit 0
