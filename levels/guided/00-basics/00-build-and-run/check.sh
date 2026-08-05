#!/usr/bin/env bash
# Thin stub: the expected answer lives as a SHA-256 hash in `meta`.
set -e
d="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
r="$d"; while [ ! -f "$r/dojo" ] && [ "$r" != "/" ]; do r="$(dirname "$r")"; done
# shellcheck source=/dev/null
. "$r/lib/dojo-ui.sh"; . "$r/lib/dojo-paths.sh"
# shellcheck source=/dev/null
. "$r/lib/dojo-progress.sh"; . "$r/lib/dojo-check.sh"
dojo_check_exercise "$d" "$@"
