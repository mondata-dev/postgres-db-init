#!/bin/sh

# uses the environment variable PGPASSWORD to authenticate against postgresql
export PGUSERPASSWORD=${PGPASSWORD}
export PGPASSWORD=${PGADMINPASSWORD}

until psql -U ${PGADMINUSER} -h ${PGHOST} -d postgres -l > /dev/null; do
  echo "waiting for postgres on ${PGHOST} to become ready";
  sleep 2;
done

exec /scripts/${1:-create-db.sh}
