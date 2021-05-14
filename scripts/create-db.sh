#!/bin/sh

psql -U ${PGADMINUSER} -h ${PGHOST} -d postgres -c "create user \"${PGUSER}\" with encrypted password '${PGUSERPASSWORD}'"
psql -U ${PGADMINUSER} -h ${PGHOST} -d postgres -c "create database \"${PGDATABASE}\""
psql -U ${PGADMINUSER} -h ${PGHOST} -d postgres -c "grant all privileges on database \"${PGDATABASE}\" to \"${PGUSER}\""

exit 0
