FROM caddy:builder AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/googleclouddns \
    --with github.com/caddy-dns/route53 \
    --with github.com/pteich/caddy-tlsconsul \
    --with github.com/42wim/caddy-gitea=github.com/sorenisanerd/caddy-gitea@support-subdirs

FROM caddy:latest

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
