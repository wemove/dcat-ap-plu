FROM alpine:3.18.3

ENV LIGHTTPD_VERSION=1.4.71-r0
RUN apk add --update --no-cache lighttpd=${LIGHTTPD_VERSION} \
    && rm -rf /var/cache/apk/* \
    && chown lighttpd:lighttpd /usr/sbin/lighttpd

COPY --chown=lighttpd:lighttpd ./docker/lighttpd.conf /etc/lighttpd/lighttpd.conf

ENV DCATAPPLU_VERSION=0.1.0
WORKDIR /var/www/html
COPY --chown=lighttpd:lighttpd ./releases/${DCATAPPLU_VERSION}/codelists ./resource
COPY --chown=lighttpd:lighttpd ./docker/static .

EXPOSE 8080 443

USER lighttpd

ENTRYPOINT ["/usr/sbin/lighttpd"]
CMD ["-D", "-f", "/etc/lighttpd/lighttpd.conf"]