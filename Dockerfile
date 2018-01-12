FROM arm32v6/alpine:3.7

WORKDIR /tmp

# bluez
ENV BLUEZ_VERSION=5.43

RUN apk add --update --no-cache --virtual=build-dependencies \
  alpine-sdk \
  dbus-dev \
  eudev-dev \
  glib-dev \
  libical-dev \
  linux-headers \
  readline-dev \
  wget \

  && wget --no-check-certificate https://www.kernel.org/pub/linux/bluetooth/bluez-${BLUEZ_VERSION}.tar.gz \
  && tar -xzf bluez-${BLUEZ_VERSION}.tar.gz \
  && cd bluez-${BLUEZ_VERSION} \
  && ./configure --disable-systemd \
  && make \
  && cp attrib/gatttool /usr/local/bin \
  && apk del --purge build-dependencies \
  && rm -rf /tmp/*

# homeassistant
ENV HASS_VERSION=0.60

RUN adduser -s /bin/false -D -h /app -u 4900 homeassistant

RUN apk add --update --no-cache --virtual=build-dependencies \
  alpine-sdk \
  libffi-dev \
  mariadb-dev \
  libressl-dev \
  python3-dev \

  && apk add --no-cache \
  curl \
  glib \
  mariadb-client-libs \
  openssh \
  python3 \
  su-exec \
  tini \

  && cd /app \
  && python3 -m venv . \
  && source bin/activate \
  && python3 -m pip install \
  homeassistant==$HASS_VERSION \
  mysqlclient \
  pycrypto \
  PyXiaomiGateway \

  && apk del --purge build-dependencies \
  && rm -rf /tmp/*

WORKDIR /config
VOLUME /config
EXPOSE 8123

COPY entrypoint.sh /usr/local/bin
ENTRYPOINT ["/sbin/tini", "--", "entrypoint.sh"]
CMD ["/app/bin/hass", "--config", "/config"]
