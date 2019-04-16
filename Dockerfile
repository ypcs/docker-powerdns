FROM ypcs/debian:buster

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

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
