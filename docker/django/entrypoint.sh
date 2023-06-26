#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

readonly cmd="$*"

wait_db() {
  while ! /usr/bin/pg_isready -h $POSTGRES_HOST -p ${POSTGRES_HOST:-5432} >/dev/null 2>/dev/null; do
    echo "I'm waiting DB (Host: $POSTGRES_HOST, port: ${POSTGRES_PORT:-5432})"
    sleep 1
  done
}


echo -e "\n### Migrate DB ###\n" && wait_db && python manage.py migrate &&
python /app/manage.py collectstatic --noinput --clear &&
python /app/manage.py compilemessages


echo "Postgres ${POSTGRES_HOST}:${POSTGRES_PORT} is up"
exec $cmd
