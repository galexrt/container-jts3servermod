#!/bin/bash

JTS3_LOG="${JTS3_LOG:-JTS3ServerMod_InstanceManager.cfg}"

if [ ! "$(ls -A "$JTS3_DIR/config/")" ]; then
    echo "ENTRYPOINT: JTS3 Config volume is empty, copying default files to volume"
    cp -ar "$JTS3_DIR/default_config/*" "$JTS3_DIR/config/"
fi

cd "$JTS3_DIR" || { echo "ENTRYPOINT: Failed to enter JTS3_DIR ($JTS3_DIR), exiting"; exit 1; }

exec java "$JTS3_JAVA_ARGS" -jar "$JTS3_DIR/JTS3ServerMod.jar" -log "$JTS3_LOG" "$@"
