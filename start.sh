#!/bin/bash

mkdir -p /opt/QQ/resources/app/LiteLoader/plugins/LLOneBot
# 安装 LiteLoader
if [ ! -f "/opt/QQ/resources/app/LiteLoader/package.json" ]; then
    unzip /tmp/LiteLoaderQQNT.zip -d /opt/QQ/resources/app/LiteLoader/
fi

# 安装 chronocat-api
if [ ! -f "/opt/QQ/resources/app/LiteLoader/plugins/LiteLoaderQQNT-Plugin-Chronocat-Engine-Chronocat-Api/manifest.json" ]; then
    unzip /tmp/chronocat-llqqnt-engine-chronocat-api-v0.2.5.zip -d /opt/QQ/resources/app/LiteLoader/plugins/
fi

# 安装 chronocat-event
if [ ! -f "/opt/QQ/resources/app/LiteLoader/plugins/LiteLoaderQQNT-Plugin-Chronocat-Engine-Chronocat-Event/manifest.json" ]; then
    unzip /tmp/chronocat-llqqnt-engine-chronocat-event-v0.2.5.zip -d /opt/QQ/resources/app/LiteLoader/plugins/
fi

# 安装 poke
if [ ! -f "/opt/QQ/resources/app/LiteLoader/plugins/LiteLoaderQQNT-Plugin-Chronocat-Engine-Poke-master/manifest.json" ]; then
    unzip /tmp/chronocat-llqqnt-engine-poke-v0.2.5.zip -d /opt/QQ/resources/app/LiteLoader/plugins/
fi

# 安装 chronocat
if [ ! -f "/opt/QQ/resources/app/LiteLoader/plugins/LiteLoaderQQNT-Plugin-Chronocat/manifest.json" ]; then
    unzip /tmp/chronocat-llqqnt-v0.2.5.zip -d /opt/QQ/resources/app/LiteLoader/plugins/
fi

chmod 777 /tmp &
rm -rf /run/dbus/pid &
rm /tmp/.X1-lock &
mkdir -p /var/run/dbus &
dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address &
Xvfb :1 -screen 0 1080x760x16 &
export DISPLAY=:1
fluxbox & 
x11vnc -display :1 -noxrecord -noxfixes -noxdamage -forever -rfbauth ~/.vnc/passwd &
nohup /opt/noVNC/utils/novnc_proxy --vnc localhost:5900 --listen 6081 --file-only &
x11vnc -storepasswd $VNC_PASSWD ~/.vnc/passwd
# --disable-gpu 不加入
exec supervisord