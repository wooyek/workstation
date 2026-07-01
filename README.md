# workstation

Scripts for partially unattended setup of my Linux workstation

## Setup

These scripts help me get a new OS to install ready for work quickly.
The same command works on **Kubuntu** and **Omarchy** — `bootstrap.sh`
detects the OS and runs the matching step tree:

	curl -L https://raw.githubusercontent.com/wooyek/workstation/master/get.sh | bash

I run Kubuntu on my main machine and Omarchy (Arch + Hyprland) elsewhere.

## Layout

`bootstrap.sh` sources `lib/os.sh` to detect the OS (`WORKSTATION_OS`
is `debian` or `arch`) and then runs the numbered steps for that OS in
order; each step is idempotent and safe to re-run.

### Debian / Kubuntu (apt) — `steps/`

| Step | Purpose | Source |
|------|---------|--------|
| `00-base.sh` | dirs, apt update/upgrade, ssh | — |
| `10-apt.sh` | apt packages | `lists/apt.txt` |
| `15-debs.sh` | local `.deb`s | `~/Downloads/Packages` |
| `20-repos/*.sh` | repo-gated installers (docker, gh, …) | — |
| `30-snap.sh` | snaps | `lists/snap.txt` |
| `40-brew.sh` | Homebrew + formulae | `lists/brew.txt` |
| `50-python.sh` | pipx apps | `lists/pipx.txt` |
| `55-vendor.sh` | self-managing installers (rustup, uv, starship, zoxide, tx, pyenv) | `steps/55-vendor/` |
| `57-cargo.sh` | cargo crates | `lists/cargo.txt` |
| `60-shell.sh` | fish + oh-my-fish | `fish_setup.fish` |
| `70-desktop.sh` | fonts, theme, locales | — |

### Arch / Omarchy (pacman + yay) — `steps/arch/`

| Step | Purpose | Source |
|------|---------|--------|
| `arch/00-base.sh` | dirs, `pacman -Syu`, base-devel, ssh | — |
| `arch/10-pkg.sh` | pacman packages | `lists/arch.txt` |
| `arch/20-aur.sh` | AUR packages via `yay` | `lists/aur.txt` |
| `40-brew.sh` | Homebrew + formulae (shared) | `lists/brew.txt` |
| `arch/50-python.sh` | pipx apps (no Plasma env) | `lists/pipx.txt` |
| `55-vendor.sh` | self-managing installers (shared) | `steps/55-vendor/` |
| `57-cargo.sh` | cargo crates (shared) | `lists/cargo.txt` |
| `arch/60-shell.sh` | fish + oh-my-fish | `fish_setup.fish` |

The cross-platform installers (`40-brew.sh`, `55-vendor.sh`,
`57-cargo.sh`) are reused by both trees, so brew/cargo/self-managing
tools stay defined once.

#### Omarchy / Arch support — scope & follow-ups

This first pass ships a working Omarchy bootstrap (package manager,
core CLIs/dev tooling, python, shell, and the shared brew/vendor/cargo
steps). The following are intentionally **not** yet ported:

- **Repo-gated installers** (`steps/20-repos/*`: docker, gh, vscode,
  spotify, …) — most are in the Arch repos or AUR; add pacman/`yay`
  equivalents or list them in `lists/arch.txt` / `lists/aur.txt`.
- **Local `.deb`s and snaps** — not applicable on Arch.
- **Desktop polish** (`70-desktop.sh`) — Kubuntu/Plasma-specific;
  Omarchy ships its own Hyprland theming.
- **Exhaustive package parity** — `lists/arch.txt` is a curated core,
  not a 1:1 translation of `lists/apt.txt`.

Override detection with `WORKSTATION_OS=arch bash bootstrap.sh` when
testing on a non-Arch host.

`components/` keeps reference scripts (`archive/`, `experimental/`,
`optional/`) that are **not** auto-run.

## No splash screen on boot

Replace `GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"` with `GRUB_CMDLINE_LINUX_DEFAULT=""` in `/etc/default/grub` then run `sudo update-grub`.


## Kubuntu widgets

- https://github.com/orblazer/plasma-applet-resources-monitor
- https://github.com/Zren/plasma-applet-volumewin7mixer
- https://github.com/Zren/plasma-applet-eventcalendar

## TODO

These require manual settings (help getting them scripted is appreciated):

1. Setup terminal to use [Sauce Code Pro Nerd Font Complete Mono](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete%20Mono.ttf)
2. Setup [Dracula color scheme](https://store.kde.org/p/1001521)
3. Setup Papirus icon set
4. Disable [quiet splash during boot](https://askubuntu.com/questions/33416/how-do-i-disable-the-boot-splash-screen-and-only-show-kernel-and-boot-text-inst)

