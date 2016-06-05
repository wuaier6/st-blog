<!--
author: shentao
head: http://pingodata.qiniudn.com/jockchou-avatar.jpg
date: 2016-06-04
title: 关于MQ的理解
tags: php学习
status: publish
summary: 个人学习纪录
-->

###关于MQ的理解

使用过得MQ：
>阿里云MQ
>laravel 5.2消息列队

为什么消息列队？
>数据量大的时候,可以不暂用效率的时候处理一些和主业务无关的事务。

阿里云的MQ使用感受？
>刚刚公测的时候那时候用的。因为我主要做php框架的的。消息的成产者和消费者一定要阿里云自己的ECS上,而且消费进程监控不到,所以有些消息莫名的消费掉了,提了很多工单也没有解决,感觉不是一般坑。现在变成收费了,不知道PHP的MQ是否可以正常使用。

现在公司项目中主要用到的是Laravel的消息队列。
>supervisor管理消费进程
>消息主要存放在redis中
>失败重试机制参照(阿里云的MQ的重试机制)

实现方式：
>既有系统是CI框架的,生成消息和消费消息在一个cli中。
该cli不对外开放，只在服务器内部使用，所以也没有做验证。
生产消息通过接口形式生成。