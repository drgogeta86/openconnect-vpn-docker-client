FROM docker.io/library/ubuntu:bionic
ARG SITE_NAME

RUN apt-get update && \
    apt-get install -y ike ike-qtgui

COPY VPN/${SITE_NAME}.vpn /root/.ike/sites/${SITE_NAME}

ENTRYPOINT iked -d 6 -F
