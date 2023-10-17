# syntax = docker/dockerfile:1

FROM registry.gitlab.steamos.cloud/steamrt/sniper/platform:latest

ENV HOME /home/steamrt
ENV SERVER $HOME/cs2
ENV STEAMCMD $HOME/steamcmd

ENV CS2_HOSTNAME "My CS2 Server" \
    CS2_RCON_PASSWORD "MyRconPassword123" \
    CS2_JOIN_PASSWORD "" \
    CS2_MAP "de_dust2" \
    CS2_PORT 27015

RUN --mount=type=secret,id=csgoinstall,dst=/home/steamrt/steamcmd/install.txt mkdir -p $STEAMCMD && cd $STEAMCMD && \
    curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz && \
    find . -name "*steamclient.so" && exit 1 && \
    ./steamcmd.sh +runscript install.txt && cd .. && rm -rf $STEAMCMD

WORKDIR /home/steamrt/cs2/game/bin/linuxsteamrt64/cs2
ADD --chown=steamrt:steamrt server.sh $SERVER/server.sh
RUN chmod 700 $SERVER/server.sh

ENTRYPOINT ["./server.sh"]
