# container-jts3servermod

[JTS3ServerMod](https://jts3servermod.de/) by Stefan1200 as a Container Image.

Container Image available from:

* [Quay.io](https://quay.io/repository/galexrt/jts3servermod)
* [GHCR.io](https://github.com/users/galexrt/packages/container/package/vlc)

Container Image Tags:

* `main` - Latest build of the `main` branch.
* `YYYYmmdd-HHMMSS-NNN` - Latest build of the application with date of the build.

## Usage

You can inject your config into the container by using the directory (on first start the default configs will be copied to the directory): `/jts3servermod/config`.

### Updating the image

Run the below command, to update the image to the latest version:

Quay.io Docker Image:

```shell
docker pull quay.io/galexrt/jts3servermod:latest
```

Or for the GHCR.io image:

```shell
docker pull ghcr.io/galexrt/jts3servermod:latest
```
### Permissions

The default UID of the user which is used in the container is 3000.
So if you mount a directory from your host you have to set the permission to the user with the UID of 3000.

```shell
mkdir -p /opt/docker/jts3servermod/config
chown -R 3000:3000 /opt/docker/jts3servermod/config
```

```shell
mkdir -p /opt/docker/jts3servermod/config
chown -R 3000:3000 /opt/docker/jts3servermod
```

#### Change UID and GID

To change the UID and GID during build you should set through Docker build args:

```shell
JTS3_USER=3000
JTS3_GROUP=3000
```

### Mount host directory

```shell
docker run \
    --name jts3servermod \
    -d \
    -v /opt/docker/jts3servermod:/jts3servermod/config \
    quay.io/galexrt/jts3servermod:latest
```

### SELinux

If your host uses SELinux it may be necessary to use / add the `:z` option:

```shell
docker run \
    --name jts3servermod \
    -d \
    -v /opt/docker/jts3servermod/config:/jts3servermod/config:z \
    quay.io/galexrt/jts3servermod:latest
```

## Kubernetes + Helm

A Helm Chart is available under the [`charts/`](charts/) directory.
