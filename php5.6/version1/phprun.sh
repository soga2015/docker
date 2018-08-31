#!/bin/bash
/etc/init.d/php-fpm start
tail -F /var/log/messages
