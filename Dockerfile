FROM docker.io/library/caddy:builder AS builder

# rfc2136@master is specified due to issue with 2.8
# https://github.com/caddy-dns/rfc2136/commit/b8df5e8730c9dcd6fce4b483530b96dcd46c0690
RUN xcaddy build \
    --with github.com/caddy-dns/rfc2136  \
    --with github.com/caddy-dns/cloudflare

FROM scratch
COPY --from=builder /usr/bin/caddy .

FROM caddy:latest

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
