#!/bin/bash

## 创建目录
mkdir -p ./php
mkdir -p ./mysql
mkdir -p ./log

## 拉取项目
git clone https://github.com/zxc7563598/php-bilibili-danmu.git ./php

## 安装composer
cd ./php && composer install

## 初始化项目
sh ./php/setup.sh >> /log/setup.log

