FROM debian:trixie-slim

LABEL maintainer="Steven Tan <git@sktan.com>"
LABEL description="Base image for all SteamCMD game servers"

ENV HOME=/home/gameserver
ENV STEAMCMD_DIR="/steamcmd"
ENV GAMESERVER_DIR="/gameserver"

# Initial User and Dirs Setup
RUN useradd -m -d /home/gameserver gameserver && \
    mkdir -p $GAMESERVER_DIR && \
    mkdir -p $STEAMCMD_DIR && \
    chown gameserver:gameserver $HOME -R && \
    chown gameserver:gameserver $GAMESERVER_DIR && \
    chown gameserver:gameserver $STEAMCMD_DIR

# Initial Dependencies Setup
# libgcc.x86_64 glibc.x86_64 libgcc.i686 glibc.i686 libc6
RUN apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests \
        curl tar gzip zip unzip ca-certificates lib32stdc++6 lib32gcc-s1 && \
    apt-get clean autoclean && apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

USER gameserver
WORKDIR $STEAMCMD_DIR

# SteamCMD Setup
RUN curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz && \
    ./steamcmd.sh +quit && \
    mkdir -p $HOME/.steam/sdk64 && ln -s $STEAMCMD_DIR/linux64/steamclient.so $HOME/.steam/sdk64/steamclient.so && \
    mkdir -p $HOME/.steam/sdk32 && ln -s $STEAMCMD_DIR/linux32/steamclient.so $HOME/.steam/sdk32/steamclient.so

USER root
# Symlink again for other dedicated servers
RUN ln -s $STEAMCMD_DIR/linux64/steamclient.so /usr/lib/x86_64-linux-gnu/steamclient.so
