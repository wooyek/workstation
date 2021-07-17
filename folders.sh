
#!/usr/bin/env bash

# Make sure /data folder exits and mounted
# sudo mkdir -p /data && sudo chown $USER:users /data
# sudo apt install gnome-disk-utility

echo "»»» Replacing home folders with links to /data couterparts"
sudo mkdir -p /data/work 
sudo chown $USER:users /data

# Make sure target folder exists exists
xargs mkdir -p <folders.txt

cd ~ 

mkdir -p /home/$USER/.config/plasma-workspace/
#ln -s /data/$USER/.local/share .local/share
ln -s /data/$USER/.bash_aliases 
ln -s /data/$USER/.cache/google-chrome /home/$USER/.cache/google-chrome
ln -s /data/$USER/.cache/JetBrains /home/$USER/.cache/JetBrains
ln -s /data/$USER/.cache/pip /home/$USER/.cache/pip
ln -s /data/$USER/.cache/pipenv /home/$USER/.cache/pipenv
ln -s /data/$USER/.cache/spotify /home/$USER/.cache/spotify
ln -s /data/$USER/.config/fish /home/$USER/.config/fish
ln -s /data/$USER/.config/google-chrome /home/$USER/.config/google-chrome
ln -s /data/$USER/.config/JetBrains /home/$USER/.config/JetBrains
ln -s /data/$USER/.config/plasma-workspace/env .config/plasma-workspace/env
ln -s /data/$USER/.config/Slack /home/$USER/.config/Slack
ln -s /data/$USER/.cookiecutterrc
ln -s /data/$USER/.gitconfig 
ln -s /data/$USER/.gitignore 
ln -s /data/$USER/.hgrc
ln -s /data/$USER/.local/share/fonts .local/share/fonts
ln -s /data/$USER/.local/share/Steam /home/$USER/.local/share/Steam
ln -s /data/$USER/.npm
ln -s /data/$USER/.nvm
ln -s /data/$USER/.pyenv
ln -s /data/$USER/.pypirc 
ln -s /data/$USER/.ssh
ln -s /data/$USER/.tox
ln -s /data/$USER/.tox /home/$USER/.tox
ln -s /data/$USER/.vagrant.d
ln -s /data/dropbox/ ~/Dropbox

# TODO: Make these language independent

rm -r ~/Desktop
ln -s /data/$USER/Desktop/ 

rm -r ~/Downloads
ln -s /data/$USER/Pobrane/ Downloads

rm -r ~/Documents 
ln -s /data/$USER/Dokumenty/ Documents

#rm -r ~/Documents/
# rm -r ~/Wideo/
#ln -s /data/$USER/Dokumenty/
#ln -s /data/$USER/Obrazy/
#ln -s /data/$USER/Pulpit/ Desktop
