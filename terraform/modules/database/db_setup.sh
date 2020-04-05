#!/bin/bash
sudo apt-get update
sudo apt-get install postgresql-client

HOST = $1
DBNAME = $2
USERNAME = $3

psql -u $USERNAME -h HOST -d $DBNAME -f db_setup.sql