#!/bin/bash

if [ ! "$(ls -A $JTS3_DIR/config/)" ]; then
    echo "=> JTS3 Config volume is empty, copying default files to volume"
    cp -r "$JTS3_DIR/default_config/*" "$JTS3_DIR/config/"
fi

echo "-> Updating user and group id if necessary ..."
if [ "$JTS3_USER" != "3000" ]; then
    usermod -u "$JTS3_USER" jts3servermod
fi
if [ "$JTS3_GROUP" != "3000" ]; then
    groupmod -g "$JTS3_GROUP" jts3servermod
fi

echo "-> Correcting mount point permissions ..."
chown "$JTS3_USER":"$JTS3_GROUP" -R "$JTS3_DIR"
echo "=> Corrected mount point permissions."

cd "$JTS3_DIR" || exit 1
echo "=> Starting JTS3ServerMod by Stefan1200 (https://www.stefan1200.de) ..."
exec gosu "$JTS3_USER":"$JTS3_GROUP" java "$JTS3_JAVA_ARGS" -jar "$JTS3_DIR/JTS3ServerMod.jar"
