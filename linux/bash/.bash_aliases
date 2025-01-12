# System calls
alias update="sudo apt update -y && sudo apt upgrade -y && flatpak update -y"
alias clean="sudo apt autoremove -y && sudo apt autoclean -y"
alias install="sudo apt install "
alias ll="ls -la"
alias performance="sudo ./Scripts/cpu_performance_settings.sh"
alias audioreset="systemctl --user restart wireplumber pipewire pipewire-pulse"

# Programming
alias github="firefox https://github.com/echokrist?tab=repositories"
alias programming="cd ~/Programming"
alias pp="git pull && git push"
alias dotnetrun="dotnet clean && dotnet build && dotnet run"

# Misc
alias mail="firefox https://mail.protonmail.com/u/0/inbox"
