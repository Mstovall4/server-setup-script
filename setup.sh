#!/bin/bash
set -e  # Exit on error

# Check network connectivity
echo "Checking network connectivity..."
if ! ping -c 1 google.com &> /dev/null; then
    echo "Network is not reachable. Please check your connection."
    exit 1
fi

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install required packages
echo "Installing Apache, MariaDB, and PHP..."
sudo apt install -y apache2 mariadb-server php libapache2-mod-php

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

# Install Certbot for SSL/TLS certificate
echo "Installing Certbot for SSL/TLS certificate management..."
sudo apt install -y certbot python3-certbot-apache

# Obtain an SSL certificate
read -p "Enter your domain name (e.g., yourdomain.com): " domain
if [ -z "$domain" ]; then
    echo "Domain name cannot be empty."
    exit 1
fi
sudo certbot --apache -d "$domain" -d "www.$domain"

# Set up automatic renewal for the certificate
echo "Setting up automatic renewal for the SSL certificate..."
sudo certbot renew --dry-run

# Install Lynis for security auditing
echo "Installing Lynis for security auditing..."
sudo apt install -y lynis

# Enable Apache to start on boot and start the service
echo "Starting and enabling Apache..."
sudo systemctl enable apache2
sudo systemctl start apache2

# Enable automatic updates
echo "Enabling automatic updates..."
sudo apt install -y unattended-upgrades
sudo dpkg-reconfigure --priority=low unattended-upgrades

# Configure the firewall using iptables
echo "Configuring the firewall with iptables..."
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT  # Allow HTTP
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT # Allow HTTPS
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT  # Allow SSH
sudo iptables -A INPUT -j DROP  # Block everything else

# Save iptables rules
sudo iptables-save | sudo tee /etc/iptables/rules.v4

# Clean up unused packages
sudo apt autoremove -y

echo "Setup complete!"

