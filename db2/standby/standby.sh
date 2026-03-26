#!/usr/bin/env bash
set -euo pipefail

run_as_postgres() {
  if [ "$(id -u)" = "0" ]; then
    gosu postgres "$@"
  else
    "$@"
  fi
}

if [ ! -s "$PGDATA/PG_VERSION" ]; then
  rm -rf "$PGDATA"/*
  until pg_isready -h db1 -p 5432; do
    sleep 1
  done
  chown -R postgres:postgres "$PGDATA"
  PGPASSWORD="${REPL_PASSWORD}" run_as_postgres pg_basebackup \
    -h db1 \
    -D "$PGDATA" \
    -U "$REPL_USER" \
    -Fp -Xs -P -R
fi

if [ "$(id -u)" = "0" ]; then
  exec gosu postgres postgres \
    -c config_file=/etc/postgresql/postgresql.conf \
    -c hba_file=/etc/postgresql/pg_hba.conf
fi

exec postgres \
  -c config_file=/etc/postgresql/postgresql.conf \
  -c hba_file=/etc/postgresql/pg_hba.conf
