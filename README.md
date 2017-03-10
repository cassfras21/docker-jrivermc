# cassfras21/jrivermc

![](https://www.jriver.com/images/header/logo.png)

[JRiver Media Center](https://www.jriver.com/) is a media manager and player providing high quality playback of audio and video. Its scope includes almost all formats of audio, video, and images. Media Center can also record television and manage documents. It also provides a media network to stream your media across multiple devices.

### Usage
* Headless server only (doesn't support audio/video local rendering) 
* DLNA is supported (server and controller only)
* Easy data backup and restoration

### Options
* VNCPASS - VNC password is by default 'jriver' (optional)
* UPDATE - If set to 'yes', JRiver will be updating at the container startup  (optional)

You need to replace everything between <> with your own setup settings.

### JRiver Media Center 22

You need to run at least one app container. Data container is optional but recommended.

## Data container (optional)

```
docker run \
--name=jrivermc22--data-container \
cassfras21/jrivermc \
echo "Data-only container for JRiver Media Center 22"
```

## App container (JRiver latest version)

```
docker run -d \
--name=jrivermc22-latest \
--net=host \
--pid=host \
-e UPDATE=yes \
-e VNCPASS=<vnc_password> \
--volumes-from jrivermc22--data-container \
-v <local_media_volume>:/mnt/media \
cassfras21/jrivermc:latest
```

## App container (JRiver stable version)

```
docker run -d \
--name=jrivermc22-stable \
--net=host \
--pid=host \
-e UPDATE=yes \
-e VNCPASS=<vnc_password> \
--volumes-from jrivermc22--data-container \
-v <local_media_volume>:/mnt/media \
cassfras21/jrivermc:stable
```

### To backup your data...

```
docker run --rm \
--volumes-from jrivermc22--data-container \
-v <local_backup_folder>:/backup \
cassfras21/jrivermc \
tar cvf /backup/backup_jrivermc22.tar --exclude 'home/jriver/.jriver/Media Center 22/Temp' /home/jriver/.jriver
```

### To restore you data...

```
docker run --rm \
--volumes-from jrivermc22--data-container \
-v <local_backup_folder>:/backup \
cassfras21/jrivermc \
tar xvf /backup/backup_jrivermc22.tar
```
