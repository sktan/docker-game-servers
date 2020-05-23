FROM amazonlinux:latest
LABEL maintainer="Steven Tan <git@sktan.com>"

ENV TERRARIA_HOME /home/terraria
ENV TERRARIA_DOWNLOAD https://terraria.org/system/dedicated_servers/archives/000/000/037/original/terraria-server-1403.zip?1590018631
ENV TERRARIA_LOCATION $TERRARIA_HOME/1402/Linux/
ENV TERRARIA_PASSWORD test123

RUN yum install curl unzip zip shadow-utils glibc.i686 libc6 gcc libgcc.i686 -y && \
    useradd terraria && mkdir -p $TERRARIA_HOME && chown terraria:terraria $TERRARIA_HOME -R

RUN curl -o /tmp/terraria.zip ${TERRARIA_DOWNLOAD} && \
    unzip /tmp/terraria.zip -d ${TERRARIA_HOME} && chmod 700 $TERRARIA_LOCATION/TerrariaServer{,.bin.x86,.bin.x86_64} && \
    mkdir -p /home/terraria/world

ADD terraria.sh $TERRARIA_LOCATION/terraria.sh

RUN chown terraria:terraria -R ${TERRARIA_HOME} && chmod 700 $TERRARIA_LOCATION/terraria.sh

USER terraria
WORKDIR $TERRARIA_LOCATION
EXPOSE 7777

ENTRYPOINT [ "./terraria.sh" ]
