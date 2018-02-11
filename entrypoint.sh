#!/bin/sh
set -e

if [ "$(id -u)" = '0' ]; then
    chown -R homeassistant /app
    chown -R homeassistant /config
    exec su-exec homeassistant /app/bin/hass "$@"
fi

exec "$@"
