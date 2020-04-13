#!/bin/bash
echo "installing psql"
#yum install https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-redhat10-10-2.noarch.rpm  
#yum install postgresql10  

uname -a

HOST=$1
DBNAME=$2
USERNAME=$3
echo "starting process"
psql -u $USERNAME -h HOST -d $DBNAME -a -f 'modules/database/db_setup.sql'