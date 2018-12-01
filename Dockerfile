FROM alpine:3.7
LABEL maintainer="github.com/robertbeal"

WORKDIR /tmp
ARG VERSION=0.72.1

RUN adduser -s /bin/false -D -h /app -u 4900 homeassistant \
  && apk add --no-cache \
    curl \
    findutils \
    glib \
    iputils \
    openssh-client \
    python3 \
    su-exec

HEALTHCHECK --interval=30s --retries=3 CMD curl --fail http://localhost:8123/api/ || exit 1
VOLUME /config
EXPOSE 8123

RUN apk add --no-cache --virtual=build-dependencies \
    alpine-sdk \
    autoconf \
    eudev-dev \
    glib-dev \
    jpeg-dev \
    libffi-dev \
    libressl-dev \
    libxml2-dev \
    libxslt-dev \
    linux-headers \
    mariadb-dev \
    python3-dev \
    zlib-dev \
  && python3 -m pip install homeassistant==$VERSION \
  && curl -L https://github.com/home-assistant/home-assistant/archive/$VERSION.tar.gz | tar zx \
  && LIBRARY_PATH=/lib:/usr/lib /bin/sh -c "python3 -m pip install -r /tmp/home-assistant-$VERSION/requirements_all.txt" \
  && apk del --purge build-dependencies \
  && rm -rf /tmp/*

WORKDIR /config
COPY entrypoint.sh /usr/local/bin

ENTRYPOINT ["entrypoint.sh"]
CMD ["--skip-pip", "--config", "/config"]
