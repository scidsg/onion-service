# onion-service

container for hosting a Tor Onion service.

You need to pass in the following environment variables:

- `APP_ONION_HOSTNAME`: content of `hostname`
- `APP_ONION_PUBLIC_KEY_B64`: Base64-encoded content of `hs_ed25519_public_key`
- `APP_ONION_SECRET_KEY_B64`: Base64-encoded content of `hs_ed25519_secret_key`
- `APP_ONION_PORT`: hostname and port of the clearnet service, such as `app:8080`

- `STATIC_ONION_HOSTNAME`: content of `hostname`
- `STATIC_ONION_PUBLIC_KEY_B64`: Base64-encoded content of `hs_ed25519_public_key`
- `STATIC_ONION_SECRET_KEY_B64`: Base64-encoded content of `hs_ed25519_secret_key`
- `STATIC_ONION_PORT`: hostname and port of the clearnet service, such as `static-site:8080`
