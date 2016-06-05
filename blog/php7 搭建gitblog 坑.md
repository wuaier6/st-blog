<!--
author: shentao
head: http://pingodata.qiniudn.com/jockchou-avatar.jpg
date: 2016-06-03
title: linux php7 memcache追加
tags: linux服务器
status: publish
summary: 个人服务器学习纪录
-->


## Php7 Memcache扩展 ##

安装过程

    #git clone https://github.com/php-memcached-dev/php-memcached.git
    #git checkout php7
    #/application/system/php7/bin/phpize
    # ./configure --with-php-config=/application/system/php7/bin/php-config --with-libmemcached-dir=/application/system/libmemcached
    #make && make install
    
>memcache安装时需要指定libmemcached。安装成功
>//Installing shared extensions:     /application/system/php7/lib/php/extensions/no-debug-non-zts-20151012/

php.ini修正

    #vim /application/system/php7/etc/php.ini
>[memcached]
>extension=memcached.so

重启php7

    #/etc/init.d/php-fpm restart