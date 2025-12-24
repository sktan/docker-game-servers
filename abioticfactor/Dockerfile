# syntax = docker/dockerfile:1

FROM registry.gitlab.steamos.cloud/steamrt/sniper/platform:latest

ENV HOME=/home/abioticserver
ENV STEAMCMD="$HOME/steamcmd"
ENV GAMEPORT=7777
ENV QUERYPORT=27015
ENV SERVERPASSWORD="abcd1234"
ENV ADMINPASSWORD="admin1234"
ENV SERVERNAME="My Abiotic Factor Server"

RUN dpkg --add-architecture i386 && \
    apt update && apt install xdg-user-dirs wine64 libwine xvfb cabextract -y && \
    useradd -m -d /home/abioticserver abioticserver && \
    chown abioticserver:abioticserver $HOME -R && \
    apt-get clean autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

USER abioticserver
ADD --chown=abioticserver:abioticserver steamcmd $STEAMCMD/
RUN cd $STEAMCMD && curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz && \
    ./steamcmd.sh +runscript install.txt && \
    mkdir -p $HOME/.steam/sdk64 && cp $STEAMCMD/linux64/steamclient.so $HOME/.steam/sdk64/steamclient.so && \
    cd .. && rm -rf $STEAMCMD

WORKDIR /home/abioticserver/AbioticFactor/Binaries/Win64

RUN curl https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks -o winetricks && \
    chmod +x winetricks
RUN set -xe && \
	WINEDLLOVERRIDES="mscoree,mshtml=" xvfb-run wine wineboot && \
	xvfb-run ./winetricks -q vcrun2022 && \
    rm -f winetricks

ADD --chown=abioticserver:abioticserver server.sh $HOME/AbioticFactor/Binaries/Win64/runserver.sh
RUN chmod 700 $HOME/AbioticFactor/Binaries/Win64/runserver.sh

ENTRYPOINT ["./runserver.sh"]
