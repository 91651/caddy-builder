ARG CADDY_VERSION

FROM caddy:${CADDY_VERSION}-builder AS builder

ARG CADDY_MODULES

RUN echo "Building Caddy version: ${CADDY_VERSION}" && \
    echo "With modules: ${CADDY_MODULES}"

RUN set -eux; \
    if [ -z "${CADDY_VERSION}" ]; then \
        echo "❌ Error: CADDY_VERSION is not set!"; \
        exit 1; \
    fi; \
    echo "✅ Building Caddy version: ${CADDY_VERSION}"; \
    \
    MOD_ARGS=""; \
    if [ -n "${CADDY_MODULES}" ]; then \
        for m in $(echo "${CADDY_MODULES}" | tr ',' ' '); do \
            MOD_ARGS="${MOD_ARGS} --with ${m}"; \
        done; \
        echo "Using modules: ${CADDY_MODULES}"; \
    else \
        echo "⚠️  No modules specified, building pure Caddy"; \
    fi; \
    \
    xcaddy build ${MOD_ARGS}

FROM caddy:${CADDY_VERSION}

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
