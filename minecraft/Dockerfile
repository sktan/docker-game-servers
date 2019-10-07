FROM ubuntu:18.04
LABEL maintainer="Steven Tan <git@sktan.com>"

ENV CORRETTO_URL https://d3pxv6yz143wms.cloudfront.net/8.222.10.1/java-1.8.0-amazon-corretto-jdk_8.222.10-1_amd64.deb

# Install Base Requirements
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y curl gnupg2 java-common jq && \
    curl ${CORRETTO_URL} -O && \
    dpkg --install java-*.deb && \
    java -version

# Add scripts to manage minecraft server
ADD scripts /opt/minecraft-scripts

# Setup Minecraft Server
RUN mkdir -p /opt/minecraft && \
    curl -o /opt/minecraft/server.jar $(curl -qs $(curl -qs https://launchermeta.mojang.com/mc/game/version_manifest.json | jq -r '.versions[0].url') | jq -r '.downloads.server.url') && \
    adduser  --disabled-password --gecos '' --home /opt/minecraft minecraft && \
    chown -R minecraft:minecraft /opt/minecraft && \
    echo "eula=true" > /opt/minecraft/eula.txt

WORKDIR /opt/minecraft

EXPOSE 25565

ENTRYPOINT ["/opt/minecraft-scripts/minecraft.sh"]
