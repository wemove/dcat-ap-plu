FROM alpine:3.18.2

ENV LIGHTTPD_VERSION=1.4.71-r0
RUN apk add --update --no-cache lighttpd=${LIGHTTPD_VERSION} \
    && rm -rf /var/cache/apk/* \
    && chown lighttpd:lighttpd /usr/sbin/lighttpd

COPY --chown=lighttpd:lighttpd ./docker/lighttpd.conf /etc/lighttpd/lighttpd.conf

WORKDIR /var/www/html
COPY --chown=lighttpd:lighttpd ./drafts/0.0.1-draft-0.1/codelists ./resource
COPY --chown=lighttpd:lighttpd ./docker/static .

EXPOSE 8080 443

USER lighttpd

ENTRYPOINT ["/usr/sbin/lighttpd"]
CMD ["-D", "-f", "/etc/lighttpd/lighttpd.conf"]