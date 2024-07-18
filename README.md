# onion-service

container for hosting a Tor Onion service.

You need to pass in the following environment variables:

- `ONION_HOSTNAME`: content of `hostname`
- `ONION_PUBLIC_KEY_B64`: Base64-encoded content of `hs_ed25519_public_key`
- `ONION_SECRET_KEY_B64`: Base64-encoded content of `hs_ed25519_secret_key`
- `ONION_PORT`: hostname and port of the clearnet service, such as `app:8080`

Example usage:

```sh
docker build . -t onion-service
docker run --rm \
  -e ONION_HOSTNAME=vfqcb3w4j3sdabgn77p3lobeyz3jpt4i3cqh7exddmyulhvc374jmqid.onion \
  -e ONION_PUBLIC_KEY_B64=PT0gZWQyNTUxOXYxLXB1YmxpYzogdHlwZTAgPT0AAACpYCDu3E7kMATN/9+1uCTGdpfPiNigf5LjGzFFnqLf+A== \
  -e ONION_SECRET_KEY_B64=PT0gZWQyNTUxOXYxLXNlY3JldDogdHlwZTAgPT0AAACAzLIc/vOHVt5zhXrd4FierWxPPfHjHxghrD8NNZ7aWXiMox/wAm0kuClDngjc9hhE6DoLAnjmE8iO3iDqnaZj \
  -e ONION_PORT=example.com:80 \
  onion-service
```
