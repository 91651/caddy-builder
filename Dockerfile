ARG RUNNER_VERSION="qqq"
ARG RUNNER_ARCH="x64"

FROM caddy:2.10.2-builder AS builder

RUN echo "Building Caddy version: ${RUNNER_VERSION}" && echo "With modules: ${RUNNER_ARCH}"

RUN xcaddy build --with ${CADDY_MODULES} --output /usr/bin/caddy

FROM caddy:${CADDY_VERSION}

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
