#!/bin/bash
sudo apt-get update
sudo apt-get install postgresql-client

HOST = $1
DBNAME = $2
USERNAME = $3
echo "starting process"
psql -u $USERNAME -h HOST -d $DBNAME -f 'modules/database/db_setup.sql'