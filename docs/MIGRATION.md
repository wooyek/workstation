# OS Migration Procedure

Moving to a fresh Kubuntu install on a new disk, without losing
configs, credentials, or shell history. Pairs with `migrate/backup.sh`
and `migrate/restore.sh`.

Assumptions: project data lives on a separate disk (e.g. `/work`) that
survives the reinstall; the backup is staged there.

## Phase 1 — Backup (old system)

```bash
# 1. Stage configs, credentials, histories, /etc and manifests:
migrate/backup.sh

# 2. Re-run with the sudo extras (Wi-Fi/VPN profiles, host keys,
#    docker daemon config) and optional user data:
WITH_SUDO=1 USER_DATA=1 migrate/backup.sh

# 3. Optionally include Claude Code per-project state (~2 GB):
FULL_CLAUDE=1 migrate/backup.sh
```

Then verify:

- `du -sh /work/migration/<host>-<date>/*` — sanity-check sizes.
- Spot-check `home/.local/share/fish/fish_history` is present.
- Confirm cloud-synced dirs (GDrive, Dropbox) do NOT need copying —
  they re-sync on the new install.
- Docker volumes are **not** backed up: containers here are disposable
  and every database that matters is remote. `manifests/docker-volumes.txt`
  lists the volume names so compose stacks can be recreated on demand.

## Phase 2 — Hardware

1. Install the new NVMe in the correct M.2 slot (see your board manual:
   prefer a CPU-attached slot that does **not** share lanes with the
   x16 GPU slot).
2. Physically disconnect any disk you plan to retire *before*
   installing — the installer can't put the bootloader on the wrong
   EFI partition if that disk isn't there.
3. Keep the data disk(s) connected only if you're confident; plugging
   them back in after the first successful boot is the safer order.

## Phase 3 — Fresh install

1. Install Kubuntu on the new disk (EFI + `/` + `/home`, or a single
   `/` — your choice).
2. First boot: verify network. If the NIC needs an out-of-tree driver
   (e.g. Realtek r8125 DKMS), the source tree is in the backup under
   `home/realtek-r8125-dkms`.
3. Re-add data-disk mounts to `/etc/fstab` **by UUID and with
   `nofail`** — never by `/dev/nvmeXnY` path, and never without
   `nofail`: NVMe enumeration order is not stable, and a missing disk
   must not hang boot.

## Phase 4 — Bootstrap + restore

```bash
# 1. Bootstrap the toolchain:
curl -L https://raw.githubusercontent.com/wooyek/workstation/master/get.sh | bash

# 2. Restore configs and credentials:
migrate/restore.sh /work/migration/<host>-<date>
```

## Phase 5 — Re-authentication & verification

`restore.sh` prints the checklist. The short version:

| Survives the copy | Needs re-auth |
|---|---|
| SSH keys, AWS profiles, kubeconfigs | gcloud login |
| GPG keyring, git config + hooks | GitHub CLI (verify) |
| fish/bash/psql/ipython history | Docker registries (first pull) |
| KDE Wallet / keyrings (same login password only) | Browser sign-in / sync |
| Claude Code skills, agents, memory | Anything TPM-bound |

Rotate any secret that was stored in plaintext configs before you
grant the backup copies long-term shelf life.

## Notes

- The backup is incremental — re-run `backup.sh` right before the
  final shutdown to catch last-minute changes.
- JetBrains IDEs restore their settings but **not** their plugins —
  those re-download from the marketplace. Work through
  `manifests/jetbrains-plugins.txt` to re-add them per IDE.
- Keep the retired OS disk untouched for a couple of weeks as a
  fallback before wiping it.
