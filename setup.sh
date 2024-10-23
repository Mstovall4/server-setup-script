#!/bin/bash

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install required packages
echo "Installing Apache, MariaDB, and PHP..."
sudo apt install -y apache2 mariadb-server php libapache2-mod-php

# Configure the firewall using iptables (since Kali may not have ufw)
echo "Configuring the firewall with iptables..."
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT  # Allow HTTP
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT  # Allow SSH
sudo iptables -A INPUT -j DROP  # Block everything else

# Add a new user if it doesn't exist
if id "adminuser" &>/dev/null; then
    echo "User 'adminuser' already exists."
else
    echo "Adding a new user 'adminuser'..."
    sudo adduser adminuser
fi

# Set up SSH key-based authentication for 'adminuser'
echo "Configuring SSH key-based authentication for 'adminuser'..."
sudo mkdir -p /home/adminuser/.ssh
sudo touch /home/adminuser/.ssh/authorized_keys
sudo chown -R adminuser:adminuser /home/adminuser/.ssh
sudo chmod 700 /home/adminuser/.ssh
sudo chmod 600 /home/adminuser/.ssh/authorized_keys

# Install and configure fail2ban for security
echo "Installing and configuring fail2ban..."
sudo apt install -y fail2ban

# Enable Apache to start on boot and start the service
echo "Starting and enabling Apache..."
sudo systemctl enable apache2
sudo systemctl start apache2

# Enable automatic updates
echo "Enabling automatic updates..."
sudo apt install -y unattended-upgrades
sudo dpkg-reconfigure --priority=low unattended-upgrades

echo "Server setup completed!"
