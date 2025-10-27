ARG CADDY_VERSION
ARG CADDY_MODULES

RUN echo "Building Caddy version: ${CADDY_VERSION}" && \
    echo "With modules: ${CADDY_MODULES}"

FROM caddy:${CADDY_VERSION}-builder AS builder

RUN xcaddy build --with github.com/caddy-dns/tencentcloud

FROM caddy:${CADDY_VERSION}

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
