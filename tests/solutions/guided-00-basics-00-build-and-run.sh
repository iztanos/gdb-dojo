#!/usr/bin/env bash
# Skill: build and run. The program prints its own status.
. "$(dirname "${BASH_SOURCE[0]}")/_lib.sh"
sol_run_plain "$1" "$2" | grep -A1 'Program status:' | tail -1 | tr -d '[:space:]'
