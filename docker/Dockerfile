FROM alpine:3.18.3

ENV LIGHTTPD_VERSION=1.4.71-r0
ENV DCATAPPLU_VERSION=0.1.0

RUN addgroup -S --gid 1000 lighttpd \
    && adduser -S -G lighttpd --uid 1000 lighttpd

RUN apk add --update --no-cache lighttpd=${LIGHTTPD_VERSION} \
    && rm -rf /var/cache/apk/* \
    && chgrp lighttpd /usr/sbin/lighttpd

COPY --chown=:lighttpd ./docker/lighttpd.conf /etc/lighttpd/lighttpd.conf

WORKDIR /var/www/html
COPY --chown=:lighttpd ./releases/${DCATAPPLU_VERSION}/codelists ./resource
COPY --chown=:lighttpd ./docker/static .

EXPOSE 8080 443

USER lighttpd

ENTRYPOINT ["/usr/sbin/lighttpd"]
CMD ["-D", "-f", "/etc/lighttpd/lighttpd.conf"]