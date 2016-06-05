<!--
author: shentao
head: http://pingodata.qiniudn.com/jockchou-avatar.jpg
date: 2016-06-05
title: php7 搭建gitblog 坑
tags: php学习
category: php学习
status: publish
summary: 个人学习纪录
-->

###php7 搭建gitblog 坑

因为自己的服务器上现在只有php7的环境.所以gitblog的也用了php7.

问题：

>ERROR - 2016-06-05 03:27:49 --> Severity: error --> Exception: Function name must be a string /application/wwwroot/st-blog/app/third_party/parsedown/Parsedown.php 1415


修改前:

     $markup .= $this->$Element['handler']($Element['text']);

修改后：

     $markup .= $this->{$Element['handler']}($Element['text']);

本人只遇到这个错，如果有什么其他的错。可以留言给我。