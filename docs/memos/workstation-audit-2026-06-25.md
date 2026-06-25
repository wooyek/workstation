# Workstation Bootstrap Audit — 2026-06-25

Audit of the `wooyek/workstation` bootstrap repo for obsolescence and
reorganization, reconciled against the live Kubuntu machine so a fresh
install can be bootstrapped with the tools actually in use.

> **AI-generated audit — read critically.** Findings below are derived
> from the repo contents and a snapshot of this machine's package state
> (`apt-mark showmanual`, `snap list`, `brew leaves`, `pipx list`,
> `flatpak list`). They reflect *what was installed at audit time*, are
> limited by that data, and may be biased toward what those commands
> surface. Lines marked **[Verify]** are uncertain and need a human check
> before action. I do not have ground-truth facts beyond this snapshot.

## Decisions (locked with user)

1. **Target structure:** layered, numbered, idempotent steps.
2. **Drift handling:** curated capture — add intentional tools, exclude
   system/desktop/hardware noise.
3. **Output:** commit this memo, create GitHub issues, then branch and
   begin implementation.

A backup branch `backup/wip-2026-06-25` snapshots the pre-audit working
copy (local only; preserve-on-origin decision deferred).

---

## Part A — Obsolescence & repo bugs

| # | Severity | Finding | Evidence |
|---|----------|---------|----------|
| A1 | **HIGH** | `setup.sh` calls `bash folders.sh` but that file does not exist — bootstrap aborts mid-run | `setup.sh:5` |
| A2 | **HIGH** | `setup.sh` never invokes `snap.sh` or `brew.sh`; snap + brew installs are orphaned and never run | `setup.sh` |
| A3 | **HIGH** | `packages.txt` lists `brew` as an apt package — invalid, `apt install brew` fails | `packages.txt:13` |
| A4 | **HIGH** | `packages.txt` lists repo-gated tools (`sublime-text`, `gh`, `openvpn3`) that fail under plain `apt` with no prior repo/key setup | `packages.txt:33,107,132` |
| A5 | MED | Duplicate entries in `packages.txt`: `gdal-bin`, `libgdal-dev`, `libpq-dev`, `libfreexl-dev`, `krita`, `ksnip`, `redis-tools`, `speedtest-cli` | `packages.txt` |
| A6 | MED | Trailing-whitespace lines (`libfreexl-dev `, `libgdal-dev  `, `libpq-dev `, `postgresql-client-common `, `libksysguard*`) — `apt install "$package"` receives a malformed arg | `packages.txt` |
| A7 | MED | `watchman-v2022.01.24.00-linux/` + `.zip` — a 4 MB binary tree from 2022 committed to git; watchman is also in `brew.txt` and `components/optional/watchman.sh` | repo root |
| A8 | MED | No `.gitignore`; `.idea/` (IDE config, sonarlint stores) is untracked and at risk of accidental commit | repo root |
| A9 | MED | `openvpn-repo-pkg-key.pub.1` — root-owned re-download artifact (`curl` clobber dup) | repo root |
| A10 | MED | `components.sh` globs only `components/*.sh`; `archive/`, `experimental/`, `optional/` subdirs never run — their state (enabled/disabled) is implicit, not declared | `components.sh:4` |
| A11 | LOW | Three copies of the brew installer: `brew.sh`, `components/brew.sh`, `components/optional/brew.sh` — identical one-liner | repo |
| A12 | LOW | `fish_setup.fish` carries dead config: pyenv/pipenv/nvm completions, commented blocks, a stray bare path line `/home/janusz/.local/bin` (line 46, no-op) | `fish_setup.fish` |
| A13 | LOW | `awscli` (apt) coexists with `components/optional/awscliv2.sh` — v1 apt package is superseded by v2 | `packages.txt:8` |
| A14 | LOW | `nvidia-driver` (unversioned) in `packages.txt` vs `nvidia-driver-580` actually installed — version drift, hardware-specific | `packages.txt:103` |

## Part B — pipx tooling obsolescence

`components/pipx.txt` is dominated by tooling superseded by `uv` + `ruff`
(per your global workflow). Reconciled against `pipx list`:

**Prune (superseded / abandoned):**
`black`, `isort`, `flake8`, `autoflake` → **ruff**; `poetry`, `pipenv`,
`pew`, `vex`, `pip-tools` → **uv**; `legit` (abandoned),
`transifex-client` (deprecated, replaced by `tx`), `bump2version`
(→ `bump-my-version`), `check-manifest` (rarely needed).

**Keep:** `asciinema`, `cookiecutter`, `invoke`, `mypy`, `pre-commit`,
`tabulate`, `terminaltexteffects`, `twine`, `watchdog`, `tox` **[Verify
still used]**.

**Add (installed, not listed):** `pyupgrade`.

---

## Part C — Drift: installed but missing from repo (curated)

Reconciled `apt-mark showmanual` / `brew leaves` / `snap list` against the
repo lists. **Excluded as noise:** kubuntu-desktop deps, `lib*`, `fonts-*`,
`linux-*`, `grub*`, `gstreamer*`, `language-pack-*`, hardware drivers
(`nvidia-*`, `r8125-dkms`), base system packages.

### apt — add (repo-gated → `steps/20-repos/`)
`docker-ce` + `docker-ce-cli` + `containerd.io` + `docker-buildx-plugin`
+ `docker-compose-plugin`, `kubectl`, `signal-desktop`, `spotify-client`,
`warp-terminal`, `1password`, `nordlayer` + `nordlayer-tray`, `insync`.

### apt — add (plain apt or .deb)
`golang-go`, `kitty`, `shellcheck`, `zoom`, `bcompare`, `audacity`, `mpv`,
`screenkey`, `slop`, `xdotool`, `lm-sensors`, `pavucontrol`, `filelight`.

### apt — add (optional / input method) **[Verify intentional]**
`fcitx5-chinese-addons`, `fcitx5-frontend-all`, `fcitx5-material-color`,
`kde-config-fcitx5`, `ibus`, `huiontablet` (drawing tablet driver).

### brew — add
`gemini-cli`, `glow`, `jiratui`, `kind`, `kubernetes-cli`, `lazysql`,
`ruff`, `rtk`, `vercel-cli`, `worktrunk`, `zellij`,
`philocalyst/tap/caligula`, `supabase/tap/supabase`.

### brew — remove from `brew.txt` (listed, not installed)
`helm`, `pyenv`, `structurizr-cli`, `--cask lm-studio`,
`--cask beyond-compare` (installed via apt `bcompare` instead),
`--cask obsidian` (installed via snap instead). **[Verify]** `uv`/`starship`
are installed via vendor scripts (`components/uv.sh`, `starship.sh`), not
brew — decide one channel.

### snap — add
`rambox`, `youtube-music-desktop-app`, `chromium` **[Verify intentional
vs default]**.

### snap — fix `snap.txt`
Remove `helm` (not a snap, not installed), `sublime-text` (installed via
apt, not snap), `redis-insight` (wrong name — duplicate of `redisinsight`).

---

## Part D — Target structure (layered, idempotent)

```
workstation/
  bootstrap.sh              # orchestrator: runs steps/ in numeric order
  steps/
    00-base.sh              # apt update/upgrade, base-build deps
    10-apt.sh               # <- lists/apt.txt
    20-repos/               # one script per repo-gated source:
      docker.sh  gh.sh  vscode.sh  sublime.sh  kubectl.sh
      signal.sh  spotify.sh  warp.sh  1password.sh  nordlayer.sh
    30-snap.sh              # <- lists/snap.txt
    40-brew.sh              # brew install + <- lists/brew.txt
    50-python.sh            # uv install + pipx <- lists/pipx.txt
    60-shell.sh             # fish + oh-my-fish + theme
    70-desktop.sh           # nerd fonts, dracula/papirus, grub splash
  lists/
    apt.txt  snap.txt  brew.txt  pipx.txt
  components/archive/       # retained for reference, never auto-run
  docs/memos/
  .gitignore                # .idea/, *.zip, watchman-*/
  README.md
```

**Principles:** every step idempotent and re-runnable; repo/key setup
lives beside the package it gates; declarative lists separate from
imperative steps; nothing hardware-specific in the default path.

---

## Part E — Milestones & backlog

1. **M1 — Fix bootstrap bugs (blocks all)**
   A1 folders.sh, A2 wire snap/brew into orchestrator, A3 remove `brew`
   apt entry, A4 repo-gated tools, A6 whitespace lines.
2. **M2 — Dedupe & restructure**
   A5 dedupe, A7 drop watchman binary, A8 `.gitignore`, A9 key artifact,
   A10/A11 consolidate components, A12 clean fish config → migrate to
   layered `steps/` + `lists/`.
3. **M3 — Capture current tools (curated drift)**
   Part C additions across apt/brew/snap; Part B pipx add.
4. **M4 — Prune noise & superseded tooling**
   Part B pipx prune, A13 awscli v1, brew.txt removals, A14 nvidia.

Blocking: **M1 → M2 → {M3, M4}**. M3/M4 can run in parallel after M2.
