# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force;
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Enable auto accept for Chocolatey
choco feature enable -n allowGlobalConfirmation

# Install applications
choco install chocolatey-core.extension googlechrome firefox python3 vlc git vscode dbeaver docker-desktop spotify gimp 7zip foxitreader ccleaner filezilla nodejs curl onlyoffice vim chromium chocolateygui php dotnet ffmpeg vmware-workstation-player vmware-tools visualstudio2022community obs-studio flameshot postman smartgit
