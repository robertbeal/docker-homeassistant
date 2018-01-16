[![Build Status](https://travis-ci.org/robertbeal/docker-homeassistant.svg?branch=master)](https://travis-ci.org/robertbeal/homeassistant)
[![](https://images.microbadger.com/badges/image/robertbeal/homeassistant.svg)](https://microbadger.com/images/robertbeal/homeassistant "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/robertbeal/homeassistant.svg)](https://microbadger.com/images/robertbeal/homeassistant "Get your own version badge on microbadger.com")
[![](https://img.shields.io/docker/pulls/robertbeal/homeassistant.svg)](https://hub.docker.com/r/robertbeal/homeassistant/)
[![](https://img.shields.io/docker/stars/robertbeal/homeassistant.svg)](https://hub.docker.com/r/robertbeal/homeassistant/)
[![](https://img.shields.io/docker/automated/robertbeal/homeassistant.svg)](https://hub.docker.com/r/robertbeal/homeassistant/)
```
docker create \
	--name homeassistant \
	--user $(id homeassistant -u):$(id homeassistant -g) \
	--net host \
	--volume /home/homeassistant/config:/config \
	-p 8123:8123 -p 8300:8300 \
        --health-cmd="curl --fail http://localhost:8123/api || exit 1" \
        --health-interval=5s \
        --health-retries=3 \
	robertbeal/homeassistant
```
