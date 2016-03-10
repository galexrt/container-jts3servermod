#!/bin/bash

if [ ! "$(ls -A $JTS3_DIR/config/)" ]; then
    echo "JTS3 Config volume is empty, copying default files to volume"
    cp -r "$JTS3_DIR/default_config/*" "$JTS3_DIR/config/"
fi

echo "Correcting mount point permissions ..."
chown "$JTS3_USER":"$JTS3_GROUP" -R "$JTS3_DIR"

echo "\nStarting JTS3ServerMod ..."
cd "$JTS3_DIR" || exit 1
exec sudo -u "$JTS3_USER" java "$JTS3_JAVA_ARGS" -jar "$JTS3_DIR/JTS3ServerMod.jar"
