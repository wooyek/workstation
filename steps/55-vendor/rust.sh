#!/usr/bin/env bash

# Rust toolchain — provides cargo. Self-updating via `rustup update`.
# https://rustup.rs/   (crates are installed by steps/57-cargo.sh)

echo "----> Rust toolchain (rustup + cargo)"

if ! command -v cargo >/dev/null 2>&1; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi
