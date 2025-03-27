FROM docker.io/bitnami/minideb:bookworm
LABEL maintainer "Dan Gibbs <dev@dangibbs.co.uk>"

ARG lighthouse_version=latest
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections; \
    apt-get update -qq && \
    apt-get install -y --no-install-recommends \
        chromium \
        chromium-sandbox \
        ca-certificates \
        curl \
        git \
        fonts-freefont-ttf \
        fonts-liberation \
        jq; \
    curl -L https://deb.nodesource.com/setup_20.x | bash -; \
    cat /etc/apt/sources.list.d/nodesource.list; \
    apt-get install -y --no-install-recommends \
        nodejs; \
    npm update -g npm; \
    npm i -g --omit=dev lighthouse@${lighthouse_version}; \
    apt-get purge -y curl; \
    apt-get autoremove -y; \
    apt-get clean && apt-get autoclean -y && \
    rm -rf \
        /var/lib/apt/lists/* \
        /var/cache/debconf/*-old \
        /var/lib/dpkg/*-old/ \
        /usr/share/man/* \
        /usr/share/doc/**/*.gz \
        /usr/share/locale/ \
        && \
    useradd --create-home --shell /bin/sh -G audio,video lighthouse; \
    mkdir -p /home/lighthouse/reports; \
    chown -R lighthouse:lighthouse /home/lighthouse/*

USER lighthouse
WORKDIR /home/lighthouse/reports/

ENTRYPOINT ["lighthouse", \
    "--chrome-flags=\"--headless\"", \
    "--view=false", \
    "--quiet" \
]
