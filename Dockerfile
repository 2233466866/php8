FROM ubuntu:plucky-20250402
# 全局准备
RUN echo 'Asia/Shanghai' > /etc/timezone;\
echo 'deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ plucky main restricted universe multiverse' >> /etc/apt/sources.list;\
echo 'deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ plucky-updates main restricted universe multiverse' >> /etc/apt/sources.list;\
echo 'deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ plucky-backports main restricted universe multiverse' >> /etc/apt/sources.list;\
echo 'deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ plucky-security main restricted universe multiverse' >> /etc/apt/sources.list;\
echo '# deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ plucky main restricted universe multiverse' >> /etc/apt/sources.list;\
echo '# deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ plucky-updates main restricted universe multiverse' >> /etc/apt/sources.list;\
echo '# deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ plucky-backports main restricted universe multiverse' >> /etc/apt/sources.list;\
echo '# deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ plucky-security main restricted universe multiverse' >> /etc/apt/sources.list;\
apt update;\
apt modernize-sources -y;\
apt install -y vim git curl wget;\
apt install -y automake autoconf make cmake gcc-13 g++-13 build-essential;\
apt install -y pkg-config libxml2-dev openssl libssl-dev libmemcached-dev libsqlite3-dev libpq-dev libcares2 liburing-dev zip unzip libzip-dev zlib1g zlib1g-dev libcurl4-openssl-dev libonig-dev libpng-dev libgd-dev;\
# 代码目录
mkdir /www;\
useradd www;\
chown -R www:www /www;\
# 开始安装
cd /root;\
wget --no-check-certificate -c https://n.so1234.top/1centos/PHP/php-8.4.6.tar.gz;\
tar -xf php-8.4.6.tar.gz;\
cd /root/php-8.4.6;\
./configure \
--prefix=/usr/local/php8 \
--enable-mysqlnd \
--enable-sockets \
--with-openssl \
--with-expat \
--enable-fpm \
--enable-zts;\
make;\
make install;\
echo 'export PATH=$PATH:/usr/local/php8/bin' >> /etc/profile;\
echo 'export PATH=$PATH:/usr/local/php8/sbin' >> /etc/profile;\
source /etc/profile;\
wget --no-check-certificate -c https://n.so1234.top/1centos/PHP/php8.ini -O /usr/local/php8/lib/php.ini;\
wget --no-check-certificate -c https://n.so1234.top/1centos/PHP/php8-fpm.conf -O /usr/local/php8/etc/php-fpm.conf;\
wget --no-check-certificate -c https://n.so1234.top/1centos/PHP/www8.conf -O /usr/local/php8/etc/php-fpm.d/www.conf;\
wget --no-check-certificate -c https://n.so1234.top/1centos/PHP/cacert.pem -O /usr/local/php8/lib/cacert.pem;\
wget --no-check-certificate -c https://n.so1234.top/1centos/PHP/composer8 -O /usr/local/php8/bin/composer;\
wget --no-check-certificate -c https://n.so1234.top/1centos/PHP/pecl8 -O /usr/local/php8/bin/pecl;\
chmod -R 755 /usr/local/php8/bin/composer;\
chmod -R 755 /usr/local/php8/bin/pecl;\
# bcmath
cd /root/php-8.4.6/ext/bcmath;\
/usr/local/php8/bin/phpize;\
./configure --with-php-config=/usr/local/php8/bin/php-config;\
make;\
make install;\
# bz2
cd /root/php-8.4.6/ext/bz2;\
/usr/local/php8/bin/phpize;\
./configure --with-php-config=/usr/local/php8/bin/php-config;\
make;\
make install;\
# calendar
cd /root/php-8.4.6/ext/calendar;\
/usr/local/php8/bin/phpize;\
./configure --with-php-config=/usr/local/php8/bin/php-config;\
make;\
make install;\
# curl
cd /root/php-8.4.6/ext/curl;\
/usr/local/php8/bin/phpize;\
./configure --with-php-config=/usr/local/php8/bin/php-config;\
make;\
make install;\
# gd
cd /root/php-8.4.6/ext/gd;\
/usr/local/php8/bin/phpize;\
./configure --with-php-config=/usr/local/php8/bin/php-config \
--with-external-gd \
--with-freetype \
--with-gnu-ld \
--with-avif \
--with-webp \
--with-jpeg \
--with-xpm \
--with-pic \
--enable-gd \
--enable-gd-jis-conv;\
make;\
make install;\
# intl
cd /root/php-8.4.6/ext/intl;\
/usr/local/php8/bin/phpize;\
./configure --with-php-config=/usr/local/php8/bin/php-config;\
make;\
make install;\
# mbstring
cd /root/php-8.4.6/ext/mbstring;\
/usr/local/php8/bin/phpize;\
./configure --with-php-config=/usr/local/php8/bin/php-config;\
make;\
make install;\
# mysqli
cd /root/php-8.4.6/ext/mysqli;\
/usr/local/php8/bin/phpize;\
./configure --with-php-config=/usr/local/php8/bin/php-config;\
make;\
make install;\
# opcache
cd /root/php-8.4.6/ext/opcache;\
/usr/local/php8/bin/phpize;\
./configure --with-php-config=/usr/local/php8/bin/php-config;\
make;\
make install;\
# pcntl
cd /root/php-8.4.6/ext/pcntl;\
/usr/local/php8/bin/phpize;\
./configure --with-php-config=/usr/local/php8/bin/php-config;\
make;\
make install;\
# pdo_mysql
cd /root/php-8.4.6/ext/pdo_mysql;\
/usr/local/php8/bin/phpize;\
./configure --with-php-config=/usr/local/php8/bin/php-config;\
make;\
make install;\
# pdo_pgsql
cd /root/php-8.4.6/ext/pdo_pgsql;\
/usr/local/php8/bin/phpize;\
./configure --with-php-config=/usr/local/php8/bin/php-config;\
make;\
make install;\
# zip
cd /root/php-8.4.6/ext/zip;\
/usr/local/php8/bin/phpize;\
./configure --with-php-config=/usr/local/php8/bin/php-config;\
make;\
make install;\
# zlib
cd /root/php-8.4.6/ext/zlib;\
cp config0.m4 config.m4;\
/usr/local/php8/bin/phpize;\
./configure --with-php-config=/usr/local/php8/bin/php-config;\
make;\
make install;\
# redis
cd /root/php-8.4.6/ext;\
wget --no-check-certificate -c https://n.so1234.top/1centos/PHP/redis-6.2.0.tgz;\
tar -xf redis-6.2.0.tgz;\
cd /root/php-8.4.6/ext/redis-6.2.0;\
/usr/local/php8/bin/phpize;\
./configure --with-php-config=/usr/local/php8/bin/php-config;\
make;\
make install;\
# memcache
cd /root/php-8.4.6/ext;\
wget --no-check-certificate -c https://n.so1234.top/1centos/PHP/memcache-8.2.tgz;\
tar -xf memcache-8.2.tgz;\
cd /root/php-8.4.6/ext/memcache-8.2;\
/usr/local/php8/bin/phpize;\
./configure --with-php-config=/usr/local/php8/bin/php-config;\
make;\
make install;\
# memcached
cd /root/php-8.4.6/ext;\
wget --no-check-certificate -c https://n.so1234.top/1centos/PHP/memcached-3.3.0.tgz;\
tar -xf memcached-3.3.0.tgz;\
cd /root/php-8.4.6/ext/memcached-3.3.0;\
/usr/local/php8/bin/phpize;\
./configure --with-php-config=/usr/local/php8/bin/php-config;\
make;\
make install;\
# mongodb
cd /root/php-8.4.6/ext;\
wget --no-check-certificate -c https://n.so1234.top/1centos/PHP/mongodb-2.0.0.tgz;\
tar -xf mongodb-2.0.0.tgz;\
cd /root/php-8.4.6/ext/mongodb-2.0.0;\
/usr/local/php8/bin/phpize;\
./configure --with-php-config=/usr/local/php8/bin/php-config;\
make;\
make install;\
# swoole
cd /root/php-8.4.6/ext;\
wget --no-check-certificate -c https://n.so1234.top/1centos/PHP/swoole-6.0.2.tgz;\
tar -xf swoole-6.0.2.tgz;\
cd /root/php-8.4.6/ext/swoole-6.0.2;\
/usr/local/php8/bin/phpize;\
./configure --with-php-config=/usr/local/php8/bin/php-config \
--enable-sockets \
--enable-openssl \
--enable-swoole \
--enable-mysqlnd \
--enable-iouring \
--enable-brotli \
--enable-zstd \
--enable-asan \
--enable-swoole-coverage \
--enable-swoole-dev \
--enable-swoole-curl \
--enable-swoole-pgsql \
--enable-thread-context \
--enable-swoole-coro-time \
--enable-swoole-sqlite \
--enable-debug-log \
--enable-trace-log \
--enable-debug;\
make;\
make install;\
# 权限修改
chown -R www:www /usr/local/php8;\
# 镜像清理
rm -rf /root/php-8.4.6.tar.gz;\
rm -rf /root/php-8.4.6;\
# 环境变量
ENV PATH $PATH:/usr/local/php8/bin:/usr/local/php8/sbin
# 创建卷
VOLUME ["/www"]
# 初始化
CMD ["/usr/local/php8/sbin/php-fpm"]
