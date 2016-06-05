<!--
author: shentao
head: http://pingodata.qiniudn.com/jockchou-avatar.jpg
date: 2016-06-03
title: linux用户权限学习
tags: linux服务器
category: linux服务器
status: publish
summary: 个人服务器学习纪录
-->

![gitblog-logo](./img/logo_64x64.png)

## Linux 权限管理 ##

追加group组

    #groupadd g-st-blog
    #useradd u-st-blog
    
查看当前目录下面的所有文件+权限

    ls -ahl

修改文件夹用户组

    chown -R apache:apache redmin
    chmod -R 755 redmine
    
 drwxrwxrwx  1 vagrant vagrant 4.0K May 26 02:55 zzwechat中的drwxrwxrwx  代表什么意思？
- 第一个字符代表文件（-）、目录（d），链接（l）

- 其余字符每3个一组（rwx），读（r）、写（w）、执行（x）

- 第一组rwx：文件所有者的权限是读、写和执行

- 第二组rw-：与文件所有者同一组的用户的权限是读、写但不能执行

- 第三组r--：不与文件所有者同组的其他用户的权限是读不能写和执行

