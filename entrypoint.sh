#!/bin/bash

# Configure the app onion service
mkdir -p /var/lib/tor/app_onion_service
echo $APP_ONION_HOSTNAME > /var/lib/tor/app_onion_service/hostname
echo $APP_ONION_PUBLIC_KEY_B64 | base64 -d > /var/lib/tor/app_onion_service/hs_ed25519_public_key
echo $APP_ONION_SECRET_KEY_B64 | base64 -d > /var/lib/tor/app_onion_service/hs_ed25519_secret_key
chown -R debian-tor:debian-tor /var/lib/tor/app_onion_service
chmod 700 /var/lib/tor/app_onion_service

# Configure the static site onion service
mkdir -p /var/lib/tor/static_onion_service
echo $STATIC_ONION_HOSTNAME > /var/lib/tor/static_onion_service/hostname
echo $STATIC_ONION_PUBLIC_KEY_B64 | base64 -d > /var/lib/tor/static_onion_service/hs_ed25519_public_key
echo $STATIC_ONION_SECRET_KEY_B64 | base64 -d > /var/lib/tor/static_onion_service/hs_ed25519_secret_key
chown -R debian-tor:debian-tor /var/lib/tor/static_onion_service
chmod 700 /var/lib/tor/static_onion_service

# Configure torrc
echo "SocksPort 0.0.0.0:9050" > /etc/tor/torrc
echo "HiddenServiceDir /var/lib/tor/app_onion_service" >> /etc/tor/torrc
echo "HiddenServicePort 80 $APP_ONION_PORT" >> /etc/tor/torrc
echo "" >> /etc/tor/torrc
echo "HiddenServiceDir /var/lib/tor/static_onion_service" >> /etc/tor/torrc
echo "HiddenServicePort 80 $STATIC_ONION_PORT" >> /etc/tor/torrc


echo "Onion service configured:"
echo "-------------------------"
cat /etc/tor/torrc
echo "-------------------------"

# Start tor
exec sudo -u debian-tor tor -f /etc/tor/torrc