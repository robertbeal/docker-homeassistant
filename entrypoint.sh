#!/bin/sh
set -e

if [ "$1" = '/app/bin/hass' -a "$(id -u)" = '0' ]; then
    chown -R homeassistant /app
    chown -R homeassistant /config
    exec su-exec homeassistant "$@" $ARGS
fi

exec "$@" $ARGS
