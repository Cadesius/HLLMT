#!/bin/bash
# echo "Enter admin password for all volunteer laptops: "
# read password

# echo ""

# Retrieve server list from file

file=server-list

# Read each line of server-list

for server in `cat $file`
do

# Set ':' as seperation character

IFS=':'

# Create an array containing the username and password of each line in server-list

read -ra arr <<< "$server"

# Create variables for each server and password from the array

host="${arr[0]}"
password="${arr[1]}"

# Append server details to the Ansible hosts file

echo -e "\n$host ansible_become_pass='$password'" | sudo tee -a /etc/ansible/hosts

# Authenticate each server using the server details

sshpass -p "$password" ssh-copy-id "$host"

done

echo -e "\nTesting connection to volunteer laptops, if any errors are detected - panic.\n"

ansible -m ping volunteerlaptops

echo -e "Setup complete! Please refer to the help page for more information by entering 'volunteer-laptops-help' into the terminal"