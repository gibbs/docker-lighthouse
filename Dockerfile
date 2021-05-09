FROM docker.io/bitnami/minideb:buster
LABEL maintainer "Dan Gibbs <dev@dangibbs.co.uk>"

ARG DEBIAN_FRONTEND=noninteractive

ENV OS_ARCH="amd64" \
    OS_FAMILY="debian" \
    OS_CODENAME="buster" \
    OS_VERSION="10" \
    OS_NAME="linux"

# hadolint ignore=DL3008,DL4006
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
        chromium \
        chromium-sandbox \
        ca-certificates \
        curl \
        fonts-freefont-ttf \
        fonts-liberation && \
    curl -L https://deb.nodesource.com/setup_14.x | bash - && \
    cat /etc/apt/sources.list.d/nodesource.list && \
    apt-get install -y --no-install-recommends \
        nodejs && \
    npm i -g --production lighthouse && \
    apt-get purge -y curl && \
    apt-get autoremove -y && \
    apt-get clean && apt-get autoclean -y && \
    rm -rf \
        /var/lib/apt/lists/* \
        /var/cache/debconf/*-old \
        /var/lib/dpkg/*-old/ \
        /usr/share/man/* \
        /usr/share/doc/**/*.gz \
        /usr/share/locale/ \
        && \
    useradd --create-home --shell /bin/sh -G audio,video lighthouse && \
    mkdir -p /home/lighthouse/reports && \
    chown -R lighthouse:lighthouse /home/lighthouse/*

USER lighthouse
WORKDIR /home/lighthouse/reports/

ENTRYPOINT ["lighthouse", \
    "--chrome-flags=\"--headless\"", \
    "--view=false", \
    "--quiet" \
]
