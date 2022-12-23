#!/bin/bash

ZABBIX_SERVER=192.168.200.7
HOSTNAME=mysql-slave
ITEM_KEY=replica.status

MYSQL_USER='root'
MYSQL_PASS='Password'
MYSQL_CONN="-u${MYSQL_USER} -p${MYSQL_PASS}"

SLAVE_STATUS=$(mysql ${MYSQL_CONN} -e"SHOW SLAVE STATUS \G" | grep "Slave_SQL_Running:")

if [[ $SLAVE_STATUS == *"No"* ]]; then
    ITEM_VALUE=0
else
    ITEM_VALUE=1
fi

/usr/bin/zabbix_sender -z $ZABBIX_SERVER -s $HOSTNAME -k $ITEM_KEY -o $ITEM_VALUE
