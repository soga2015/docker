FROM prooph/php:7.2-fpm

RUN apk add --no-cache supervisor && \
    addgroup -S supervisor && adduser -D -S -s /sbin/nologin -G supervisor supervisor && \
    mkdir -p /etc/supervisor/conf.d && chown -R supervisor:supervisor /etc/supervisor && \
    /usr/bin/supervisord --version

ADD supervisord.conf /etc/supervisor/supervisord.conf

VOLUME ["/etc/supervisor/conf.d"]
WORKDIR /home/www

CMD ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]
