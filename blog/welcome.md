<!--
author: 沈涛
head: http://pingodata.qiniudn.com/jockchou-avatar.jpg
date: 2016-06-02
title: php7搭建
tags: linux
category: linux
status: publish
summary: 
-->

wget http://cn2.php.net/get/php-7.0.4.tar.bz2/from/this/mirror -O php-7.0.4.tar.bz2

tar -jxvf php-7.0.4.tar.bz2

yum install -y libmcrypt-devel

cd php-7.0.4

//如果配置错误，需要安装需要的模块，直接yum一并安装依赖库
//# yum -y install libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libxml2 libxml2-devel MySQL pcre-devel
//
//注意：安装php7beta3的时候有几处配置不过去，需要yum一下，现在php-7.0.2已经不用这样了。
//# yum -y install curl-devel
//# yum -y install libxslt-devel

./configure --prefix=/application/system/php7 --with-config-file-path=/application/system/php7/etc --with-config-file-scan-dir=/application/system/php7/etc/conf.d --with-mysqli --enable-mysqlnd --enable-pdo --with-pdo-mysql --enable-mbstring --with-openssl --with-openssl-dir --with-gd --with-jpeg-dir --with-png-dir --with-freetype-dir --with-zlib --with-libxml-dir --enable-gd-native-ttf --enable-ftp --enable-json --with-curl --with-mhash --enable-tokenizer --enable-ctype --enable-dom --enable-fileinfo --enable-filter --enable-phar --enable-sockets --enable-soap --with-pear --enable-opcache --enable-fpm --with-fpm-user=apache --with-fpm-group=apache --with-mcrypt

make && make install

#test
cp php.ini-development /application/system/php7/etc/php.ini
#stagging and production
cp php.ini-production /application/system/php7/etc/php.ini



vim /application/system/php7/etc/php.ini
# for stagging and production
# disable php info
>>>expose_php = Off
# open opcache
>>>opcache.enable=1
>>>opcache.enable_cli=1
>>>opcache.memory_consumption=128
>>>opcache.interned_strings_buffer=8
>>>opcache.max_accelerated_files=4000
>>>opcache.max_wasted_percentage=5
>>>opcache.use_cwd=1
>>>opcache.validate_timestamps=1
>>>opcache.revalidate_freq=60
>>>opcache.save_comments=1


#copy init.d file 
cp sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod +x /etc/init.d/php-fpm
chkconfig --add php-fpm
chkconfig php-fpm on

#install redis support for php
git clone https://github.com/phpredis/phpredis.git

cd phpredis/
git checkout php7

/application/system/php7/bin/phpize

./configure --with-php-config=/application/system/php7/bin/php-config

make && make install

ln -s /application/system/php7/bin/php /usr/local/bin/php7

vim /application/system/php7/etc/php.ini
>>>[redis]
>>>extension=redis.so


cd /application/system/php7/etc/php-fpm.d/
cp www.conf.default htn_hub_wechat.conf
vim htn_hub_wechat.conf
diff www.conf.default htn_hub_wechat.conf







4c4
< [www]
---
> [htn_wechat]
18c18
< ;prefix = /path/to/pools/$pool
---
> prefix =/application/wwwroot_logs/$pool 
107c107
< pm.max_children = 5
---
> pm.max_children = 20
253c253
< ;access.log = log/$pool.access.log
---
> access.log = $pool.access.log
317c317
< ;slowlog = log/$pool.log.slow
---
> slowlog = log/$pool.log.slow
410,413c410,413
< ;php_flag[display_errors] = off
< ;php_admin_value[error_log] = /var/log/fpm-php.www.log
< ;php_admin_flag[log_errors] = on
< ;php_admin_value[memory_limit] = 32M
---
> php_flag[display_errors] = off
> php_admin_value[error_log] = /application/wwwroot_logs/$pool/$pool.error.log
> php_admin_flag[log_errors] = on
> php_admin_value[memory_limit] = 128M


cd /application/system/php7/etc
cp php-fpm.conf.default php-fpm.conf


php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer
composer config -g repo.packagist composer https://packagist.phpcomposer.com

wget https://nodejs.org/dist/v5.8.0/node-v5.8.0-linux-x64.tar.xz
tar -Jxvf node-v5.8.0-linux-x64.tar.xz
mv node-v5.8.0-linux-x64 /application/system/node/

vim /etc/profile
>>>export PATH="$PATH:/application/system/php/bin:/application/system/node/bin"

export PATH="$PATH:/application/system/node/bin"

npm install -g cnpm --registry=https://registry.npm.taobao.org

# install gulp support all system
cnpm install --global gulp

# init gulp in laravel root folder
cnpm install


# enable apache support php-fpm
vim /application/system/apache/conf/httpd.conf
>>>LoadModule proxy_module modules/mod_proxy.so
>>>LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so


# configure for nov.zz-med-stg.com in /application/system/apache/conf/extra/httpd-vhosts-zz-med-stg.conf
vim /application/system/apache/conf/extra/httpd-vhosts-zz-med-stg.conf
