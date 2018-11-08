
#!/usr/bin/env bash

# Make sure /data folder exits and mounted
# sudo mkdir -p /data && sudo chown $USER:users /data
# sudo apt install gnome-disk-utility

echo "»»» Replacing home folders with links to /data couterparts"
sudo mkdir -p /data/work 
sudo chown $USER:users /data
cd ~ 

# Make sure target folder exists exists
xargs mkdir -p <folders.txt


ln -s /data/
ln -s /data/work
ln -s /data/dropbox/ ~/Dropbox
ln -s /data/$USER/.PyCharm2017.3/
ln -s /data/$USER/.WebStorm2017.2/
ln -s /data/$USER/.gitconfig 
ln -s /data/$USER/.gitignore 
ln -s /data/$USER/.pypirc 
ln -s /data/$USER/.hgrc
ln -s /data/$USER/.bash_aliases 
ln -s /data/$USER/.cookiecutterrc
ln -s /data/$USER/.vagrant.d
ln -s /data/$USER/.ssh
#ln -s /data/$USER/.local/share .local/share
ln -s /data/$USER/.local/share/fonts .local/share/fonts
ln -s /data/$USER/.config/fish/completions .config/fish/completions
ln -s /data/$USER/.config/plasma-workspace/env .config/plasma-workspace/env
ln -s /data/$USER/.cache/spotify .cache/spotify
ln -s /data/$USER/.cache/pip .cache/pip
ln -s /data/$USER/.cache/pipenv .cache/pipenv
# TODO: Make these language independent
rm -r ~/Pobrane/ 
rm -r ~/Dokumenty/
rm -r ~/Wideo/
ln -s /data/$USER/Pobrane/ 
ln -s /data/$USER/Dokumenty/
ln -s /data/$USER/Obrazy/
ln -s /data/$USER/Pulpit/

