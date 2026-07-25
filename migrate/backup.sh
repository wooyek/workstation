#!/usr/bin/env bash

# Migration backup — stage everything valuable from this OS onto a
# surviving disk before a fresh install wipes / and /home.
#
# Usage:   migrate/backup.sh [TARGET_DIR]
# Default: /work/migration/<hostname>-<date>
#
# Safe to re-run: rsync is incremental, manifests are regenerated.
# Nothing here is machine-specific — device UUIDs, serials and secrets
# are captured into the TARGET at run time, never into this repo.

set -euo pipefail

TARGET="${1:-/work/migration/$(hostname)-$(date +%F)}"
HOME_SRC="${HOME}"

mkdir -p "$TARGET"/{home,etc,manifests}

say() { printf '\n»»»» %s\n' "$*"; }

# ---------------------------------------------------------------------------
# 1. Home: configs, credentials, histories — the curated allowlist.
#    Caches, venvs and build artifacts are deliberately absent.
# ---------------------------------------------------------------------------
say "Home configs, credentials and histories -> $TARGET/home"

HOME_PATHS=(
    # Shell & tribal knowledge
    .bashrc .profile .zshrc .bash_history
    .config/fish .local/share/fish
    .config/starship.toml .local/share/zoxide
    .psql_history .python_history .rediscli_history .pdbhistory
    .lesshst .viminfo .ipython

    # Git identity & workflow
    .gitconfig .gitconfig-venvs .git-hooks .gitignore .huskyrc

    # Credentials & access (historical access is the point — keep old ones)
    .ssh .aws .kube .krew .gnupg .cert .pki .netrc .boto
    .docker/config.json
    .railway .sentry .frisco-cli .copilot .gemini .codex
    .claude.json signal-desktop-keyring.gpg supabase

    # Claude Code state (projects/ excluded below — opt in via FULL_CLAUDE=1)
    .claude

    # App config trees — whole dirs, caches stripped by EXCLUDES.
    # (.config carries KDE rc files, JetBrains, browsers, gh, gcloud;
    #  .local/share carries kwallet, keyrings, konsole profiles, fonts.)
    .config .local/share .local/bin

    # Browsers outside .config
    .mozilla

    # Editors, agents & misc tool state
    .vscode .idea .agents .ai .antigravity .junie .shotgun-sh .resto
    .fonts.conf .icons .face .face.icon

    # Out-of-tree NIC driver source — 2.5GbE port needs it (DKMS r8125)
    realtek-r8125-dkms
)

EXCLUDES=(
    --exclude '.claude/projects'
    --exclude '**/Cache*' --exclude '**/cache*'
    --exclude '**/GPUCache' --exclude '**/Code Cache'
    --exclude '**/CachedData' --exclude '**/ShaderCache'
    --exclude '**/node_modules' --exclude '**/.venv'
    --exclude '**/__pycache__'
    --exclude '.local/share/Trash'
    --exclude '.local/share/baloo'
    --exclude '.local/share/pipx'
    --exclude '.local/share/uv'
    --exclude '.local/share/virtualenv'
    # Marketplace plugins, ~9 GB across stale per-version dirs — they
    # re-download. Settings live in .config/JetBrains; the caches and
    # indexes are in .cache/, which this allowlist never touches.
    # manifests/jetbrains-plugins.txt records which plugins to re-add.
    --exclude '.local/share/JetBrains'
    --exclude '.config/**/Service Worker'
    --exclude '.config/**/IndexedDB'
)
if [[ "${FULL_CLAUDE:-0}" == "1" ]]; then
    EXCLUDES=("${EXCLUDES[@]:1}")   # drop the .claude/projects exclude
fi

for p in "${HOME_PATHS[@]}"; do
    if [[ -e "$HOME_SRC/$p" ]]; then
        rsync -aR "${EXCLUDES[@]}" "$HOME_SRC/./$p" "$TARGET/home/"
    fi
done

# User data directories are intentionally NOT copied by default: review
# them manually (Documents, Pictures, Desktop, KB, work-summary-*) —
# run with USER_DATA=1 to include them.
if [[ "${USER_DATA:-0}" == "1" ]]; then
    say "User data directories -> $TARGET/home"
    for p in Documents Pictures Desktop Templates Public KB; do
        [[ -d "$HOME_SRC/$p" ]] && rsync -aR "$HOME_SRC/./$p" "$TARGET/home/"
    done
    rsync -aR "$HOME_SRC"/./work-summary-*.md "$TARGET/home/" 2>/dev/null || true
fi

# ---------------------------------------------------------------------------
# 2. /etc: user-readable custom config + machine identity for reference.
# ---------------------------------------------------------------------------
say "/etc snapshot (readable parts) -> $TARGET/etc"

ETC_PATHS=(
    fstab hosts hostname environment
    apt/sources.list apt/sources.list.d apt/keyrings apt/trusted.gpg.d
    apt/preferences.d
    default/grub
    sysctl.d security/limits.d udev/rules.d modprobe.d modules-load.d
    systemd/system docker/daemon.json
    sddm.conf.d X11/xorg.conf.d profile.d cron.d
)
for p in "${ETC_PATHS[@]}"; do
    [[ -e "/etc/$p" ]] && rsync -aR "/etc/./$p" "$TARGET/etc/" 2>/dev/null || true
done

# Vendor apt signing keys living outside /etc (world-readable)
rsync -a /usr/share/keyrings/ "$TARGET/etc/usr-share-keyrings/"

# ---------------------------------------------------------------------------
# 3. Root-only files — the single sudo step, optional.
#
#    Deliberately absent: Docker volumes (containers are disposable and
#    every service that matters is remote — recreate from compose files,
#    see manifests/docker-volumes.txt), /etc/postgresql (bootstrap
#    reinstalls the server from lists/apt.txt; no local database here
#    holds anything worth carrying over), /etc/nordlayer and
#    /etc/sudoers.d (re-provisioned by the installer and by hand
#    respectively), /etc/netplan (a NetworkManager stub on this
#    desktop — the real profiles are in NetworkManager/).
# ---------------------------------------------------------------------------
if [[ "${WITH_SUDO:-0}" == "1" ]]; then
    say "Root-only configs -> $TARGET/etc (sudo)"
    sudo rsync -aR \
        /etc/./NetworkManager/system-connections \
        /etc/./ssh \
        /etc/./docker \
        "$TARGET/etc/" || true
    sudo chown -R "$(id -u):$(id -g)" "$TARGET/etc"
else
    say "Skipping root-only files (re-run with WITH_SUDO=1)"
fi

# ---------------------------------------------------------------------------
# 4. Manifests: package lists + hardware identity for the restore side.
# ---------------------------------------------------------------------------
say "Package + hardware manifests -> $TARGET/manifests"

apt-mark showmanual | sort            > "$TARGET/manifests/apt-manual.txt"
dpkg -l                               > "$TARGET/manifests/dpkg-full.txt"
snap list                             > "$TARGET/manifests/snap.txt"        2>/dev/null || true
brew list --formula                   > "$TARGET/manifests/brew.txt"        2>/dev/null || true
brew list --cask                      > "$TARGET/manifests/brew-cask.txt"   2>/dev/null || true
pipx list --short                     > "$TARGET/manifests/pipx.txt"        2>/dev/null || true
uv tool list                          > "$TARGET/manifests/uv-tools.txt"    2>/dev/null || true
ls -1 "$HOME_SRC/go/bin"              > "$TARGET/manifests/go-bin.txt"      2>/dev/null || true
docker volume ls --format '{{.Name}}' > "$TARGET/manifests/docker-volumes.txt" 2>/dev/null || true
code --list-extensions                > "$TARGET/manifests/vscode-ext.txt"  2>/dev/null || true

# JetBrains plugins are excluded from the file copy (9 GB of re-downloadable
# marketplace payload) — the irreplaceable part is knowing WHICH ones were
# installed, per IDE version. Most lines read "<Product><Version>/<plugin>";
# a few housekeeping dirs (Daemon/, consentOptions/) ride along harmlessly.
find "$HOME_SRC/.local/share/JetBrains" -mindepth 2 -maxdepth 2 -type d -printf '%P\n' |
    sort > "$TARGET/manifests/jetbrains-plugins.txt" 2>/dev/null || true

lsblk -o NAME,MODEL,SERIAL,SIZE,FSTYPE,MOUNTPOINT,UUID > "$TARGET/manifests/disks.txt"
cat /etc/fstab                        > "$TARGET/manifests/fstab.txt"
cat /sys/devices/virtual/dmi/id/board_name > "$TARGET/manifests/board.txt" 2>/dev/null || true

say "Backup staged in: $TARGET"
say "Verify size and spot-check before wiping anything:"
du -sh "$TARGET"/* 2>/dev/null || true
