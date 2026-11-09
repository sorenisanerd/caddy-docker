# caddy-docker

Caddy built with the Google Cloud DNS plugin, so it can solve ACME DNS-01
challenges for certificates it needs to obtain before anything is listening.

```dockerfile
FROM caddy:2-builder AS builder
RUN xcaddy build --with github.com/caddy-dns/googleclouddns
FROM caddy:2.11
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
```

The upstream `caddy` image is reused as the runtime so nothing else about it
changes.

## Image

Built and pushed to the GitHub Container Registry by
`.github/workflows/build.yml`:

```
ghcr.io/<owner>/caddy-docker:latest      # default branch
ghcr.io/<owner>/caddy-docker:sha-<sha>   # every push
ghcr.io/<owner>/caddy-docker:1.2.3       # tags matching v1.2.3
```

Pull requests build but do not push.

## Building locally

```sh
docker build -t caddy-docker .
```

The package is created on the first push by the workflow's `GITHUB_TOKEN`. If
the repository is not the one that owns the package, make the package public
(or authenticate) before pulling it elsewhere.
