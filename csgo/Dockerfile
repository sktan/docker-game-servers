FROM ubuntu:16.04
MAINTAINER Steven Tan <git@sktan.com>

ENV HOME /home/steam
ENV SERVER $HOME/csgo
ENV STEAMCMD $HOME/steamcmd

RUN apt-get update && apt-get -y install lib32stdc++6 lib32gcc1 curl
RUN useradd steam && mkdir $HOME && mkdir $SERVER && mkdir $STEAMCMD && chown steam:steam $HOME -R

USER steam

RUN cd $STEAMCMD && curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz
ADD install.txt $STEAMCMD/install.txt
RUN cd $STEAMCMD && ./steamcmd.sh +runscript install.txt
ADD practice.cfg $SERVER/csgo/cfg/practice.cfg
ADD autoexec.cfg $SERVER/csgo/cfg/autoexec.cfg

RUN curl -L 'https://sourcemod.net/latest.php?version=1.11&os=linux' | tar -vxz -C $SERVER/csgo && \
    curl -L 'https://www.metamodsource.net/latest.php?version=1.11&os=linux' | tar -xzv -C $SERVER/csgo && \
    curl -L 'https://warmod.bitbucket.io/plugins/warmod.smx' -o $SERVER/csgo/addons/sourcemod/plugins/warmod.smx

EXPOSE 27015/udp
EXPOSE 27015/tcp

WORKDIR /home/steam/csgo
ENTRYPOINT ["./srcds_run"]
CMD ["-console" "-usercon" "-tickrate" "128" "+game_type" "0" "+game_mode" "1" "+mapgroup" "mg_active" "+map" "de_cache"]

