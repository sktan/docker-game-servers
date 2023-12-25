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

ADD steamcmd $STEAMCMD/
RUN cd $STEAMCMD && curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz && \
    ./steamcmd.sh +runscript install.txt && \
    mkdir -p $HOME/.steam/sdk64 && cp $STEAMCMD/linux64/steamclient.so $HOME/.steam/sdk64/steamclient.so && \
    cd .. && rm -rf $STEAMCMD

WORKDIR /home/steamrt/cs2/game/bin/linuxsteamrt64
ADD --chown=steamrt:steamrt server.sh $SERVER/game/bin/linuxsteamrt64/server.sh
RUN chmod 700 $SERVER/game/bin/linuxsteamrt64/server.sh

ENTRYPOINT ["./server.sh"]
