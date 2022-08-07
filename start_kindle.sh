#!/usr/bin/env bash

xhost +si:localuser:#2000
docker run --rm -u 2000:2000 -e DISPLAY=${DISPLAY} -v "/tmp/.X11-unix/:/tmp/.X11-unix:rw" -v winehome:/home/wineuser --ipc host kindle_img /bin/bash -c "wine '/home/wineuser/.wine/dosdevices/c:/Program Files (x86)/Amazon/Kindle/Kindle.exe'"
xhost -si:localuser:#2000
