FROM alpine:3.21.3

# ENV LIGHTTPD_VERSION=1.4.76-r0
ENV DCATAPPLU_VERSION=0.2.4

RUN addgroup -S --gid 1000 lighttpd \
    && adduser -S -G lighttpd --uid 1000 lighttpd

# RUN apk add --update --no-cache lighttpd=${LIGHTTPD_VERSION} \
RUN apk add --update --no-cache lighttpd \
    && rm -rf /var/cache/apk/* \
    && chgrp lighttpd /usr/sbin/lighttpd

COPY --chown=:lighttpd ./docker/lighttpd.conf /etc/lighttpd/lighttpd.conf

WORKDIR /var/www/html
COPY --chown=:lighttpd ./releases/${DCATAPPLU_VERSION}/codelists ./resource
COPY --chown=:lighttpd ./releases/${DCATAPPLU_VERSION}/doc-plu.html ./doc-plu-latest.html
COPY --chown=:lighttpd ./releases/${DCATAPPLU_VERSION}/DCAT-AP-PLU.JPG .
COPY --chown=:lighttpd ./releases/${DCATAPPLU_VERSION}/styles ./styles
COPY --chown=:lighttpd ./releases ./releases
COPY --chown=:lighttpd ./docker/static .
RUN find . -name "index.html" -exec sed -i "s@{DCATAPPLU_VERSION}@${DCATAPPLU_VERSION}@g" {} + && \
    for version in $(ls -d ./releases/* | xargs -n 1 basename); do \
        list_items="${list_items}<li><a href=\"./${version}/\" title=\"Dokumentation zu DCAT-AP.PLU Release ${version}\">${version}</a></li>"; \
    done && echo "list_items: ${list_items}" && \
    sed -i "s@{RELEASES}@${list_items}@" ./index.html

EXPOSE 8080 443

USER lighttpd

ENTRYPOINT ["/usr/sbin/lighttpd"]
CMD ["-D", "-f", "/etc/lighttpd/lighttpd.conf"]