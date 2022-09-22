#!/bin/bash

echo "Starting update..."

echo ""

echo "Please ensure that all volunteer laptops requiring updates are switched on and connected to the same network as this device"

echo ""

ansible -m command -a "pacman -Syyu --noconfirm" volunteerlaptops --become --become-method sudo

echo ""

echo "Update complete!"