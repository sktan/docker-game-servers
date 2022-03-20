FROM amazonlinux:latest
MAINTAINER Steven Tan <git@sktan.com>

ARG L4D2_WORKSHOP_IDS=empty

ENV HOME /home/steam
ENV SERVER $HOME/l4d2
ENV STEAMCMD $HOME/steamcmd

ENV L4D2_MAP="c1m1_hotel" \
    L4D2_GAMEMODE="coop" \
    L4D2_RCON="MyRconPassword" \
    L4D2_HOSTNAME="My L4D2 Server" \
    L4D2_FRIENDLYFIRE="1" \
    L4D2_PLAYERS=4 \
    L4D2_DIFFICULTY="Hard" \
    L4D2_SERVER_PASSWORD="nopasswd" \
    L4D2_WORKSHOP_IDS=${L4D2_WORKSHOP_IDS}

RUN yum install -y curl tar shadow-utils libgcc.x86_64 glibc.x86_64 libgcc.i686 glibc.i686 libc6 gzip git python3
RUN useradd steam && mkdir -p $SERVER && mkdir -p $STEAMCMD && chown steam:steam $HOME -R

USER steam

ADD install.txt $STEAMCMD/install.txt
RUN df -h && cd $STEAMCMD && curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz && \
    cd $STEAMCMD && ./steamcmd.sh +runscript install.txt && \
    mkdir -p $SERVER/left4dead2/addons/workshop

WORKDIR ${SERVER}

ADD --chown=steam:steam server.sh $SERVER/server.sh
ADD --chown=steam:steam configs/* $SERVER/left4dead2/cfg/
ADD --chown=steam:steam workshop.py $HOME/workshop.py

RUN mkdir -p $HOME/mods/{sourcemod_base,zonemod} && \
    # Basic Sourcemod
    curl -s https://sm.alliedmods.net/smdrop/1.10/sourcemod-1.10.0-git6529-linux.tar.gz | tar -vxz -C $HOME/mods/sourcemod_base && \
    curl -s https://mms.alliedmods.net/mmsdrop/1.11/mmsource-1.11.0-git1145-linux.tar.gz | tar -xzv -C $HOME/mods/sourcemod_base && \
    # Zonemod
    git clone https://github.com/SirPlease/L4D2-Competitive-Rework.git $HOME/mods/zonemod && \
    # Install workshop collections
    [ "$L4D2_WORKSHOP_IDS" != "empty" ] && python3 $HOME/workshop.py -o "$SERVER/left4dead2/addons/workshop" $L4D2_WORKSHOP_IDS

RUN chmod 700 $SERVER/server.sh

EXPOSE 27015/udp
EXPOSE 27015/tcp

ENTRYPOINT [ "./server.sh" ]
