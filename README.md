
```
docker create \
	--name homeassistant \
	--user $(id homeassistant -u):$(id homeassistant -g) \
	--net host \
	--volume /home/homeassistant/config:/config \
	-p 8123:8123 -p 8300:8300 \
	-t robertbeal/homeassistant
```
