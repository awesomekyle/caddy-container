FROM docker.io/library/caddy:2.7-builder AS builder

# rfc2136@master is specified due to build issue: https://github.com/caddy-dns/rfc2136/issues/2
RUN xcaddy build \
    --with github.com/caddy-dns/rfc2136@master \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/pberkel/caddy-storage-redis

FROM scratch
COPY --from=builder /usr/bin/caddy .
