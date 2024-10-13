FROM debian:bookworm-slim

WORKDIR /src

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        apt-transport-https ca-certificates curl gnupg sudo \
    && rm -rf /var/lib/apt/lists/*

RUN echo "deb [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org bookworm main" > /etc/apt/sources.list.d/tor.list && \
    curl -sSf https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --dearmor > /usr/share/keyrings/tor-archive-keyring.gpg && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    tor deb.torproject.org-keyring \
    && rm -rf /var/lib/apt/lists/*

COPY start.sh .

CMD ["/src/start.sh"]
