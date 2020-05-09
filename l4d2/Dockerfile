FROM amazonlinux:latest
MAINTAINER Steven Tan <git@sktan.com>

ENV HOME /home/steam
ENV SERVER $HOME/l4d2
ENV STEAMCMD $HOME/steamcmd

ENV L4D2_MAP="c1m1_hotel" \
    L4D2_GAMEMODE="coop" \
    L4D2_RCON="MyRconPassword" \
    L4D2_PASSWORD="MyJoinPassword" \
    L4D2_HOSTNAME="My L4D2 Server" \
    L4D2_FRIENDLYFIRE="1" \
    L4D2_PLAYERS=4 \
    L4D2_DIFFICULTY="Hard" \
    L4D2_IP="0.0.0.0"

RUN yum install -y curl tar shadow-utils libgcc.i686 glibc.i686 libc6 gzip
RUN useradd steam && mkdir -p $SERVER && mkdir -p $STEAMCMD && chown steam:steam $HOME -R

USER steam

ADD install.txt $STEAMCMD/install.txt
RUN df -h && cd $STEAMCMD && curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz && \
    cd $STEAMCMD && ./steamcmd.sh +runscript install.txt

WORKDIR ${SERVER}

ADD --chown=steam:steam server.sh $SERVER/server.sh
ADD --chown=steam:steam configs/* $SERVER/left4dead2/cfg/

RUN chmod 700 $SERVER/server.sh

EXPOSE 27015/udp

ENTRYPOINT [ "./server.sh" ]
