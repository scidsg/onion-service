#!/bin/bash

# Create torrc
echo "HiddenServiceDir /var/lib/tor/hidden_service/" > /etc/tor/torrc
echo "HiddenServicePort 80 127.0.0.1:80" >> /etc/tor/torrc

# Start tor with this torrc in a background process, then kill it
tor -f /etc/tor/torrc &> /dev/null &
sleep 5

# Get the onion info
cd /var/lib/tor/hidden_service/
ONION_HOSTNAME=$(cat hostname)
ONION_PUBLIC_KEY_B64=$(cat hs_ed25519_public_key | base64 | tr -d '\n')
ONION_SECRET_KEY_B64=$(cat hs_ed25519_secret_key | base64 | tr -d '\n')

# Display it
echo "ONION_HOSTNAME=$ONION_HOSTNAME"
echo "ONION_PUBLIC_KEY_B64=$ONION_PUBLIC_KEY_B64"
echo "ONION_SECRET=$ONION_SECRET_KEY_B64"
