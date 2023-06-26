#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

#echo "DJANGO_ENV is $DJANGO_ENV"
#if [ "$DJANGO_ENV" != 'production' ]; then
#  echo 'Error: DJANGO_ENV is not set to "production".'
#  echo 'Application will not start.'
#  exit 1
#fi

export DJANGO_ENV

# Run python specific scripts:
# Running migrations in startup script might not be the best option, see:
# docs/pages/template/production-checklist.rst
python /app/manage.py migrate --noinput
python /app/manage.py collectstatic --noinput --clear
python /app/manage.py compilemessagesqdййq

find /var/www/django/static -type f \
  ! -regex '^.+\.\(jpg\|jpeg\|png\|gif\|webp\|zip\|gz\|tgz\|bz2\|tbz\|xz\|br\|swf\|flv\|woff\|woff2\|3gp\|3gpp\|asf\|avi\|m4v\|mov\|mp4\|mpeg\|mpg\|webm\|wmv\)$' \
  -exec brotli --force --best {} \+ \
  -exec gzip --force --keep --best {} \+

/usr/local/bin/gunicorn \
  --config python:gunicorn_config server.asgi
