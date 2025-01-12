#!/bin/bash

cd ~/Downloads

sudo apt update -y

sudo apt upgrade -y

flatpak install flathub io.dbeaver.DBeaverCommunity -y

flatpak install flathub com.getpostman.Postman -y

wget "https://github.com/VSCodium/vscodium/releases/download/1.50.1/codium_1.50.1-1602760402_amd64.deb"

sudo apt install ./codium_1.50.1-1602760402_amd64.deb

rm codium_1.50.1-1602760402_amd64.deb

curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt-get update && sudo apt-get install spotify-client

sudo apt install vim virtualbox flameshot peek alacritty python3-pip vlc gnome-tweaks unzip zip gnome-shell-pomodoro slack gimp krita -y

pip3 install bpytop --upgrade

curl https://build.opensuse.org/projects/home:manuelschneid3r/public_key | sudo apt-key add -
echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/home:manuelschneid3r.list
sudo wget -nv https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_20.04/Release.key -O "/etc/apt/trusted.gpg.d/home:manuelschneid3r.asc"
sudo apt update
sudo apt install albert

exit 1
