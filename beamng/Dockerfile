FROM registry.gitlab.steamos.cloud/steamrt/sniper/platform:latest

ENV HOME /home/gameserver
ENV SERVER $HOME/beamng

RUN useradd -m -d /home/gameserver gameserver && chown gameserver:gameserver $HOME -R

RUN apt update && apt install -y liblua5.3-0 

USER gameserver
RUN mkdir -p $SERVER && \
    curl -s -L https://github.com/BeamMP/BeamMP-Server/releases/download/v3.2.2/BeamMP-Server.debian.11.x86_64 \
    -o $SERVER/BeamMP-Server && chmod +x $SERVER/BeamMP-Server && \
    cd $SERVER && ./BeamMP-Server || exit 0

WORKDIR /home/gameserver/beamng

ENTRYPOINT ["./BeamMP-Server"]
