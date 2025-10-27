ARG CADDY_VERSION="2.10.2"
ARG CADDY_MODULES="github.com/caddy-dns/tencentcloud"

FROM caddy:2.10.2-builder AS builder

RUN echo "Building Caddy version: ${CADDY_VERSION}" && echo "With modules: ${CADDY_MODULES}"

RUN xcaddy build --with ${CADDY_MODULES} --output /usr/bin/caddy

FROM caddy:${CADDY_VERSION}

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
