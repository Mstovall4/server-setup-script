#!/bin/bash

# Set your Duck DNS token and domain
TOKEN="38f6bfcc-f9d0-483f-95b2-f3d61502dbbd"  
DOMAIN="test-domain1"  

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

