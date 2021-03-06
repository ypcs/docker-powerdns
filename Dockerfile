FROM ypcs/debian:bullseye

ARG APT_PROXY

RUN /usr/lib/docker-helpers/apt-setup && \
    /usr/lib/docker-helpers/apt-upgrade && \
    apt-get --assume-yes install \
        default-mysql-client \
        pdns-backend-bind \
        pdns-backend-geoip \
        pdns-backend-mysql \
        pdns-server \
        pdns-tools && \
    /usr/lib/docker-helpers/apt-cleanup

RUN /usr/lib/docker-helpers/apt-setup && \
    apt-get --assume-yes install \
        dnsutils \
        netcat && \
    /usr/lib/docker-helpers/apt-cleanup

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
