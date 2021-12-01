FROM amazoncorretto:17
LABEL maintainer="Steven Tan <git@sktan.com>"

# Setup Minecraft Server
RUN yum install -y curl jq shadow-utils && \
    mkdir -p /opt/minecraft && \
    curl -o /opt/server.jar $(curl -qs $(curl -qs https://launchermeta.mojang.com/mc/game/version_manifest.json | jq -r '[.versions[]|select(.type=="release")][0].url') | jq -r '.downloads.server.url') && \
    useradd -m -d /opt/minecraft minecraft && \
    chown -R minecraft:minecraft /opt/minecraft && \
    chown -R minecraft:minecraft /opt/server.jar && \
    echo "eula=true" > /opt/minecraft/eula.txt && \
    yum remove shadow-utils -y

WORKDIR /opt/minecraft
USER minecraft

EXPOSE 25565

ENTRYPOINT [ "java" ]
CMD [ "-XX:+UseShenandoahGC", "-Xms2048M", "-Xmx2048M", "-jar", "/opt/server.jar", "nogui" ]
