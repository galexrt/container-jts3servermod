# docker-jts3servermod
JTS3ServerMod by Stefan1200 (see [here](https://www.stefan1200.de/forum/index.php?topic=2.0))

## Summary
* Image based on java:8-jre with the latest version of JTS3ServerMod
* You can inject your config into the container
  * `/jts3servermod/config`
  
## Usage
### Permissions
The default UID of the user which is used in the container is 3000.
So if you mount a directory from your host you have to set the permission to the user with the UID of 3000.
If you experience problems with JTS3ServerMod starting, change the permissions of your config directory accordingly:
```
chmod 755 -R YOUR_CONFIG_DIRECTORY
chown -R 3000:3000 YOUR_CONFIG_DIRECTORY
```

### Mount host directory
```
docker run --name sinusbot -d -v /data/jts3servermod:/jts3servermod/config -p 8087:8087 galexrt/sinusbot:latest
```

### SELinux
If your host uses SELinux it may be necessary to use the **:z** option:
```
docker run --name sinusbot -d -v /data/jts3servermod:/jts3servermod/config:z -p 8087:8087 galexrt/sinusbot:latest
```
