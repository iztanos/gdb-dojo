#!/usr/bin/env bash
set -e

cd /dojo
exec ttyd -W -d 1 -t titleFixed="GDB Dojo" -i 0.0.0.0 -p 7681 bash --rcfile /dojo/.bashrc.dojo
