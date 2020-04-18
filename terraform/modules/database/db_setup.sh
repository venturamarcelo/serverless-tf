#!/bin/bash
echo "installing psql"
apt-get install -y postgresql-client

HOST=$1
DBNAME=$2
USERNAME=$3
echo "starting process"
psql -u $USERNAME -h HOST -d $DBNAME -a -f 'modules/database/db_setup.sql'