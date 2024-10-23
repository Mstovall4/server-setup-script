<<<<<<< HEAD
# server-setup-script
Automated server setup script for installing and configuring essential software on Ubuntu.
=======
# Server Setup and Configuration Script

## Overview
This project automates the setup of a basic web server on Kali Linux, including user management, security hardening, and firewall configuration.

## Features
- Installs and configures Apache, MariaDB, and PHP.
- Configures iptables firewall to allow HTTP (80) and SSH (22) traffic.
- Adds a new user (`adminuser`) and sets up SSH key-based authentication.
- Installs and configures fail2ban for security.
- Enables automatic updates.

## Requirements
- A system running Kali Linux.
- sudo privileges.
## Security Audit with Lynis

After setting up your server, you can perform a security audit using Lynis.

1. **Run the Lynis Audit**:
   To perform a security audit on your system, run the following command:
   ```bash
   sudo lynis audit system

## Usage
1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/yourusername/server-setup-script.git
   cd server-setup-script
>>>>>>> 06b1e18 (Initial commit: Server setup script for Kali Linux)
