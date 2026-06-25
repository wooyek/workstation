#!/usr/bin/env bash

# Transifex CLI (`tx`) — modern Go binary, replaces the old
# python `transifex-client`. NOT a pip/pipx package.
# [Verify] https://github.com/transifex/cli — the install script
# drops the `tx` binary into the current directory; we run it from
# ~/.local/bin so the binary lands on PATH.

echo "----> Transifex CLI (tx)"

mkdir -p "$HOME/.local/bin"
cd "$HOME/.local/bin" || exit 1
curl -o- https://raw.githubusercontent.com/transifex/cli/master/install.sh | bash
