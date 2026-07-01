#!/usr/bin/env bash

# Workstation bootstrap — detects the OS and runs the matching step tree.
# Each step is idempotent and safe to re-run.
#   - Debian / Kubuntu  -> steps/*.sh         (apt)
#   - Arch / Omarchy    -> steps/arch/*.sh     (pacman + yay)
# Cross-platform installers (brew, self-managing vendors, cargo) are
# shared between both trees.

cd "$(dirname "$0")" || exit 1

# shellcheck source=lib/os.sh
. lib/os.sh

run() {
    echo "»»»» $1"
    bash "$1"
}

echo "==== Detected OS: $WORKSTATION_OS ===="

case "$WORKSTATION_OS" in
    debian)
        run steps/00-base.sh
        run steps/10-apt.sh
        run steps/15-debs.sh

        for repo in steps/20-repos/*.sh; do
            run "$repo"
        done

        run steps/30-snap.sh
        run steps/40-brew.sh
        run steps/50-python.sh
        run steps/55-vendor.sh
        run steps/57-cargo.sh
        run steps/60-shell.sh
        run steps/70-desktop.sh
        ;;
    arch)
        run steps/arch/00-base.sh
        run steps/arch/10-pkg.sh
        run steps/arch/20-aur.sh
        run steps/40-brew.sh      # cross-platform (Linuxbrew)
        run steps/arch/50-python.sh
        run steps/55-vendor.sh    # cross-platform (self-managing installers)
        run steps/57-cargo.sh     # cross-platform (cargo crates)
        run steps/arch/60-shell.sh
        ;;
    *)
        echo "Unsupported OS '$WORKSTATION_OS'." >&2
        echo "Supported: Debian/Kubuntu (apt), Arch/Omarchy (pacman)." >&2
        exit 1
        ;;
esac
