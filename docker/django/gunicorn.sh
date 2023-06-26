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
python /app/manage.py compilemessages

find /var/www/django/static -type f \
  ! -regex '^.+\.\(jpg\|jpeg\|png\|gif\|webp\|zip\|gz\|tgz\|bz2\|tbz\|xz\|br\|swf\|flv\|woff\|woff2\|3gp\|3gpp\|asf\|avi\|m4v\|mov\|mp4\|mpeg\|mpg\|webm\|wmv\)$' \
  -exec brotli --force --best {} \+ \
  -exec gzip --force --keep --best {} \+

#GUNICORN_WORKERS="${WEB_CONCURRENCY:=4}"
#GUNICORN_MAX_REQUESTS="${GUNICORN_MAX_REQUESTS:-2000}"
#GUNICORN_MAX_REQUESTS_JITTER="${GUNICORN_MAX_REQUESTS_JITTER:-400}"
#GUNICORN_WORKER_TIMEOUT="${GUNICORN_WORKER_TIMEOUT:-60}"
#GUNICORN_WORKER_GRACEFUL_TIMEOUT="${GUNICORN_WORKER_GRACEFUL_TIMEOUT:-30}"

#exec /usr/local/bin/gunicorn django-template.asgi \
#  --workers=$GUNICORN_WORKERS \
#  --max-requests=$GUNICORN_MAX_REQUESTS \
#  --max-requests-jitter=$GUNICORN_MAX_REQUESTS_JITTER \
#  --timeout=$GUNICORN_WORKER_TIMEOUT \
#  --graceful-timeout=$GUNICORN_WORKER_GRACEFUL_TIMEOUT \
#  --bind='0.0.0.0:8000' \
#  --worker-tmp-dir='/dev/shm' \
#  --access-logfile=- \
#  --error-logfile=- \
#  ${GUNICORN_RELOAD:+'--reload'}
