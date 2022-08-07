#!/usr/bin/env bash

shopt -s expand_aliases

alias docker_kindle='docker run -it --rm -u 2000:2000 -e DISPLAY=${DISPLAY} -v "/tmp/.X11-unix/:/tmp/.X11-unix:rw" -v winehome:/home/wineuser --ipc host kindle_img'

xhost +si:localuser:#2000
docker_kindle winetricks -q cjkfonts vcrun2013
docker_kindle /bin/bash -c 'cd && wine KindleForPC-installer-*.exe'
docker_kindle /bin/bash -c "wine '/home/wineuser/.wine/dosdevices/c:/Program Files (x86)/Amazon/Kindle/Kindle.exe'"
xhost -si:localuser:#2000
