#!/bin/bash

# Update and upgrade all packages.
apt update -y && apt upgrade -y
apt install update-manager-core

# Setup .bash_aliases
touch ~/.bash_aliases
echo "alias syslog='tail -f /var/log/syslog'" >> ~/.bash_aliases
source ~/.bashrc


# Enforce SSH only login at port 9274.
grep -q "ChallengeResponseAuthentication" /etc/ssh/sshd_config && sed -i "/^[^#]*ChallengeResponseAuthentication[[:space:]]yes.*/c\ChallengeResponseAuthentication no" /etc/ssh/sshd_config || echo "ChallengeResponseAuthentication no" >> /etc/ssh/sshd_config
grep -q "^[^#]*PasswordAuthentication" /etc/ssh/sshd_config && sed -i "/^[^#]*PasswordAuthentication[[:space:]]yes/c\PasswordAuthentication no" /etc/ssh/sshd_config || echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
grep -q "^[^#]*Port" /etc/ssh/sshd_config && sed -i "/^[^#]*Port[[:space:]]22/c\Port 22" /etc/ssh/sshd_config || echo "Port 9274" >> /etc/ssh/sshd_config


systemctl restart ssh -y
##

# Install all necessary packages.

apt install unattended-upgrades ca-certificates wget net-tools curl lsb-release gnupg ufw libxmlsec1 libxmlsec1-openssl endlessh htop -y

# Enable auto update Ubuntu security
systemctl status unattended-upgrades.service

# Set ufw to allow SSH and VPN ports.
ufw allow OpenSSH
ufw allow 1194
ufw allow 9274
ufw enable

##

# Install Crowdsec with basic settings.
curl -s https://packagecloud.io/install/repositories/crowdsec/crowdsec/script.deb.sh | sudo bash

apt install crowdsec -y
apt install crowdsec-firewall-bouncer-iptables -y
cscli scenarios install crowdsecurity/iptables-scan-multi_ports
cscli collections install crowdsecurity/endlessh

# Run setup wizard.
/usr/share/crowdsec/wizard.sh -c


# Configure Endlessh - SSH loop for Hackers.
echo 'net.ipv4.ip_unprivileged_port_start=0' > /etc/sysctl.d/50-unprivileged-ports.conf
sysctl --system

echo 'Port 22
Delay 10000
MaxLineLength 32
MaxClients 4096
LogLevel 1
BindFamily 0' > /etc/endlessh/config


echo "filenames:
  - /var/log/syslog
labels:
  type: endlessh" >> /etc/crowdsec/acqui.yml

service endlessh restart
service crowdsec restart

# Install Docker.

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update

apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y


# Enable auto restart of Docker when server restarts.
systemctl enable docker

# Enable auto restart of Crowdsec when server restarts.
systemctl enable crowdsec
systemctl start crowdsec-firewall-bouncer

service endlessh start
service crowdsec start
