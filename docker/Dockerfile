FROM alpine:3.18.6

ENV LIGHTTPD_VERSION=1.4.73-r0
ENV DCATAPPLU_VERSION=../drafts/0.0.1-draft-0.1

RUN addgroup -S --gid 1000 lighttpd \
    && adduser -S -G lighttpd --uid 1000 lighttpd

RUN apk add --update --no-cache lighttpd=${LIGHTTPD_VERSION} curl \
    && rm -rf /var/cache/apk/* \
    && chgrp lighttpd /usr/sbin/lighttpd

COPY --chown=:lighttpd ./docker/lighttpd.conf /etc/lighttpd/lighttpd.conf

WORKDIR /var/www/html
COPY --chown=:lighttpd ./releases/${DCATAPPLU_VERSION}/codelists ./resource
COPY --chown=:lighttpd ./releases/${DCATAPPLU_VERSION}/doc-plu.html ./doc-plu-latest.html
COPY --chown=:lighttpd ./releases/${DCATAPPLU_VERSION}/DCAT-AP-PLU.JPG .
COPY --chown=:lighttpd ./releases/${DCATAPPLU_VERSION}/styles ./styles
COPY --chown=:lighttpd ./docker/static .
RUN find . -name "index.html" -exec sed -i "s@{DCATAPPLU_VERSION}@${DCATAPPLU_VERSION}@g" {} +

EXPOSE 8080 443

USER lighttpd

ENTRYPOINT ["/usr/sbin/lighttpd"]
CMD ["-D", "-f", "/etc/lighttpd/lighttpd.conf"]