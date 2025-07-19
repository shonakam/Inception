#!/usr/bin/env sh

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld


if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."
    mysql_install_db --user=root --basedir=/usr --datadir=/var/lib/mysql
fi

exec mysqld --user=root --datadir=/var/lib/mysql --init-file=/init.sql
