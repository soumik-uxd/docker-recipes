#!/bin/bash

set -eux

source /home/conf/db.env

# Change the userids and passwords 
sed -i "s/__SUPERUSERNAME__/${SUPER_USERNAME}/g" /home/data/user.sql
sed -i "s/__SUPERPASSWORD__/${SUPER_PASSWORD}/g" /home/data/user.sql
sed -i "s/__READERUSERNAME__/${READER_USERNAME}/g" /home/data/user.sql
sed -i "s/__READERPASSWORD__/${READER_PASSWORD}/g" /home/data/user.sql
sed -i "s/__EDITORUSERNAME__/${EDITOR_USERNAME}/g" /home/data/user.sql
sed -i "s/__EDITORPASSWORD__/${EDITOR_PASSWORD}/g" /home/data/user.sql
sed -i "s/\"public\"/\"${DB_SCHEMA}\"/g" /home/data/Chinook.sql

# Create the DB and connect to it
psql -v ON_ERROR_STOP=1 -U postgres -c "CREATE DATABASE chinook;"

psql -v ON_ERROR_STOP=1 -U postgres -d chinook -f /home/data/init.sql 

psql -v ON_ERROR_STOP=1 -U postgres -d chinook -f /home/data/load.sql >> /var/log/chinook-load.log
psql -v ON_ERROR_STOP=1 -U postgres -d chinook -f /home/data/user.sql >> /var/log/chinook-load.log

# Unset env vars and remove files
unset $(cut -d= -f1 /home/conf/db.env) 
rm -f /home/conf/db.env
rm -f /home/data/*.sql