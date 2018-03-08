[![Build Status](https://travis-ci.org/robertbeal/docker-homeassistant.svg?branch=master)](https://travis-ci.org/robertbeal/homeassistant)
[![](https://images.microbadger.com/badges/image/robertbeal/homeassistant.svg)](https://microbadger.com/images/robertbeal/homeassistant "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/robertbeal/homeassistant.svg)](https://microbadger.com/images/robertbeal/homeassistant "Get your own version badge on microbadger.com")
[![](https://img.shields.io/docker/pulls/robertbeal/homeassistant.svg)](https://hub.docker.com/r/robertbeal/homeassistant/)
[![](https://img.shields.io/docker/stars/robertbeal/homeassistant.svg)](https://hub.docker.com/r/robertbeal/homeassistant/)
[![](https://img.shields.io/docker/automated/robertbeal/homeassistant.svg)](https://hub.docker.com/r/robertbeal/homeassistant/)

An alpine-sized build of HomeAssistant with all standard plugins installed. The container can be run in `--read-only` mode for additional security!

```
docker run \
  --name homeassistant \
  --init \
  --read-only \
  --user $(id homeassistant -u):$(id homeassistant -g) \
  --net host \
  --volume /var/homeassistant:/config \
  -p 127.0.0.1:8123:8123 \
  --health-cmd="curl --fail http://127.0.0.1:8123/api || exit 1" \
  --health-interval=5s \
  --health-retries=3 \
  robertbeal/homeassistant
```
