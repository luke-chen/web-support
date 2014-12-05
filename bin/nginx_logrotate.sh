#!/bin/bash
## 零点执行该脚本

## Nginx 日志文件所在的目录
PROJECT_NAME=sitepatch
LOGS_PATH=/var/log/$PROJECT_NAME

## 获取昨天的 yyyy-MM-dd
YESTERDAY=$(date -d -1day +%Y-%m-%d)

## 移动文件
mv ${LOGS_PATH}/nginx-access.log ${LOGS_PATH}/nginx-access-${YESTERDAY}.log

## 向 Nginx 主进程发送 USR1 信号。USR1 信号是重新打开日志文件
kill -USR1 $(cat /var/run/nginx-$PROJECT_NAME.pid)

#删除5日前的日志
rm -f $LOGS_PATH/nginx-access-$(date --date="-5 day" +"%Y-%m-%d").log