#!/bin/bash

# Set your Duck DNS token and domain
TOKEN="517bc219-6fe9-4129-b4eb-5474de57a3f7"  
DOMAIN="test-server-1"  

# Get the current public IP address
IP=$(curl -s http://ipv4.icanhazip.com)

if [ -z "$IP" ]; then
    echo "Failed to retrieve IP address."
    exit 1
fi

# Update Duck DNS
RESPONSE=$(curl -s "https://www.duckdns.org/update?domains=${DOMAIN}&token=${TOKEN}&ip=${IP}")

if [[ "$RESPONSE" == "OK"* ]]; then
    echo "DuckDNS updated successfully: $RESPONSE"
else
    echo "DuckDNS update failed: $RESPONSE"
fi

