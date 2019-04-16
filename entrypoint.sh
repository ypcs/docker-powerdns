#!/bin/sh
set -e

SCHEMA="/usr/share/pdns-backend-mysql/schema/schema.mysql.sql"

if [ \( -n "${MYSQL_DATABASE}" -a -n "${MYSQL_USER}" -a -n "${MYSQL_PASSWORD}" -a -n "${MYSQL_HOST}" \) ]
then
    echo "I: Create database schema (if not exists)."
    sed \
        -e 's/^CREATE DATABASE/CREATE DATABASE IF NOT EXISTS/g' \
	-e 's/CREATE INDEX/CREATE INDEX IF NOT EXISTS/g' \
	-e 's/CREATE UNIQUE INDEX/CREATE UNIQUE INDEX IF NOT EXISTS/g' \
	"${SCHEMA}" |mysql -u "${MYSQL_USER}" --password="${MYSQL_PASSWORD}" "${MYSQL_DATABASE}" 

    cat >> /etc/pdns/pdns.conf << EOF
#
# Runtime database configuration
#
launch=gmysql
gmysql-host=${MYSQL_HOST}
gmysql-user=${MYSQL_USER}
gmysql-dbname=${MYSQL_DATABASE}
gmysql-password=${MYSQL_PASSWORD}
EOF
fi

echo "I: Starting pdns server."
pdns_server "$@"
