FROM arm32v6/alpine:3.6

WORKDIR /tmp

RUN adduser -s /bin/false -D -h /app homeassistant

# bluez
RUN apk add --update --no-cache --virtual=build-dependencies \
	alpine-sdk \	
	dbus-dev \
	eudev-dev \
	glib-dev \
	libical-dev \
	linux-headers \
	readline-dev \
        wget \

	&& wget --no-check-certificate https://www.kernel.org/pub/linux/bluetooth/bluez-5.43.tar.gz \
	&& tar -xzf bluez-5.43.tar.gz \
	&& cd bluez-5.43 \
	&& ./configure --disable-systemd \
	&& make \
	&& cp attrib/gatttool /usr/local/bin \
	&& apk del --purge build-dependencies \
	&& rm -rf /tmp/*

# homeassistant
RUN apk add --update --no-cache --virtual=build-dependencies \
	alpine-sdk \
	libffi-dev \
	openssl-dev \
	python3-dev \

	&& apk add --no-cache \
	glib \
	openssh \
	python3 \
	su-exec \
	tini \

	&& cd /app \
	&& python3 -m venv . \
	&& source bin/activate \
	&& python3 -m pip install \
	homeassistant \
	pycrypto \

	&& apk del --purge build-dependencies \
	&& rm -rf /tmp/*

EXPOSE 8123

COPY entrypoint.sh /usr/local/bin
ENTRYPOINT ["/sbin/tini", "--", "entrypoint.sh"]
CMD ["/app/bin/hass"]
