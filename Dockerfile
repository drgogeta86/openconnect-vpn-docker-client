FROM docker.io/library/ubuntu:bionic
ARG SITE_NAME

ENV TZ Europe/Rome

RUN apt-get update \
    && ln -s -f /bin/true /usr/bin/chfn \
    && apt-get install -y --no-install-recommends ike  curl openssh-server iproute2 tzdata && apt-get clean \
    && useradd -rm -d /home/vpnuser -s /bin/bash -g root -G sudo -u 1000 vpnuser \ 
    && sed -i 's/^#\(PermitRootLogin\) .*/\1 yes/' /etc/ssh/sshd_config \
    && sed -i 's/^\(UsePAM yes\)/# \1/' /etc/ssh/sshd_config \
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
    && ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \
    && mkdir /var/run/sshd

RUN { \
    echo '#!/bin/bash -eu'; \
    echo 'mkdir -p /root/.ssh'; \
    echo 'chmod 0700 /root/.ssh'; \
    #echo 'mkdir -p /home/vpnuser/.ssh'; \
    #echo 'chmod 0700 /home/vpnuser/.ssh'; \
    #echo 'echo "${AUTHORIZED_SSH_KEY}" >> /home/vpnuser/.ssh/authorized_keys'; \
    echo 'echo "${AUTHORIZED_SSH_KEY}" >> /root/.ssh/authorized_keys'; \
    #echo 'echo -ne "\n" >> /root/.ssh/authorized_keys'; \
    #echo 'echo -ne "\n" >> /home/vpnuser/.ssh/authorized_keys'; \
    echo 'iked ' ; \
    echo '/usr/sbin/sshd -D -e'; \
    } > /usr/local/bin/entry_point.sh; \
    chmod +x /usr/local/bin/entry_point.sh;

COPY VPN/Planet.vpn /root/.ike/sites/${SITE_NAME}
EXPOSE 22

ENTRYPOINT ["entry_point.sh"]
