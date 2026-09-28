#!/bin/bash

set -eu

# Load the env variables for username and passwords
source /home/conf/db.env

SQL_WORK_DIR="$(mktemp -d)"
cp /home/sqls/*.sql "$SQL_WORK_DIR/"

# Change the userids, passwords and schema name
sed -i "s/__SUPERUSERNAME__/${SUPER_USERNAME}/g" "$SQL_WORK_DIR/user.sql"
sed -i "s/__SUPERPASSWORD__/${SUPER_PASSWORD}/g" "$SQL_WORK_DIR/user.sql"

sed -i "s/__READERUSERNAME__/${READER_USERNAME}/g" "$SQL_WORK_DIR/user.sql"
sed -i "s/__READERPASSWORD__/${READER_PASSWORD}/g" "$SQL_WORK_DIR/user.sql"
sed -i "s/__EDITORUSERNAME__/${EDITOR_USERNAME}/g" "$SQL_WORK_DIR/user.sql"
sed -i "s/__EDITORPASSWORD__/${EDITOR_PASSWORD}/g" "$SQL_WORK_DIR/user.sql"

sed -i "s/__SCHEMA_NAME__/${DB_SCHEMA}/g" "$SQL_WORK_DIR/init.sql"
sed -i "s/__SCHEMA_NAME__/${DB_SCHEMA}/g" "$SQL_WORK_DIR/user.sql"
sed -i "s/__SCHEMA_NAME__/${DB_SCHEMA}/g" "$SQL_WORK_DIR/load.sql"
sed -i "s/\"public\"/\"${DB_SCHEMA}\"/g" "$SQL_WORK_DIR/Chinook.sql"

# Create the DB and connect to it
psql -v ON_ERROR_STOP=1 -U postgres -c "CREATE DATABASE chinook;"

# Run the queries to load data and create the users
psql -v ON_ERROR_STOP=1 -U postgres -d chinook -f "$SQL_WORK_DIR/init.sql" 
psql -v ON_ERROR_STOP=1 -U postgres -d chinook -f "$SQL_WORK_DIR/load.sql" 
psql -v ON_ERROR_STOP=1 -U postgres -d chinook -f "$SQL_WORK_DIR/user.sql" 
