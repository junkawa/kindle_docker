FROM ubuntu:22.04

RUN apt update \
    && apt install -y --no-install-recommends wget ca-certificates \
    && dpkg --add-architecture i386 \
    && wget -nc -O /usr/share/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key \
    && wget -nc -P /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources \
    && apt update \
    && apt install -y --install-recommends winehq-devel \
    && apt install -y --no-install-recommends winetricks \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd -g 2000 wineuser \
    && useradd -m -u 2000 -g 2000 -s /bin/bash wineuser

USER wineuser
WORKDIR /home/wineuser

RUN mkdir -p ~/.cache/wine \
    && mono_version=$(iconv -cfutf16 /opt/wine-devel/lib64/wine/x86_64-windows/appwiz.cpl 2>/dev/null | grep -Pao '(?<=wine-mono-).+(?=-x86\.msi)') \
    && gecko_version=$(iconv -cfutf16 /opt/wine-devel/lib64/wine/x86_64-windows/appwiz.cpl 2>/dev/null | grep -Pao '(?<=wine-gecko-).+(?=-x86_64\.msi)') \
    && wget -nc https://dl.winehq.org/wine/wine-mono/$mono_version/wine-mono-$mono_version-x86.msi https://dl.winehq.org/wine/wine-gecko/$gecko_version/wine-gecko-$gecko_version-x86.msi -P ~/.cache/wine/ \
    && mkdir -p ~/.wine/drive_c/users/wineuser/AppData/Local/Amazon/Kindle \
    && wget -nc --trust-server-names http://www.amazon.co.jp/kindlepcdownload
