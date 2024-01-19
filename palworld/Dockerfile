FROM registry.gitlab.steamos.cloud/steamrt/sniper/platform:latest

ENV HOME /home/palworld
ENV SERVER $HOME/palworld
ENV STEAMCMD $HOME/steamcmd

ADD steamcmd $STEAMCMD/
RUN apt install xdg-user-dirs && useradd -m -d /home/palworld palworld && chown palworld:palworld $HOME -R

USER palworld
RUN cd $STEAMCMD && curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz && \
    ./steamcmd.sh +runscript install.txt && \
    mkdir -p /home/palworld/.steam/sdk64/ && \
    cp /home/palworld/steamcmd/linux64/steamclient.so /home/palworld/.steam/sdk64/steamclient.so

WORKDIR /home/palworld/palworld

ENTRYPOINT ["./PalServer.sh"]
CMD ["-useperfthreads", "-NoAsyncLoadingThread", "-UseMultithreadForDS"]
