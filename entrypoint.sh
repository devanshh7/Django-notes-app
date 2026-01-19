#!/bin/sh

echo "Waiting for MySQL..."

until python - << END
import MySQLdb
try:
    MySQLdb.connect(
        host="db",
        user="root",
        passwd="root",
        db="test_db",
        connect_timeout=3
    )
    print("MySQL is ready")
except Exception as e:
    raise SystemExit(1)
END
do
  sleep 3
done

echo "Running migrations..."
python manage.py migrate --noinput

echo "Starting Gunicorn..."
exec gunicorn notesapp.wsgi:application --bind 0.0.0.0:8000
