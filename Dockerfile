FROM ypcs/debian:buster

RUN /usr/lib/docker-helpers/apt-setup && \
    /usr/lib/docker-helpers/apt-upgrade && \
    apt-get --assume-yes install \
        pdns-backend-bind \
        pdns-backend-geoip \
        pdns-backend-mysql \
        pdns-server \
        pdns-tools && \
    /usr/lib/docker-helpers/apt-cleanup
