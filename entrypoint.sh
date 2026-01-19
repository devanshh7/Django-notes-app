#!/bin/sh
set -e

echo "Waiting for MySQL..."

until mysqladmin ping -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USER" -p"$DB_PASSWORD" --silent; do
  sleep 3
done

echo "MySQL is ready"

python manage.py migrate --noinput
gunicorn notesapp.wsgi:application --bind 0.0.0.0:8000
