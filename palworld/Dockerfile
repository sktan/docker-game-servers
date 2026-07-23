FROM registry.gitlab.steamos.cloud/steamrt/sniper/platform:latest

ENV HOME=/home/palworld
ENV SERVER=/home/palworld/palworld
ENV STEAMCMD=/home/palworld/steamcmd

RUN echo steam steam/question select "I AGREE" | debconf-set-selections && \
    echo steam steam/license note '' | debconf-set-selections && \
    apt update && apt install -y software-properties-common xdg-user-dirs steamcmd && \
    useradd -m -d /home/palworld palworld && chown palworld:palworld $HOME -R && \
    rm -rf /var/lib/apt/lists/*

USER palworld

WORKDIR /home/palworld
ADD --chown=palworld:palworld steamcmd/install.txt /home/palworld/install.txt
RUN mkdir -p $HOME/.steam/{steam,root} && \
    /usr/games/steamcmd +runscript /home/palworld/install.txt

WORKDIR /home/palworld/palworld

ENTRYPOINT ["./PalServer.sh"]
CMD ["-useperfthreads", "-NoAsyncLoadingThread", "-UseMultithreadForDS"]
