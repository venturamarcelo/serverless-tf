#!/bin/bash
echo "installing psql"
#apt-get install -y postgresql-client
apk add postgresql-client

echo "starting process"
psql -u $USERNAME -h HOST -d $DBNAME -a -f 'modules/database/db_setup.sql'