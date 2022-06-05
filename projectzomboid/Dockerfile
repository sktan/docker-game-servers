FROM amazoncorretto:17
MAINTAINER Steven Tan <git@sktan.com>

ENV HOME /home/steam
ENV SERVER $HOME/projectzomboid
ENV STEAMCMD $HOME/steamcmd

RUN yum install -y curl tar shadow-utils glibc.i686 libstdc++.i686 gzip
RUN useradd steam && mkdir -p $SERVER && mkdir $STEAMCMD && chown steam:steam $HOME -R

USER steam

RUN cd $STEAMCMD && curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz
ADD install.txt $STEAMCMD/install.txt
RUN cd $STEAMCMD && ./steamcmd.sh +runscript install.txt

EXPOSE 8766/udp
EXPOSE 16261/udp

WORKDIR /home/steam/projectzomboid
ENTRYPOINT ["./start-server.sh"]
