#!/bin/bash
CWD="`dirname \"$0\"`"
command -v love >/dev/null 2>&1 || { echo >&2 "install love (0.10): sudo apt-get install love"; exit 1; }
love ${CWD}/Game
