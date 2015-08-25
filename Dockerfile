FROM dockerfile/java:oracle-java8

ENV JTS3_USER="jts3" JTS3_GROUP="jts3" JTS3_DIR="/jts3servermode" JTS3_JAVA_ARGS="-Xmx256M"
ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    groupadd -g 3000 -r "$JTS3_GROUP" && \
    useradd -u 3000 -r -g "$JTS3_USER" -d "$JTS3_DIR" "$JTS3_USER" && \
    mkdir -p "$JTS3_DIR" && \
    wget -qO- "http://www.stefan1200.de/dlrequest.php?file=jts3servermod&type=.zip" | \
    bsdtar -xvf- -C "$JTS3_DIR" && \
    cp -r "$JTS3_DIR/config" "$JTS3_DIR/default_config"
WORKDIR "$JTS3_DIR"
VOLUME "$JTS3_DIR/config"
