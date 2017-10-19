
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
	-t robertbeal/homeassistant
```
