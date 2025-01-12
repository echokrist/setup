#!/bin/bash

# Set CPU Scheduler to performance on all CPU cores.
echo "Setting the CPU scheduler to performance mode. ";
for cpu in /sys/devices/system/cpu/cpu?; do
    sudo echo "performance" > $cpu/cpufreq/scaling_governor
    echo "Set performance for scaling governor $cpu"
done


for cpu in /sys/devices/system/cpu/cpufreq/policy?; do
      sudo echo "performance" > $cpu/scaling_governor
echo "Set performance for scaling governor $cpu"

done

for cpu in /sys/devices/system/cpu/cpufreq/policy??; do
      sudo echo "performance" > $cpu/scaling_governor
echo "Set performance for scaling governor $cpu"

done

# Enable 32-bit support
echo "Enabling 32-bit support. ";
sudo dpkg --add-architecture i386


# Update and upgrade all packages.
echo "Updating and upgrading all packages ";
sudo apt -qq update -y && sudo apt -qq upgrade -y

echo "Installing packages from repositories. ";
# Install packages from repositories
sudo apt -qq install bpytop git vim-* firejail jq gnome-tweaks unzip zip kdeconnect timeshift golang rust-all wine-stable winetricks -y

# Configure global git user name and email.
echo "Configuring global git user name and email. ";
git config --global user.name "kristian-n-a"
git config --global user.email "crnial@pm.me"

# Setup Flatpak
echo "Setting up Flatpak ";
sudo apt -qq install flatpak -y
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Installing all Flatpak applications. ";
# Install all Flatpak applications.
flatpak install flathub org.gnome.gitlab.somas.Apostrophe -y
flatpak install flathub com.rafaelmardojai.Blanket -y
flatpak install flathub com.feaneron.Boatswain -y
flatpak install flathub com.usebottles.bottles -y
flatpak install flathub org.gnome.Boxes -y
flatpak install flathub org.gnome.BreakTimer -y
flatpak install flathub com.github.huluti.Curtail -y
flatpak install flathub io.dbeaver.DBeaverCommunity -y
flatpak install flathub com.discordapp.Discord -y
flatpak install flathub com.github.wwmm.easyeffects -y
flatpak install flathub org.flameshot.Flameshot -y
flatpak install flathub com.github.tchx84.Flatseal -y
flatpak install flathub com.leinardi.gwe -y
flatpak install flathub org.kde.kdenlive -y
flatpak install flathub com.bitstower.Markets -y
flatpak install flathub com.obsproject.Studio -y
flatpak install flathub org.onlyoffice.desktopeditors -y
flatpak install flathub com.getpostman.Postman -y
flatpak install flathub com.github.johnfactotum.QuickLookup -y
flatpak install flathub io.github.Soundux -y
flatpak install flathub com.spotify.Client -y
flatpak install flathub com.github.unrud.VideoDownloader -y
flatpak install flathub org.videolan.VLC -y
flatpak install flathub org.gimp.GIMP -y

# Change directory to Downloads
cd ~/Downloads

# Install Steam and remove install file.
echo "Installing Steam. ";
wget "https://steamcdn-a.akamaihd.net/client/installer/steam.deb"
sudo dpkg -i steam.deb
rm steam.deb

# Install Inkdrop and remove install file.
echo "Installing Inkdrop."
wget "wget https://api.inkdrop.app/download/linux/deb"
sudo dpkg -i inkdrop.deb
rm inkdrop.deb

# Download and install Orchis-theme, clean up after.
echo "Downloading the latest version of the Orchis-theme from Github and installing it."
git clone https://github.com/vinceliuice/Orchis-theme.git
cd Orchis-theme
./install.sh
cd ~/Downloads
rm -rf Orchis-theme

# Download and install Tela-icon-theme, clean up after.
echo "Downloading the latest version of the Tela-icon-theme from Github and installing it."
git clone https://github.com/vinceliuice/Tela-icon-theme.git
cd Tela-icon-theme
./install.sh
cd ~/Downloads
rm -rf Thela-icon-theme

echo "Installation of Orchis-theme and Tela-icon-theme is completed."

echo "Gnome setup completed."
echo "If you want to further configure or select other themes and icons.
Then open gnome-tweaks and go to the apperance tab on the left hand side."

echo "Setup script for Gnome completed.";

echo "Opening Firefox with all the tabs for the Gnome extensions I recommend:"
firefox https://extensions.gnome.org/extension/19/user-themes/ https://extensions.gnome.org/extension/3628/arcmenu/ https://extensions.gnome.org/extension/602/window-list/ https://extensions.gnome.org/extension/906/sound-output-device-chooser/ https://extensions.gnome.org/extension/779/clipboard-indicator/
