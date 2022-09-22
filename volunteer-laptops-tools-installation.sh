#!/bin/bash

echo -e "Starting install of the volunteer laptops tools...\n"

sudo apt-get update
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update && sudo apt-get install ansible -y

echo -e "\nCreating SSH security key, and applying to all configured clients...\n"

ssh-keygen -t rsa -b 4096 -C "admin@swheritage.org.uk"

ssh-copy-id swht-volunteer@10.11.21.140
# copy ssh key to all volunteer laptops

echo -e "\nUpdating Ansible host list...\n"

sudo rm /etc/ansible/hosts
sudo wget https://raw.githubusercontent.com/Cadesius/HLLMT/main/hosts -P /etc/ansible/

echo -e "\nDownloading scripts and setting them as system executable...\n"

wget https://raw.githubusercontent.com/Cadesius/HLLMT/main/volunteer-laptops-tools-help.sh
wget https://raw.githubusercontent.com/Cadesius/HLLMT/main/volunteer-laptops-tools-update.sh
wget https://github.com/Cadesius/HLLMT/raw/main/alias-commands

sudo chmod +x volunteer-laptops-tools-help.sh
sudo chmod +x volunteer-laptops-tools-update.sh

sudo cat alias-commands >> .bash_aliases
source .bashrc

rm alias-commands

echo -e "\nTesting connection to volunteer laptops, if any errors are detected - panic.\n"

ansible -m ping volunteerlaptops

echo -e "\nSee below for a list of commands:\n"

volunteer-laptops-help

echo -e "\nVolunteer laptops tools installation completed!"