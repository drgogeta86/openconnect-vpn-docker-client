FROM docker.io/library/ubuntu:bionic
ARG site-name

RUN apt-get update && \
    apt-get install -y ike ike-qtgui

ADD VPN/${site-name}.vpn /root/.ike/sites/${site-name}

ENTRYPOINT iked -d 6 -F
