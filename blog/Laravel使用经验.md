<!--
author: shentao
head: http://pingodata.qiniudn.com/jockchou-avatar.jpg
date: 2016-06-05
title: Laravel使用经验
tags: php学习
status: publish
summary: 个人学习纪录
-->

###Laravel使用经验：

经过3个月的laravel学习和研究，看过很多前人的经验。以下内容只是一个架构方面，没有具体内容的现在，

Staff Web：
	所有的staff网站主要包含auth，authority，log日志,business 业务。通常软件开发开发的时候，通常程序员都会知道：MVC（model+view+controller）+ oop开发流程。
但是随着项目的变大，业务逻辑的变更，项目会越来越乱。所以一直很苦恼。

经过学习了laravel，参照了很多开源项目，总结出自己一套开发框架
后端：MVC+MVP+Repertory+transform
思路：
- Controller :处理具体业务的操作，每个功能具体业务在里面处理。
- Presenter :具体处理共通内容的业务。例如:menu，authority等共通内容
- Controller+Presenter不直接从Model拿数据，而是从Repertory中拿数据。
为什么这样呢？
  ORM数据存取方式的流行，让数据库操作变得更加方便。但是对于代码的维护不是相对容易。所以Repertory中操作数据个人感觉比较好。而且Repertory中去区分从db中取数据，还是redis中存取。
- transform主要使用api接口，当然staff中也可以使用。用于处理返回接口格式的定义。

Laravel让代码变得优雅，以上只是一个设计思路。第一次写，如果要demo的话，可以发我邮件？

