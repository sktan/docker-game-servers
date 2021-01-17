FROM amazoncorretto:8 AS base
LABEL maintainer="Steven Tan <git@sktan.com>"

ENV MINECRAFT_VER=1.12.2
ENV FORGE_VER=14.23.5.2854
ENV FORGE_URL=https://files.minecraftforge.net/maven/net/minecraftforge/forge/${MINECRAFT_VER}-${FORGE_VER}/forge-${MINECRAFT_VER}-${FORGE_VER}-installer.jar
ENV RLCRAFT_URL=https://media.forgecdn.net/files/2935/323/RLCraft+Server+Pack+1.12.2+-+Beta+v2.8.2.zip

RUN mkdir -p /opt/minecraft && \
    yum install -y curl jq shadow-utils unzip && \
    curl -s -o /opt/minecraft/installer.jar "$FORGE_URL" && \
    curl -s -o /opt/minecraft/rlcraft.zip "$RLCRAFT_URL"

WORKDIR /opt/minecraft/

RUN unzip -q rlcraft.zip && rm -rf rlcraft.zip && \
    java -jar installer.jar --installServer && \
    rm -rf installer* && \
    ln -s forge-*.jar server.jar

FROM amazoncorretto:8

# # Setup Minecraft Server
# RUN yum install -y curl jq shadow-utils unzip && \
#     mkdir -p /opt/minecraft && \
#     curl -o /opt/server.jar $(curl -qs $(curl -qs https://launchermeta.mojang.com/mc/game/version_manifest.json | jq -r '[.versions[]|select(.type=="release")][0].url') | jq -r '.downloads.server.url') && \
#     useradd -m -d /opt/minecraft minecraft && \
#     chown -R minecraft:minecraft /opt/minecraft && \
#     chown -R minecraft:minecraft /opt/server.jar && \
#     echo "eula=true" > /opt/minecraft/eula.txt && \
#     yum remove shadow-utils -y

RUN yum install -y shadow-utils && \
    useradd -m -d /opt/minecraft minecraft

COPY --from=base --chown=minecraft:minecraft /opt/minecraft/ /opt/rlcraft/

RUN echo "eula=true" > /opt/rlcraft/eula.txt && \
    chown -R minecraft:minecraft /opt/minecraft

WORKDIR /opt/rlcraft
USER minecraft

EXPOSE 25565

ENTRYPOINT [ "java" ]
CMD [ \
    "-Xms4G", \
    "-Xmx4G", \
    "-XX:+UseG1GC",\
    "-XX:+ParallelRefProcEnabled", \
    "-XX:MaxGCPauseMillis=200", \
    "-XX:+UnlockExperimentalVMOptions",\
    "-XX:+DisableExplicitGC", \
    "-XX:+AlwaysPreTouch", \
    "-XX:G1NewSizePercent=30", \
    "-XX:G1MaxNewSizePercent=40", \
    "-XX:G1HeapRegionSize=8M", \
    "-XX:G1ReservePercent=20", \
    "-XX:G1HeapWastePercent=5", \
    "-XX:G1MixedGCCountTarget=4", \
    "-XX:InitiatingHeapOccupancyPercent=15", \
    "-XX:G1MixedGCLiveThresholdPercent=90", \
    "-XX:G1RSetUpdatingPauseTimePercent=5", \
    "-XX:SurvivorRatio=32", \
    "-XX:+PerfDisableSharedMem", \
    "-XX:MaxTenuringThreshold=1", \
    "-jar", "server.jar", "nogui" \
]
