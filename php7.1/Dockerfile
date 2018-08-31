FROM centos:latest
MAINTAINER biaolian@xmisp.com


#RUN curl -fSL http://mirrors.163.com/.help/CentOS6-Base-163.repo -o /etc/yum.repos.d/CentOS6-Base-163.repo
#RUN yum makecache
RUN yum -y install git vim wget curl-devel curl tar gcc gcc-c++ gcc-g77 make libtool autoconf  automake  libxml2 libxml2-devel libtool-ltdl-devel libtool-ltdl libmcrypt libmcrypt-devel libpng libpng-devel libjpeg-devel openssl openssl-devel gd-devel gd cmake  bzip2 bzip2-devel readline-devel

#RUN yum -y install pcre pcre-*
RUN groupadd -g 1051 www && useradd -u 1051 -g www -s /sbin/nologin www

#nginx
#
#
#
RUN set -xe \
    && cd /usr/src \
    && curl -fSL http://oss.aliyuncs.com/aliyunecs/onekey/freetype-2.1.10.tar.gz -o freetype-2.1.10.tar.gz \
    && tar -zxvf freetype-2.1.10.tar.gz \
    && curl -fSL http://oss.aliyuncs.com/aliyunecs/onekey/libpng-1.2.50.tar.gz -o libpng-1.2.50.tar.gz \
    && tar -zxvf libpng-1.2.50.tar.gz \
    && curl -fSL http://oss.aliyuncs.com/aliyunecs/onekey/libevent-1.4.14b.tar.gz -o libevent-1.4.14b.tar.gz \
    && tar -zxvf libevent-1.4.14b.tar.gz \
    && curl -fSL http://oss.aliyuncs.com/aliyunecs/onekey/libmcrypt-2.5.8.tar.gz -o libmcrypt-2.5.8.tar.gz \
    && tar -zxvf libmcrypt-2.5.8.tar.gz \
    && curl -fSL http://oss.aliyuncs.com/aliyunecs/onekey/jpegsrc.v6b.tar.gz -o jpegsrc.v6b.tar.gz \
    && tar -zxvf jpegsrc.v6b.tar.gz \
    && curl -fSL http://117.25.183.19:896/PACKAGE/php-7.1.8.tar.gz  -o php-7.1.8.tar.gz \
    && tar -zxvf php-7.1.8.tar.gz \
	&& curl -fSL http://archive.apache.org/dist/zookeeper/zookeeper-3.4.8/zookeeper-3.4.8.tar.gz -o zookeeper-3.4.8.tar.gz \
	&& tar -zxvf zookeeper-3.4.8.tar.gz \
	&& curl -fSL https://pecl.php.net/get/zookeeper-0.6.2.tgz -o zookeeper-0.6.2.tgz \
	&& tar -zxvf zookeeper-0.6.2.tgz \
	&& curl -fSL http://117.25.183.19:896/PACKAGE/jdk-8u161-linux-x64.tar.gz -o jdk-8u161-linux-x64.tar.gz \
	&& tar -zxvf jdk-8u161-linux-x64.tar.gz
	

RUN set -xe \
    && cd /usr/src/freetype-2.1.10 \
    && ./configure --prefix=/usr/local/freetype.2.1.10 && make && make install


RUN set -xe \
    && cd /usr/src/libpng-1.2.50 \
    && ./configure --prefix=/usr/local/libpng.1.2.50 && make && make install


RUN set -xe \
    && cd /usr/src/libevent-1.4.14b \
    && ./configure && make && make install


RUN set -xe \
    && cd /usr/src/libmcrypt-2.5.8 \
    && ./configure --disable-posix-threads && make && make install \
    && /sbin/ldconfig \
    && cd libltdl/ \
    && ./configure --enable-ltdl-install && make && make install

RUN set -xe \
    && cd /usr/src/jpeg-6b \
    && cp -f /usr/share/libtool/config/config.guess . \
    && cp -f /usr/share/libtool/config/config.sub . \
    && mkdir -p /usr/local/jpeg.6/include \
    && mkdir /usr/local/jpeg.6/lib \
    && mkdir /usr/local/jpeg.6/bin \
    && mkdir -p /usr/local/jpeg.6/man/man1 \
    && ./configure --prefix=/usr/local/jpeg.6 --enable-shared --enable-static && make && make install-lib && make install




###php7.1
#php7已禁用该函数
#        #--with-mysql=mysqlnd \
RUN set -xe \
    && echo "/usr/local/lib" >>/etc/ld.so.conf.d/local.conf \
    && ldconfig -v \
    && cd /usr/src/php-7.1.8 \
    && ./configure --prefix=/xmisp/server/php/php-7.1.8 \
        --enable-opcache \
        --with-config-file-path=/xmisp/server/php/php-7.1.8/etc \
        --with-mysqli=mysqlnd \
        --with-pdo-mysql=mysqlnd \
        --with-fpm-user=www \
        --with-fpm-group=www \
        --with-zlib \
        --with-iconv \
        --with-xmlrpc \
        --with-curl \
        --with-mcrypt \
        --with-freetype-dir=/usr/local/freetype.2.1.10 \
        --with-jpeg-dir=/usr/local/jpeg.6 \
        --with-png-dir=/usr/local/libpng.1.2.50 \
        --with-gettext \
        --with-mhash \
        --with-libxml-dir \
        --with-bz2 \
        --with-readline \
        --with-openssl \
        --disable-maintainer-zts \
        --disable-rpath \
        --disable-ipv6 \
        --disable-debug \
        --enable-fileinfo \
        --enable-pcntl \
        --enable-sockets \
        --enable-wddx \
        --enable-zip \
        --enable-calendar \
        --enable-bcmath \
        --enable-soap \
        --enable-shmop \
        --enable-sysvmsg \
        --enable-sysvsem \
        --enable-sysvshm \
        --enable-mbstring \
        --enable-fpm \
        --enable-static \
        --enable-pcntl \
        --enable-inline-optimization



RUN set -xe \
    && cd /usr/src/php-7.1.8 \
    && make \
    && make install \
    && cp php.ini-production /xmisp/server/php/php-7.1.8/etc/php.ini


RUN set -xe \
    && sed -i 's#; extension_dir = \"\.\/\"#extension_dir = "/xmisp/server/php/php-7.1.8/lib/php/extensions/no-debug-non-zts-20160303/"#' /xmisp/server/php/php-7.1.8/etc/php.ini \
	&& sed -i 's/post_max_size = 8M/post_max_size = 64M/g' /xmisp/server/php/php-7.1.8/etc/php.ini \
    && sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 64M/g' /xmisp/server/php/php-7.1.8/etc/php.ini \
    && sed -i 's/;date.timezone =/date.timezone = PRC/g' /xmisp/server/php/php-7.1.8/etc/php.ini \
    && sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/g' /xmisp/server/php/php-7.1.8/etc/php.ini \
    && sed -i 's/max_execution_time = 30/max_execution_time = 300/g' /xmisp/server/php/php-7.1.8/etc/php.ini \
    && cp /xmisp/server/php/php-7.1.8/etc/php-fpm.conf.default /xmisp/server/php/php-7.1.8/etc/php-fpm.conf \
    && cp /xmisp/server/php/php-7.1.8/etc/php-fpm.d/www.conf.default /xmisp/server/php/php-7.1.8/etc/php-fpm.d/php-fpm.conf \
    && sed -i 's,user = nobody,user=www,g' /xmisp/server/php/php-7.1.8/etc/php-fpm.d/php-fpm.conf \
    && sed -i 's,group = nobody,group=www,g' /xmisp/server/php/php-7.1.8/etc/php-fpm.d/php-fpm.conf \
    && sed -i 's,^pm.min_spare_servers = 1,pm.min_spare_servers = 5,g' /xmisp/server/php/php-7.1.8/etc/php-fpm.d/php-fpm.conf \
    && sed -i 's,^pm.max_spare_servers = 3,pm.max_spare_servers = 35,g' /xmisp/server/php/php-7.1.8/etc/php-fpm.d/php-fpm.conf \
    && sed -i 's,^pm.max_children = 5,pm.max_children = 100,g' /xmisp/server/php/php-7.1.8/etc/php-fpm.d/php-fpm.conf \
    && sed -i 's,^pm.start_servers = 2,pm.start_servers = 20,g' /xmisp/server/php/php-7.1.8/etc/php-fpm.d/php-fpm.conf \
    && sed -i 's,;pid = run/php-fpm.pid,pid = run/php-fpm.pid,g' /xmisp/server/php/php-7.1.8/etc/php-fpm.d/php-fpm.conf \
    && sed -i 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g' /xmisp/server/php/php-7.1.8/etc/php-fpm.d/php-fpm.conf \
    #php缓存写入redis,要启一个redis做关联
#&& sed -i 's/session.save_handler = files/session.save_handler = redis/g' /xmisp/server/php/php-7.1.8/etc/php.ini \
#&& sed -i 's/;session.save_path = "\/tmp"/session.save_path = "tcp:\/\/redis:6379"/g' /xmisp/server/php/php-7.1.8/etc/php.ini \
    && cd /usr/src/php-7.1.8 \
    && install -v -m755 sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm





RUN set -xe \
    && /xmisp/server/php/php-7.1.8/bin/pecl install redis \
    && echo "extension=redis.so" >> /xmisp/server/php/php-7.1.8/etc/php.ini



RUN set -xe \
    && ./xmisp/server/php/php-7.1.8/bin/pecl install mongodb \
    && echo "extension=mongodb.so" >> /xmisp/server/php/php-7.1.8/etc/php.ini



RUN set -xe \
    && cd /usr/src/php-7.1.8/ext/gd \
    && /xmisp/server/php/php-7.1.8/bin/phpize \
    && ./configure --with-php-config=/xmisp/server/php/php-7.1.8/bin/php-config \
    && make && make install \
    && echo "extension=gd.so" >> /xmisp/server/php/php-7.1.8/etc/php.ini \
    && chown www.www -R /xmisp/server/php
	
RUN set -xe \
	&& cd /xmisp/server \
	&& cp -rf /usr/src/jdk1.8.0_161 .

RUN set -xe \
	&& cd /xmisp/server \
	&& cp -rf /usr/src/zookeeper-3.4.8 . \
	&& cd /xmisp/server/zookeeper-3.4.8/src/c \
	&& ./configure --prefix=/xmisp/server/zookeeper

RUN set -xe \
	&& make \
    && make install

RUN set -xe \
	&& cd /usr/src/zookeeper-0.6.2 \
	&& /xmisp/server/php/php-7.1.8/bin/phpize \
	&& ./configure --with-php-config=/xmisp/server/php/php-7.1.8/bin/php-config -with-libzookeeper-dir=/xmisp/server/zookeeper/
	
RUN set -xe \
	&& make \
    && make install
	
RUN set -xe \
	&& echo "extension=zookeeper.so" >> /xmisp/server/php/php-7.1.8/etc/php.ini

RUN set -xe \
	&& mkdir /home/data \
	&& mkdir /home/data/zoo \
	&& cp -f /xmisp/server/zookeeper-3.4.8/conf/zoo_sample.cfg /xmisp/server/zookeeper-3.4.8/conf/zoo.cfg \
	&& sed -i 's/dataDir=\/tmp\/zookeeper/dataDir=\/home\/data\/zoo/g' /xmisp/server/zookeeper-3.4.8/conf/zoo.cfg
    
	

ENV PATH /xmisp/server/php/php-7.1.8/sbin:/xmisp/server/php/php-7.1.8/bin:$PATH
ENV JAVA_HOME /usr/java/jdk1.8.0_161
ENV CLASSPATH $JAVA_HOME/lib/
ENV PATH $PATH:$JAVA_HOME/bin

RUN set -xe \
	&& curl https://install.phpcomposer.com/installer | php \
	&& mv composer.phar /usr/local/bin/composer \
    && yum clean packages \
    && yum clean headers \
    && yum clean all \
    && rm -rf /usr/src/*.tar.gz


WORKDIR /xmisp/server/php
EXPOSE 9000

ENTRYPOINT ["/xmisp/server/php/php-7.1.8/sbin/php-fpm","-F"]


