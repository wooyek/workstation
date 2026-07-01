#!/usr/bin/env bash

# OS detection shared across bootstrap steps.
# Sets WORKSTATION_OS to one of: debian | arch | unknown
# Usage: source lib/os.sh   (then read $WORKSTATION_OS)

detect_os() {
    if [ -r /etc/os-release ]; then
        # shellcheck disable=SC1091
        . /etc/os-release
        case " ${ID:-} ${ID_LIKE:-} " in
            *" arch "*) echo arch; return ;;
            *" debian "*|*" ubuntu "*) echo debian; return ;;
        esac
    fi

    # Fall back to whichever package manager is present.
    if command -v pacman >/dev/null 2>&1; then
        echo arch
    elif command -v apt-get >/dev/null 2>&1; then
        echo debian
    else
        echo unknown
    fi
}

# Respect a caller-provided override (e.g. WORKSTATION_OS=arch bash bootstrap.sh).
WORKSTATION_OS="${WORKSTATION_OS:-$(detect_os)}"
export WORKSTATION_OS
