FROM java:8-jre

ENV JTS3_USER="3000" \
    JTS3_GROUP="3000" \
    JTS3_DIR="/jts3servermod" \
    JTS3_JAVA_ARGS="-Xmx256M"

RUN groupadd -g "$JTS3_GROUP" -r jts3servermod && \
    useradd -u "$JTS3_USER" -r -g "$JTS3_GROUP" -d "$JTS3_DIR" jts3servermod && \
    apt-get -q update && \
    apt-get -q upgrade -y && \
    apt-get -q install unzip sudo -y

RUN wget -q -O /jts3servermod.zip "http://www.stefan1200.de/dlrequest.php?file=jts3servermod&type=.zip" && \
    cd / && \
    unzip jts3servermod.zip && \
    mv -f "/JTS3ServerMod" "$JTS3_DIR" && \
    chown -R jts3servermod:jts3servermod "$JTS3_DIR" && \
    rm -rf /jts3servermod.zip "/JTS3ServerMod" "$JTS3_DIR/tools" "$JTS3_DIR/readme*" "$JTS3_DIR/documents" "$JTS3_DIR/changelog.txt" && \
    cp -rf "$JTS3_DIR/config" "$JTS3_DIR/default_config" && \
    apt-get -qq clean && \
    apt-get -qq autoremove --purge -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD entrypoint.sh /entrypoint.sh

VOLUME ["$JTS3_DIR/config"]
ENTRYPOINT "/entrypoint.sh"
