FROM amazonlinux:latest
MAINTAINER Steven Tan <git@sktan.com>

ENV HOME /home/steam
ENV SERVER $HOME/kf2
ENV STEAMCMD $HOME/steamcmd

ENV KF2_SERVERNAME="Killing Floor 2 Server" \
    KF2_SERVERPASSWORD="kf2game" \
    KF2_ADMINPASSWORD="kf2admin" \
    KF2_MAP="kf-bioticslab" \
    KF2_DIFFICULTY="1" \
    KF2_MAXPLAYERS="12"

RUN yum install -y curl tar shadow-utils libgcc.i686 glibc.i686 libc6 gzip
RUN useradd steam && mkdir -p $SERVER && mkdir -p $STEAMCMD && chown steam:steam $HOME -R

USER steam

ADD install.txt $STEAMCMD/install.txt
RUN df -h && cd $STEAMCMD && curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz && \
    cd $STEAMCMD && ./steamcmd.sh +runscript install.txt

WORKDIR ${SERVER}


ADD --chown=steam:steam server.sh $SERVER/server.sh
ADD --chown=steam:steam configs/* KFGame/Config/

RUN chmod 700 $SERVER/server.sh

EXPOSE 7777/udp 27015/udp 20560/udp 8080/tcp

ENTRYPOINT [ "./server.sh" ]
