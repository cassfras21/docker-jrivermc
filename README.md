# cassfras21/jrivermc:21-latest

![](https://www.jriver.com/images/header/logo.png)

[JRiver Media Center](https://www.jriver.com/) is a media manager and player providing high quality playback of audio and video. Its scope includes almost all formats of audio, video, and images. Media Center can also record television and manage documents. It also provides a media network to stream your media across multiple devices.

### Usage
* Headless server only
* DLNA is supported
* Easy data backup and restoration

### Options
* ENV_VNCPASS - VNC password is by default 'jriver' (optional)
* ENV_UPDATE - If set to 'yes', JRiver will be updating at the container startup  (optional)

You need to replace everything between <> with your own setup settings.

# JRiver Media Center 21

```
docker pull cassfras21/jrivermc:21-latest
```

### Data container

```
docker run \
--name=jrivermc21--data-container \
cassfras21/jrivermc:21-latest \
echo "Data-only container for JRiver Media Center 21"
```

### App container (library only)

```
docker run -d \
--name=jrivermc21 \
-e ENV_UPDATE=yes \
-e ENV_VNCPASS=<vnc_password> \
-h <hostname> \
-p 5900:5900 \
-p 52199:52199 \
--volumes-from jrivermc21--data-container \
-v <local_media_volume>:/mnt/media \
cassfras21/jrivermc:21-latest
```

### App container (DLNA)

```
docker run -d \
--name=jrivermc21 \
--net=host \
--pid=host \
-e ENV_UPDATE=yes \
-e ENV_VNCPASS=<vnc_password> \
-p 5900:5900 \
-p 52100:52100 \
-p 52101:52101 \
-p 52199:52199 \
-p 1900:1900/udp \
--volumes-from jrivermc21--data-container \
-v <local_media_volume>:/mnt/media \
cassfras21/jrivermc:21-latest
```

### Data backup...

```
docker run --rm \
--volumes-from jrivermc21--data-container \
-v <local_backup_folder>:/backup \
cassfras21/jrivermc:21-latest \
tar cvf /backup/backup_jrivermc21.tar --exclude 'home/jriver/.jriver/Media Center 21/Temp' /home/jriver/.jriver
```

### Data restore...

```
docker run --rm \
--volumes-from jrivermc21--data-container \
-v <local_backup_folder>:/backup \
cassfras21/jrivermc:21-latest \
tar xvf /backup/backup_jrivermc21.tar
```
