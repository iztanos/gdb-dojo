#!/usr/bin/env bash
set -e

echo "GDB Dojo local browser terminal"
echo "Open http://localhost:7681"
echo "Repo mounted at /dojo"

cd /dojo
exec ttyd -W -d 1 -t titleFixed="GDB Dojo" -i 0.0.0.0 -p 7681 bash --rcfile /dojo/.bashrc.dojo
