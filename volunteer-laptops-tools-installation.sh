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
sudo wget ../hosts -P /etc/ansible/

echo -e "\nDownloading scripts and setting them as system executable...\n"

wget ../volunteer-laptops-help.sh
wget ../volunteer-laptops-update.sh

sudo chmod +x volunteer-laptops-help.sh
sudo chmod +x volunteer-laptops-update.sh

alias configure-volunteer-laptops="sudo nano /etc/ansible/hosts"
alias shutdown-volunteer-laptops="ansible -m command -a 'shutdown now' volunteerlaptops"
alias update-volunteer-laptops="./volunteer-laptops-update.sh"
alias volunteer-laptops-help="./volunteer-laptops-help.sh"

echo -e "\nTesting connection to volunteer laptops, if any errors are detected - panic.\n"

ansible -m ping volunteerlaptops

echo -e "\nSee below for a list of commands:\n"

volunteer-laptops-help

echo -e "\nVolunteer laptops tools installation completed!"