#!/bin/sh

set -e

echo "run db migration"
source /app/app.env
/usr/bin/migrate -path /app/migration -database "$DB_SOURCE" -verbose up

echo "start the app"
exec "$@"