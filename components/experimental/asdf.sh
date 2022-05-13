#!/usr/bin/env fish

# https://asdf-vm.com/guide/getting-started.html#_3-install-asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0

# http://asdf-vm.com/guide/getting-started.html#_3-install-asdf
source ~/.asdf/asdf.fish

mkdir -p ~/.config/fish/completions; and ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions

# https://github.com/kennyp/asdf-golang
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git

asdf plugin-add adr-tools https://gitlab.com/td7x/asdf/adr-tools.git
asdf install adr-tools (asdf latest adr-tools)

asdf plugin-add aws-vault https://github.com/karancode/asdf-aws-vault.git
asdf install aws-vault (asdf latest aws-vault)