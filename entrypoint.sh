#!/bin/bash

echo "Correcting mount point permissions ..."
chown "$JTS3_USER":"$JTS3_GROUP" -R "$JTS3_DIR"

if [ ! "$(ls -A $JTS3_DIR/config/)" ]; then
    echo "JTS3 Config volume is empty, copying default files to volume"
    cp -r "$JTS3_DIR/default_config" "$JTS3_DIR/config"
fi

echo "\nStarting JTS3ServerMod ..."
sudo -u "$JTS3_USER" java "$JTS3_JAVA_ARGS" -jar "$JTS3_DIR/JTS3ServerMod.jar"
