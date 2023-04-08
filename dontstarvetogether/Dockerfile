FROM amazonlinux:2
LABEL maintainer="Steven Tan <git@sktan.com>"

ENV HOME /home/steam
ENV SERVER $HOME/dontstarvetogether
ENV STEAMCMD $HOME/steamcmd

# libcurl workaround as our OS doesn't have any packages for this.
RUN yum install -y curl tar gzip shadow-utils glibc.x86_64 glibc.i686 libcurl.i686 && \
    ln -s /usr/lib/libcurl.so.4 /usr/lib/libcurl-gnutls.so.4
RUN useradd steam && mkdir -p $SERVER && mkdir -p $STEAMCMD && chown steam:steam $HOME -R

USER steam

ADD install.txt $STEAMCMD/install.txt
RUN cd $STEAMCMD && curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz && \
    cd $STEAMCMD && ./steamcmd.sh +runscript install.txt

WORKDIR ${SERVER}/bin
EXPOSE 10999/udp

ENTRYPOINT [ "./dontstarve_dedicated_server_nullrenderer" ]
