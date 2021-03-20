FROM ubuntu:bionic
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y \
        openssh-client

ADD ./docker-entrypoint.sh /
ENTRYPOINT [ "/docker-entrypoint.sh" ]
