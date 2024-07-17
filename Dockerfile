FROM debian:bookworm-slim
WORKDIR /tmp

# Required environment variables
ENV APP_ONION_HOSTNAME="changeme"
ENV APP_ONION_PUBLIC_KEY_B64="changeme"
ENV APP_ONION_SECRET_KEY_B64="changeme"
ENV APP_ONION_PORT="changeme"
ENV STATIC_ONION_HOSTNAME="changeme"
ENV STATIC_ONION_PUBLIC_KEY_B64="changeme"
ENV STATIC_ONION_SECRET_KEY_B64="changeme"
ENV STATIC_ONION_PORT="changeme"

# Install updates
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    apt-transport-https ca-certificates curl gnupg2 sudo \
    && rm -rf /var/lib/apt/lists/*

# Install tor repository
RUN echo "deb [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org bookworm main" > /etc/apt/sources.list.d/tor.list
RUN curl -o /tmp/tor-archive-keyring https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc
RUN gpg --dearmor /tmp/tor-archive-keyring
RUN cp /tmp/tor-archive-keyring.gpg /usr/share/keyrings/tor-archive-keyring.gpg

# Install tor
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    tor deb.torproject.org-keyring \
    && rm -rf /var/lib/apt/lists/*

# Copy the entrypoint script into the image
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the script as the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
