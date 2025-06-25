#!/usr/bin/env fish
# https://asdf-vm.com/guide/getting-started.html#official-download

# https://asdf-vm.com/guide/getting-started.html#_3-install-asdf
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0

# http://asdf-vm.com/guide/getting-started.html#_3-install-asdf
source ~/.asdf/asdf.fish

mkdir -p ~/.config/fish/completions; and ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions

# https://github.com/kennyp/asdf-golang
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf install golang (asdf latest golang)

asdf plugin-add k9s
asdf install k9s (asdf latest k9s)


asdf plugin-add adr-tools https://gitlab.com/td7x/asdf/adr-tools.git
asdf install adr-tools (asdf latest adr-tools)

asdf plugin-add aws-vault https://github.com/karancode/asdf-aws-vault.git
asdf install aws-vault (asdf latest aws-vault)


# https://github.com/amoosbr/asdf-structurizr-cli#install
asdf plugin add structurizr-cli https://github.com/amoosbr/asdf-structurizr-cli.git
asdf list-all structurizr-cli
asdf install structurizr-cli latest
asdf global structurizr-cli latest
structurizr-cli