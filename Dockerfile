FROM docker.io/library/caddy:builder AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/rfc2136  \
    --with github.com/caddy-dns/cloudflare

FROM scratch
COPY --from=builder /usr/bin/caddy .

FROM caddy:latest

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
