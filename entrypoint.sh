!/bin/sh
set -e

if [ "$(id -u)" = '0' ]; then
    chown -R homeassistant /app
    chown -R homeassistant /config
    exec su-exec homeassistant /usr/bin/python3 -m homeassistant "$@"
fi

exec /usr/bin/python3 -m homeassistant "$@"
