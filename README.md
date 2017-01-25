# docker-jts3servermod
[![](https://images.microbadger.com/badges/image/galexrt/jts3servermod.svg)](https://microbadger.com/images/galexrt/jts3servermod "Get your own image badge on microbadger.com")

[![Docker Repository on Quay.io](https://quay.io/repository/galexrt/jts3servermod/status "Docker Repository on Quay.io")](https://quay.io/repository/galexrt/zulip)

Image available from:
* [**Quay.io**](https://quay.io/repository/galexrt/jts3servermod)
* [**Docker Hub**](https://hub.docker.com/r/galexrt/jts3servermod)

JTS3ServerMod by Stefan1200 (see [here](https://www.stefan1200.de/forum/index.php?topic=2.0))

## Summary
* Image based on java:8-jre with the latest version of JTS3ServerMod
* You can inject your config into the container by using the directory (on first start the default configs will be copied to the directory):
  * `/jts3servermod/config`

## Usage
### Updating the image
Run the below command, to update the image to the latest version:
Quay.io Docker Image:
```
docker pull quay.io/galexrt/jts3servermod:latest
```
Or for the Docker Hub image:
```
docker pull galexrt/jts3servermod:latest
```

### Permissions
The default UID of the user which is used in the container is 3000.
So if you mount a directory from your host you have to set the permission to the user with the UID of 3000.
```
useradd -u 3000 sinusbot
mkdir -p /opt/docker/jts3servermod/config
chown -R sinusbot:sinusbot /opt/docker/jts3servermod/config
```
Or if you dont want to create an user just use
```
mkdir -p /opt/docker/jts3servermod/config
chown -R 3000:3000 /opt/docker/sinusbot
```
Or just use the built-in variables to the run command to change the user and/or group id to an existing or non existing user:
The variables need to be an user/group id (not the username):
```
JTS3_USER=3000
JTS3_GROUP=3000
```

### Mount host directory
```
docker run \
    --name sinusbot \
    -d \
    -v /opt/docker/jts3servermod:/jts3servermod/config \
    -p 8087:8087 \
    quay.io/galexrt/sinusbot:latest
```

### SELinux
If your host uses SELinux it may be necessary to use the **:z** option:
```
docker run \
    --name sinusbot \
    -d \
    -v /opt/docker/jts3servermod/config:/jts3servermod/config:z \
    -p 8087:8087 \
    quay.io/galexrt/sinusbot:latest
```
