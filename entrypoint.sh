#!/bin/bash

# Debug output
echo "ONION_HOSTNAME: $ONION_HOSTNAME"
echo "ONION_PUBLIC_KEY_B64: $ONION_PUBLIC_KEY_B64"
echo "ONION_SECRET_KEY_B64: <redacted>"
echo "ONION_PORT: $ONION_PORT"

# Configure the onion service
mkdir -p /var/lib/tor/onion_service
echo $ONION_HOSTNAME > /var/lib/tor/onion_service/hostname
echo $ONION_PUBLIC_KEY_B64 | base64 -d > /var/lib/tor/onion_service/hs_ed25519_public_key
echo $ONION_SECRET_KEY_B64 | base64 -d > /var/lib/tor/onion_service/hs_ed25519_secret_key
chown -R debian-tor:debian-tor /var/lib/tor/onion_service
chmod 700 /var/lib/tor/onion_service

# Configure torrc
echo "SocksPort 0.0.0.0:9050" > /etc/tor/torrc
echo "HiddenServiceDir /var/lib/tor/onion_service" >> /etc/tor/torrc
echo "HiddenServicePort 80 $ONION_PORT" >> /etc/tor/torrc

# Start tor
exec sudo -u debian-tor tor -f /etc/tor/torrc