#!/bin/sh

psql -U ${PGADMINUSER} -h ${PGHOST} -d postgres -c "create user \"${PGUSER}\" with encrypted password '${PGUSERPASSWORD}'"

for db in $(echo $PGDATABASE | sed "s/,/ /g")
do
  echo "Granting readonly access to $db..."
  psql -U ${PGADMINUSER} -h ${PGHOST} -d postgres -c "grant connect on database \"${db}\" to \"${PGUSER}\""
  psql -U ${PGADMINUSER} -h ${PGHOST} -d $db -c "grant usage on schema public to \"${PGUSER}\""
  psql -U ${PGADMINUSER} -h ${PGHOST} -d $db -c "grant select on all tables in schema public to \"${PGUSER}\""
done

exit 0
