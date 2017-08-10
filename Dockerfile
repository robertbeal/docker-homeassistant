FROM arm32v6/alpine:latest

WORKDIR /tmp

RUN addgroup -S homeassistant && adduser -h /app -G homeassistant -S homeassistant

RUN apk add --update --no-cache --virtual=build-dependencies \
		gcc \
		g++ \
                glib-dev \
		make \
		libffi-dev \
		openssl-dev \
		python3-dev \
		# bluez dependencies
                wget \
                dbus-dev \
                eudev-dev \
                libical-dev \
                readline-dev \
                linux-headers \

        && wget --no-check-certificate https://www.kernel.org/pub/linux/bluetooth/bluez-5.43.tar.gz \
        && tar -xzf bluez-5.43.tar.gz \
        && cd bluez-5.43 \
        && ./configure --disable-systemd \
        && make \
        && cp attrib/gatttool /usr/local/bin \

	&& apk add --no-cache \
		glib \		
		openssh \        	
		python3 \

        && cd /data \
	&& python3 -m venv . \
        && source bin/activate \
        && python3 -m pip install \
		homeassistant \
		pycrypto \

	&& apk del --purge build-dependencies \
	&& rm -rf /tmp/*

WORKDIR /app
RUN chown -R homeassistant:homeassistant .

USER homeassistant
EXPOSE 8123
ENTRYPOINT ["bin/hass"]

