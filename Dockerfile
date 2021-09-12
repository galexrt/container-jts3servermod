FROM openjdk:8-jre-buster

LABEL maintainer="Alexander Trost <galexrt@googlemail.com>"

ARG JTS3_USER="3000"
ARG JTS3_GROUP="3000"

ENV TINI_VERSION="v0.19.0" \
    JTS3_DIR="/jts3servermod" \
    JTS3_JAVA_ARGS="-Xmx256M" \
    TINI_ARCH="amd64" \
    ARCH=""

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-${TINI_ARCH} /tini-${TINI_ARCH}
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-${TINI_ARCH}.sha256sum /tini-${TINI_ARCH}.sha256sum

RUN [ ! -z "$ARCH" ] || ARCH="$(dpkg --print-architecture)" && \
    groupadd -g "$JTS3_GROUP" -r jts3servermod && \
    useradd -u "$JTS3_USER" -r -g "$JTS3_GROUP" -d "$JTS3_DIR" jts3servermod && \
    apt-get -q update && \
    apt-get -q upgrade -y && \
    cd / && \
    echo "$(cat /tini-${TINI_ARCH}.sha256sum)" | sha256sum -c && \
    mv /tini-${TINI_ARCH} /tini && \
    chmod 755 /tini && \
    apt-get -q install unzip -y && \
    cd /tmp && \
    wget -q -O "/tmp/jts3servermod.zip" "http://www.stefan1200.de/dlrequest.php?file=jts3servermod&type=.zip" && \
    unzip "/tmp/jts3servermod.zip" && \
    rm -f "/tmp/jts3servermod.zip" && \
    mv "/tmp/JTS3ServerMod" "$JTS3_DIR" && \
    touch "$JTS3_DIR/JTS3ServerMod_InstanceManager.log" && \
    chown -R jts3servermod:jts3servermod "$JTS3_DIR" && \
    rm -rf "$JTS3_DIR/tools" "$JTS3_DIR/readme*" "$JTS3_DIR/documents" "$JTS3_DIR/changelog.txt" && \
    cp -arf "$JTS3_DIR/config" "$JTS3_DIR/default_config" && \
    apt-get -qq clean && \
    apt-get -qq autoremove --purge -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER "$JTS3_USER"

WORKDIR "$JTS3_DIR"

VOLUME ["$JTS3_DIR/config"]

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/tini", "--"]

CMD ["/entrypoint.sh"]
