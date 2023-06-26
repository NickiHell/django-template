#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

readonly cmd="$*"

wait_db() {
  while ! /usr/bin/pg_isready -h $POSTGRES_HOST -p ${POSTGRES_PORT:-5432} >/dev/null 2>/dev/null; do
    echo "Wait for DB (Host: $POSTGRES_HOST, port: ${POSTGRES_PORT:-5432})"
    sleep 1
  done
}

wait_db
echo "Postgres ${POSTGRES_HOST}:${POSTGRES_PORT} is up"

echo -e "\n### Migrate DB ###\n" && python manage.py migrate
echo -e "\n### Collect Static ###\n" && python manage.py collectstatic --noinput --clear
echo -e "\n### Compile Messages ###\n" && python manage.py compilemessages

exec $cmd
