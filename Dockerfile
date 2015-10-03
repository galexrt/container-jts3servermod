FROM java:8-jre

ENV JTS3_USER="jts3" JTS3_GROUP="jts3" JTS3_DIR="/jts3servermod" JTS3_JAVA_ARGS="-Xmx256M"

ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh && \
    apt-get -qq update && \
    apt-get -qq install bsdtar sudo -y && \
    groupadd -g 3000 -r "$JTS3_GROUP" && \
    useradd -u 3000 -r -g "$JTS3_USER" -d "$JTS3_DIR" "$JTS3_USER" && \
    mkdir -p "$JTS3_DIR" && \
    wget -q -O- "http://www.stefan1200.de/dlrequest.php?file=jts3servermod&type=.zip" | \
    bsdtar -xvf- -C "$JTS3_DIR" && \
    rm -rf "$JTS3_DIR/tools" "$JTS3_DIR/readme*" "$JTS3_DIR/documents" "$JTS3_DIR/changelog.txt" && \
    cp -rf "$JTS3_DIR/config" "$JTS3_DIR/default_config" && \
    apt-get -qq clean && \
    apt-get -qq autoremove --purge -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \

WORKDIR "$JTS3_DIR"
VOLUME "$JTS3_DIR/config"
ENTRYPOINT "/entrypoint.sh"
