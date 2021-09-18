FROM openjdk:8-jre-buster

ARG BUILD_DATE="N/A"
ARG REVISION="N/A"

ARG JTS3_USER="3000"
ARG JTS3_GROUP="3000"
ARG TINI_ARCH="amd64"
ARG ARCH=""

LABEL org.opencontainers.image.authors="Alexander Trost <galexrt@googlemail.com>" \
    org.opencontainers.image.created="${BUILD_DATE}" \
    org.opencontainers.image.title="galexrt/container-jts3servermod" \
    org.opencontainers.image.description="[JTS3ServerMod](https://jts3servermod.de/) by Stefan1200 as a Container Image." \
    org.opencontainers.image.documentation="https://github.com/galexrt/container-jts3servermod/blob/main/README.md" \
    org.opencontainers.image.url="https://github.com/galexrt/container-jts3servermod" \
    org.opencontainers.image.source="https://github.com/galexrt/container-jts3servermod" \
    org.opencontainers.image.revision="${REVISION}" \
    org.opencontainers.image.vendor="galexrt" \
    org.opencontainers.image.version="N/A"

ENV TINI_VERSION="v0.19.0" \
    JTS3_DIR="/jts3servermod" \
    JTS3_USER="${JTS3_USER}" \
    JTS3_GROUP="${JTS3_GROUP}" \
    JTS3_JAVA_ARGS="-Xmx256M" \
    TINI_ARCH="${TINI_ARCH}" \
    ARCH="${ARCH}"

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-${TINI_ARCH} /tini-${TINI_ARCH}
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-${TINI_ARCH}.sha256sum /tini-${TINI_ARCH}.sha256sum

RUN [ ! -z "$ARCH" ] || ARCH="$(dpkg --print-architecture)" && \
    groupadd -g "${JTS3_GROUP}" -r jts3servermod && \
    useradd -u "${JTS3_USER}" -r -g "${JTS3_GROUP}" -d "${JTS3_DIR}" jts3servermod && \
    apt-get -q update && \
    apt-get -q upgrade -y && \
    cd / && \
    echo "$(cat /tini-${TINI_ARCH}.sha256sum)" | sha256sum -c && \
    mv "/tini-${TINI_ARCH}" /tini && \
    chmod 755 /tini && \
    apt-get -q install unzip -y && \
    cd /tmp && \
    wget -q -O "/tmp/jts3servermod.zip" "http://www.stefan1200.de/dlrequest.php?file=jts3servermod&type=.zip" && \
    unzip "/tmp/jts3servermod.zip" && \
    rm -f "/tmp/jts3servermod.zip" && \
    mv "/tmp/JTS3ServerMod" "${JTS3_DIR}" && \
    touch "${JTS3_DIR}/JTS3ServerMod_InstanceManager.log" && \
    chown -R jts3servermod:jts3servermod "${JTS3_DIR}" && \
    rm -rf "${JTS3_DIR}/tools" "${JTS3_DIR}/readme*" "${JTS3_DIR}/documents" "${JTS3_DIR}/changelog.txt" && \
    cp -arf "${JTS3_DIR}/config" "${JTS3_DIR}/default_config" && \
    apt-get -qq clean && \
    apt-get -qq autoremove --purge -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY entrypoint.sh /entrypoint.sh

RUN chmod 755 /entrypoint.sh

USER "$JTS3_USER"

WORKDIR "${JTS3_DIR}"

VOLUME ["${JTS3_DIR}/config"]

ENTRYPOINT ["/tini", "--"]

CMD ["/entrypoint.sh"]
