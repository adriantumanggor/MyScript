#!/bin/bash

# Update system first
sudo dnf update -y

# Development Tools
sudo dnf groupinstall "Development Tools" -y

# Programming Languages
sudo dnf install gcc gcc-c++ make cmake python3 python3-pip nodejs rust cargo go ruby java-22-openjdk java-22-openjdk-devel -y

# Web Development
sudo dnf install php php-cli php-common php-mysqlnd php-json npm -y

# Databases
sudo dnf install mysql-server postgresql postgresql-server -y

# Docker and Container Tools
sudo dnf install docker docker-compose podman podman-compose -y
sudo systemctl enable --now docker

# Version Control
sudo dnf install git gitk gitg -y

# Virtualization
sudo dnf install qemu-kvm libvirt virt-manager virt-install bridge-utils -y

# IDEs and Editors
sudo dnf install code vim nano -y

# Reboot is recommended after installation
echo "Installation complete. Consider rebooting your system."
