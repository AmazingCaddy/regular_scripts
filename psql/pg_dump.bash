#!/bin/bash

now=$(date +'%Y-%m-%d %H-%M')
host=""
port=""
username="postgres"
password=""
dbs=("postgres")
pushd ~/DBBackup

mkdir -p "common/${now}"
for db in ${dbs[@]};do
  PGPASSWORD=${password} pg_dump --file "./common/${now}/${db}.sql" -w -U ${username} -h ${host} -p ${port} --verbose --format=p ${db}
done
popd

echo "done"
