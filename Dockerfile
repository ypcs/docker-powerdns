FROM ypcs/debian:buster

RUN /usr/local/sbin/docker-upgrade && \
    apt-get --assume-yes install \
        pdns-backend-bind \
        pdns-backend-geoip \
        pdns-backend-mysql \
        pdns-server \
        pdns-tools && \
    /usr/local/sbin/docker-cleanup
