#!/bin/bash

# uses the environment variable PGPASSWORD to authenticate against postgresql
export PGUSERPASSWORD=${PGPASSWORD}
export PGPASSWORD=${PGADMINPASSWORD}

until nslookup ${PGHOST}; do
  echo "waiting for ${PGHOST} to come up";
  sleep 2;
done

until psql -U ${PGADMINUSER} -h ${PGHOST} -d postgres -l > /dev/null; do
  echo "waiting for postgres on ${PGHOST} to become ready";
  sleep 2;
done

psql -U ${PGADMINUSER} -h ${PGHOST} -d postgres -c "create user \"${PGUSER}\" with encrypted password '${PGUSERPASSWORD}'"
psql -U ${PGADMINUSER} -h ${PGHOST} -d postgres -c "create database \"${PGDATABASE}\""
psql -U ${PGADMINUSER} -h ${PGHOST} -d postgres -c "grant all privileges on database \"${PGDATABASE}\" to \"${PGUSER}\""

exit 0
