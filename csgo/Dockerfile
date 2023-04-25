FROM registry.gitlab.steamos.cloud/steamrt/sniper/platform:latest

ENV HOME /home/steamrt
ENV SERVER $HOME/csgo
ENV STEAMCMD $HOME/steamcmd

ENV CSGO_HOSTNAME "My CSGO Server" \
    CSGO_RCON_PASSWORD "MyRconPassword123" \
    CSGO_JOIN_PASSWORD "" \
    CSGO_STEAM_ACCOUNT "anonymous" \
    CSGO_SERVER_ADMINS "" \
    CSGO_MAP "de_dust2" \
    CSGO_PORT 27015


ADD steamcmd $STEAMCMD/
RUN cd $STEAMCMD && curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz && \
    ./steamcmd.sh +runscript install.txt && cd .. && rm -rf $STEAMCMD

ADD cfg $SERVER/csgo/cfg/
RUN curl -L 'https://sourcemod.net/latest.php?version=1.11&os=linux' | tar -vxz -C $SERVER/csgo && \
    curl -L 'https://www.metamodsource.net/latest.php?version=1.11&os=linux' | tar -xzv -C $SERVER/csgo && \
    curl -L 'https://warmod.bitbucket.io/plugins/warmod.smx' -o $SERVER/csgo/addons/sourcemod/plugins/warmod.smx

WORKDIR /home/steamrt/csgo
ADD --chown=steamrt:steamrt server.sh $SERVER/server.sh
RUN chmod 700 $SERVER/server.sh

ENTRYPOINT ["./server.sh"]
