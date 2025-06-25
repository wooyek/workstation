#!/usr/bin/env fish
curl -L https://get.oh-my.fish | fish
set -g theme_nerd_fonts yes
set -g theme_title_use_abbreviated_path no
omf install bobthefish
omf theme bobthefish

# https://github.com/oh-my-fish/theme-bobthefish
set -U theme_nerd_fonts yes
set -U theme_title_use_abbreviated_path no
set -U theme_use_abbreviated_branch_name yes
set -U theme_display_k8s_context yes
set -U theme_display_k8s_namespace yes
set -U theme_newline_cursor yes
set -U theme_newline_prompt '$ '



set -Ux NVM_DIR /data/$USER/.nvm
omf install nvm

# set -Ux WORKON_HOME /data/vens/
# set -Ux PIPENV_SHELL_FANCY True
# This is required for KDE aplications to see these variables
# echo "export WORKON_HOME=/home/venvs/" > $HOME/.config/plasma-workspace/env/workon_home.sh


# Fish Shell completitions
# These will somtimes requires to install the actual commend like pyenv

mkdir -p ~/.config/fish/completions/
# curl https://raw.githubusercontent.com/pyinvoke/invoke/master/completion/fish -o ~/.config/fish/completions/pyinvoke
# https://github.com/pypa/pipenv#shell-completion
# This does not work
# echo "eval (pipenv --completion)" > ~/.config/fish/completions/pipenv.fish
echo complete --command pipenv --arguments \"\(env _PIPENV_COMPLETE=complete-fish COMMANDLINE=\(commandline -cp\) pipenv\)\" -f > ~/.config/fish/completions/pipenv.fish

# To see current PyEnv help run
# pyenv init
# https://github.com/pyenv/pyenv#basic-github-checkout
set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths

contains /home/$USER/.local/bin $PATH; or set -U fish_user_paths /home/$USER/.local/bin

/home/janusz/.local/bin
# Put these in ~/.config/fish/config.fish
# status is-login; and pyenv init --path | source
# status is-interactive; and pyenv init - | source

# https://pip.pypa.io/en/stable/user_guide/#command-completion
#python -m pip completion --fish > ~/.config/fish/completions/pip.fish


# https://github.com/nvm-sh/nvm#important-notes
omf install https://github.com/FabioAntunes/fish-nvm
omf install https://github.com/edc/bass
