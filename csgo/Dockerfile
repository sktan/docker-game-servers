FROM registry.gitlab.steamos.cloud/steamrt/sniper/platform:latest

ENV HOME /home/steamrt
ENV SERVER $HOME/csgo
ENV STEAMCMD $HOME/steamcmd

ADD steamcmd $STEAMCMD/
RUN cd $STEAMCMD && curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz && \
    ./steamcmd.sh +runscript install.txt && cd .. && rm -rf $STEAMCMD

ADD cfg $SERVER/csgo/cfg/
RUN curl -L 'https://sourcemod.net/latest.php?version=1.11&os=linux' | tar -vxz -C $SERVER/csgo && \
    curl -L 'https://www.metamodsource.net/latest.php?version=1.11&os=linux' | tar -xzv -C $SERVER/csgo && \
    curl -L 'https://warmod.bitbucket.io/plugins/warmod.smx' -o $SERVER/csgo/addons/sourcemod/plugins/warmod.smx

EXPOSE 27015/udp
EXPOSE 27015/tcp

WORKDIR /home/steamrt/csgo
ENTRYPOINT ["./srcds_run"]
CMD ["-console" "-usercon" "-tickrate" "128" "+game_type" "0" "+game_mode" "1" "+mapgroup" "mg_active" "+map" "de_cache"]
