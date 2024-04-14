FROM docker.io/library/caddy:builder AS builder

# rfc2136@master is specified due to build issue: https://github.com/caddy-dns/rfc2136/issues/2
RUN xcaddy build \
    --with github.com/caddy-dns/rfc2136  \
    --with github.com/caddy-dns/cloudflare

FROM scratch
COPY --from=builder /usr/bin/caddy .

FROM caddy:latest

COPY --from=builder /usr/bin/caddy /usr/bin/caddy