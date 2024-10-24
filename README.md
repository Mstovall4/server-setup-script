# Server Setup and Configuration Script

## Overview
This project automates the setup of a basic web server on Kali Linux, including user management, security hardening, and firewall configuration.

## Features
- Installs and configures Apache, MariaDB, and PHP.
- Configures `iptables` firewall to allow HTTP (80) and SSH (22) traffic.
- Adds a new user (`adminuser`) and sets up SSH key-based authentication.
- Installs and configures fail2ban for security.
- Enables automatic updates.
- Sets up DuckDNS for dynamic DNS updates.
- Configures SSL/TLS using Let's Encrypt.
- Integrates ngrok for secure access to local servers.

## Requirements
- A system running Kali Linux.
- sudo privileges.

## Security Audit with Lynis

After setting up your server, you can perform a security audit using Lynis.

1. **Run the Lynis Audit**:
   To perform a security audit on your system, run the following command:
   ```bash
   sudo lynis audit system


