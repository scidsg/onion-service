#!/bin/bash
set -eu

declare -r USER=debian-tor
declare -r GROUP="$USER"
declare -r ONION_DIR=/var/lib/tor/onion_service
declare -r TORRC=/etc/tor/torrc
# shellcheck disable=SC2155
declare -r UMASK=$(umask || echo 0022)

# Ensure required env vars are set, error otherwise
: "${ONION_HOSTNAME:?'not set or empty'}"
: "${ONION_PUBLIC_KEY_B64:?'not set or empty'}"
: "${ONION_SECRET_KEY_B64:?'not set or empty'}"
: "${ONION_PORT:?'not set or empty'}"

# Debug output
echo "ONION_HOSTNAME: $ONION_HOSTNAME"
echo "ONION_PUBLIC_KEY_B64: $ONION_PUBLIC_KEY_B64"
echo "ONION_SECRET_KEY_B64: <redacted>"
echo "ONION_PORT: $ONION_PORT"

# Configure the onion service
umask 0077
mkdir -p "$ONION_DIR"
echo "$ONION_HOSTNAME" > "$ONION_DIR/hostname"
echo "$ONION_PUBLIC_KEY_B64" | base64 -d > "$ONION_DIR/hs_ed25519_public_key"
echo "$ONION_SECRET_KEY_B64" | base64 -d > "$ONION_DIR/hs_ed25519_secret_key"
chown -R "$USER:$GROUP" "$ONION_DIR"

# reset umask
umask "$UMASK"

# Configure torrc
echo "SocksPort 0.0.0.0:9050" > "$TORRC"
echo "HiddenServiceDir $ONION_DIR" >> "$TORRC"
echo "HiddenServicePort 80 $ONION_PORT" >> "$TORRC"

echo "Onion service configured:"
echo "-------------------------"
cat "$TORRC"
echo "-------------------------"

# Start tor
exec sudo -u "$USER" tor -f "$TORRC"
