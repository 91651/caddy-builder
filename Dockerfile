ARG RUNNER_VERSION="qqq"
ARG RUNNER_ARCH="x64"
ARG CADDY_VERSION
ARG CADDY_MODULES

FROM caddy:2.10.2-builder AS builder

RUN echo "Building Caddy version: ${RUNNER_ARCH}" && \
    echo "With modules: ${RUNNER_VERSION}"
RUN echo "Building Caddy version: ${CADDY_VERSION}" && \
    echo "With modules: ${CADDY_MODULES}"

RUN xcaddy build --with github.com/caddy-dns/tencentcloud

FROM caddy:${CADDY_VERSION}

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
