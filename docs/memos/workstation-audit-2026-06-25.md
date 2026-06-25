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
4. **Channel preference (review 2026-06-25):** prefer **brew** over
   apt/snap/flatpak. Over apt when brew is newer/equal; over snap/flatpak
   generally. **Caveat:** brew *casks* (GUI apps) install on macOS only —
   on Linux this preference applies to brew **formulae** (CLIs) only;
   GUI apps use vendor `.deb`/repo. See [[channel-preference-brew]].
5. **Keep legacy pipx tooling** (review 2026-06-25): do NOT prune the
   superseded/abandoned pipx tools — they may still be needed for old
   project maintenance.
6. **Self-managing installers section** (review 2026-06-25): tools with
   their own install + upgrade scripts get a dedicated step and are kept
   OUT of the apt/brew/snap lists.

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
| A6 | MED | Trailing-whitespace lines — `apt install "$package"` receives a malformed arg | `packages.txt` |
| A7 | MED | `watchman-v2022.01.24.00-linux/` + `.zip` — a 4 MB binary tree from 2022 committed to git | repo root |
| A8 | MED | No `.gitignore`; `.idea/` is untracked and at risk of accidental commit | repo root |
| A9 | MED | `openvpn-repo-pkg-key.pub.1` — root-owned re-download artifact | repo root |
| A10 | MED | `components.sh` globs only `components/*.sh`; `archive/`, `experimental/`, `optional/` subdirs never run | `components.sh:4` |
| A11 | LOW | Three copies of the brew installer: `brew.sh`, `components/brew.sh`, `components/optional/brew.sh` | repo |
| A12 | LOW | `fish_setup.fish` carries dead config (pyenv/pipenv/nvm leftovers, stray bare path line) | `fish_setup.fish` |
| A13 | LOW | `awscli` (apt) coexists with `components/optional/awscliv2.sh` — v1 superseded by v2 | `packages.txt` |
| A14 | LOW | `nvidia-driver` (unversioned) vs `nvidia-driver-580` installed — version drift, hardware-specific | `packages.txt` |

## Part B — pipx tooling (decision: KEEP, do not prune)

`components/pipx.txt` carries tooling superseded by `uv` + `ruff`, but
per the 2026-06-25 review these are **kept** for old-project
maintenance. No pruning.

- **Keep all existing** (incl. `black`, `isort`, `flake8`, `autoflake`,
  `poetry`, `pipenv`, `pew`, `vex`, `pip-tools`, `legit`,
  `transifex-client`, `bump2version`, `check-manifest`, etc.).
- **Add:** `pyupgrade` (installed, was unlisted); `bump-my-version`
  (successor to `bump2version`, added).
- `tx` (modern Transifex CLI) is NOT pipx — it is a Go binary handled
  in the self-managing installers section (Part D).

## Part C — Drift: installed but missing from repo (curated)

Reconciled live install against repo lists. **Excluded as noise:**
kubuntu-desktop deps, `lib*`, `fonts-*`, `linux-*`, `grub*`,
`gstreamer*`, `language-pack-*`, hardware drivers (`nvidia-*`,
`r8125-dkms`), base system packages.

### apt — add (repo-gated → `steps/20-repos/`)
`docker-ce` + `docker-ce-cli` + `containerd.io` + `docker-buildx-plugin`
+ `docker-compose-plugin`, `signal-desktop`, `spotify-client`,
`warp-terminal`, `1password`, `nordlayer` + `nordlayer-tray`, `insync`.
- `kubectl` → **NOT apt**: use brew `kubernetes-cli` (1.35.2 > apt
  1.29.15) per channel preference.
- `chromium` → **apt via PPA** (e.g. `xtradeb/apps`, pairs with
  `chromium-chromedriver`) to avoid snap. **[Verify PPA]**

### apt — add (plain apt or .deb)
`golang-go`, `kitty`, `shellcheck`, `zoom`, `audacity`, `mpv`,
`screenkey`, `slop`, `xdotool`, `lm-sensors`, `pavucontrol`,
`filelight`.
- `bcompare` → **replace with Beyond Compare 5 vendor `.deb`** in
  `steps/20-repos/` (brew has v5.2.2 but as a *cask* — blocked on Linux;
  apt only has v4.4.7). **[Verify vendor .deb URL]**

### apt — add (optional / input method) **[Verify intentional]**
`fcitx5-chinese-addons`, `fcitx5-frontend-all`, `fcitx5-material-color`,
`kde-config-fcitx5`, `ibus`, `huiontablet`.

### brew — add (formulae)
`gemini-cli`, `glow`, `jiratui`, `kind`, `kubernetes-cli`, `lazysql`,
`ruff`, `rtk`, `vercel-cli`, `worktrunk`, `zellij`,
`philocalyst/tap/caligula`, `supabase/tap/supabase`.

### brew — keep / fix `brew.txt`
- **Keep `helm`** — install it via brew (user wants it). Remove the
  invalid snap `helm`.
- Remove `pyenv`, `structurizr-cli` (not installed / superseded).
- Remove `--cask` lines (`beyond-compare`, `obsidian`, `lm-studio`) —
  casks do not install on Linux. GUI apps handled elsewhere.
- `uv` / `starship` move to the self-managing installers section (Part D).

### snap — add / keep
- Keep current intentional snaps. **Do NOT add** `rambox` or
  `youtube-music-desktop-app` (user: drop from capture).
- `chromium` → moved to apt-PPA (above), avoid snap.

### snap — fix `snap.txt`
Remove `helm` (use brew), `sublime-text` (apt, not snap), `redis-insight`
(wrong name — duplicate of `redisinsight`).

---

## Part D — Target structure (layered, idempotent)

```
workstation/
  bootstrap.sh              # orchestrator: runs steps/ in numeric order
  steps/
    00-base.sh              # apt update/upgrade, base-build deps
    10-apt.sh               # <- lists/apt.txt
    20-repos/               # repo-gated + vendor .deb sources:
      docker.sh  gh.sh  vscode.sh  sublime.sh
      signal.sh  spotify.sh  warp.sh  1password.sh  nordlayer.sh
      chromium.sh           # PPA (avoid snap)  [Verify]
      beyond-compare.sh     # vendor .deb v5    [Verify]
    30-snap.sh              # <- lists/snap.txt
    40-brew.sh              # brew install + <- lists/brew.txt (formulae)
    50-python.sh            # uv-bootstrapped; pipx <- lists/pipx.txt
    55-vendor.sh            # SELF-MANAGING installers (own upgrade path):
                            #   rustup(+cargo), uv, starship, fnm,
                            #   zoxide, tx, gcloud  — NOT in apt/brew/snap
    57-cargo.sh             # cargo install <- lists/cargo.txt
    60-shell.sh             # fish + oh-my-fish + theme
    70-desktop.sh           # nerd fonts, dracula/papirus, grub splash
  lists/
    apt.txt  snap.txt  brew.txt  pipx.txt  cargo.txt
  components/archive/       # retained for reference, never auto-run
  docs/memos/
  .gitignore                # .idea/, *.zip, watchman-*/
  README.md
```

**Self-managing installers (step 55):** tools that ship their own
install + upgrade mechanism (`rustup`/`cargo`, `uv self update`,
`starship`, `fnm`, `zoxide`, Transifex `tx`, `gcloud` components). Kept
out of the package lists so the package manager and the tool's own
updater don't fight. (Current repo scatters these as `components/uv.sh`,
`starship.sh`, `rust.sh`, `tx.sh`, etc.; step 55 consolidates them.)

**Principles:** every step idempotent and re-runnable; repo/key setup
lives beside the package it gates; declarative lists separate from
imperative steps; nothing hardware-specific in the default path; prefer
brew formulae for CLIs.

---

## Part E — Milestones & backlog

1. **M1 — Fix bootstrap bugs (blocks all)** ✅ shipped in PR #11
   folders.sh, wire snap/brew, remove `brew` apt entry, repo-gated
   tools, whitespace + dedupe.
2. **M2 — Dedupe & restructure**
   drop watchman binary, `.gitignore`, key artifact, consolidate
   components, clean fish config → migrate to layered `steps/` +
   `lists/` (incl. step 55 self-managing + step 57 cargo).
3. **M3 — Capture current tools (curated drift)**
   Part C additions; add cargo support (rustup + cargo.txt); add `tx`;
   chromium via PPA; Beyond Compare 5 vendor .deb.
4. **M4 — Reconcile channels** (was "prune"; pipx prune dropped)
   kubectl → brew; helm via brew (rm snap helm); awscli v1 → v2;
   brew.txt cask/phantom cleanup; snap.txt fixes; nvidia version.

Blocking: **M1 → M2 → {M3, M4}**. M3/M4 can run in parallel after M2.
