#!/bin/sh
set -e

echo "Waiting for MySQL..."

until mysqladmin ping -h db -uroot -proot --silent; do
  sleep 3
done

echo "MySQL is ready"

python manage.py migrate --noinput
gunicorn notesapp.wsgi:application --bind 0.0.0.0:8000
