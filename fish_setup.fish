#!/usr/bin/env fish
curl -L https://get.oh-my.fish | fish
set -g theme_nerd_fonts yes
set -g theme_title_use_abbreviated_path no
omf install bobthefish
omf theme bobthefish

set -Ux NVM_DIR /data/$USER/.nvm
omf install nvm

set -Ux WORKON_HOME /data/vens/
set -Ux PIPENV_SHELL_FANCY True
# This is required for KDE aplications to see these variables
# echo "export WORKON_HOME=/data/venvs/" > $HOME/.config/plasma-workspace/env/workon_home.sh


# Fish Shell completitions
# These will somtimes requires to install the actual commend like pyenv

mkdir -p ~/.config/fish/completions/
curl https://raw.githubusercontent.com/pyinvoke/invoke/master/completion/fish -o ~/.config/fish/completions/pyinvoke
# https://github.com/pypa/pipenv#shell-completion
# This does not work
# echo "eval (pipenv --completion)" > ~/.config/fish/completions/pipenv.fish
echo complete --command pipenv --arguments \"\(env _PIPENV_COMPLETE=complete-fish COMMANDLINE=\(commandline -cp\) pipenv\)\" -f > ~/.config/fish/completions/pipenv.fish

# To see current PyEnv help run
# pyenv init
# Put these in ~/.config/fish/config.fish
# set -x PATH "/home/$USER/.pyenv/bin" $PATH

set -Ux fish_user_paths /home/$USER/.pyenv/bin $fish_user_paths

status --is-interactive; and source (pyenv init -|psub)

pip completion --fish > ~/.config/fish/completions/pip.fish


# https://github.com/nvm-sh/nvm#important-notes
omf install https://github.com/FabioAntunes/fish-nvm
omf install https://github.com/edc/bass
