ARG CADDY_VERSION
ARG CADDY_MODULES

RUN echo "Building Caddy version: ${CADDY_VERSION}" && \
    echo "With modules: ${CADDY_MODULES}"

FROM caddy:${CADDY_VERSION}-builder AS builder

RUN set -ex; \
    MOD_ARGS=""; \
    for m in $(echo ${CADDY_MODULES} | tr ',' ' '); do \
        MOD_ARGS="${MOD_ARGS} --with ${m}"; \
    done; \
    echo "Running: xcaddy build v${CADDY_VERSION} ${MOD_ARGS}"; \
    xcaddy build v${CADDY_VERSION} ${MOD_ARGS}

FROM caddy:${CADDY_VERSION}

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
