FROM registry.gitlab.steamos.cloud/steamrt/sniper/platform:latest

ENV HOME /home/steamrt
ENV SERVER $HOME/ets2
ENV STEAMCMD $HOME/steamcmd

ADD steamcmd $STEAMCMD/
RUN cd $STEAMCMD && curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz && \
    ./steamcmd.sh +runscript install.txt && cd .. && rm -rf $STEAMCMD

RUN rm $SERVER/steamclient.so && mv $SERVER/linux64/steamclient.so $SERVER/steamclient.so

WORKDIR /home/steamrt/ets2
ADD --chown=steamrt:steamrt server.sh $SERVER/server.sh
RUN chmod 700 $SERVER/server.sh

ENTRYPOINT ["./server.sh"]
