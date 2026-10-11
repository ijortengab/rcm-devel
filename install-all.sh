#!/bin/bash

PACKAGE=ijortengab/rcm-devel

if [[ "$EUID" -ne 0 ]]; then
    echo This script needs to be run with superuser privileges
    exit 1
fi

if ! command -v rcm > /dev/null;then
    printf '%b' "\033[95;1m"rcm"\033[0m"' command is '"\033[91;1m"'not found'"\033[0m"."\n" >&2
    exit 1
fi

# Functions.
resolve_relative_path() {
    if [ -d "$1" ];then
        cd "$1" || return 1
        pwd
    elif [ -e "$1" ];then
        if [ ! "${1%/*}" = "$1" ]; then
            cd "${1%/*}" || return 1
        fi
        echo "$(pwd)/${1##*/}"
    else
        return 1
    fi
}

__FILE__=$(resolve_relative_path "$0")
__DIR__=$(dirname "$__FILE__")

cd "$__DIR__"
rcm require --package="$PACKAGE" --here
