#!/bin/bash
## 获取昨天的 yyyy-MM-dd
YESTERDAY=$(date -d -1day +%Y-%m-%d)
echo $YESTERDAY

echo "[tencent_news]"
cat ./log/243/nginx-access-${YESTERDAY}.log ./log/244/nginx-access-${YESTERDAY}.log | grep 'pv_tencent_news' | wc -l

echo "[ifeng_news]"
cat ./log/243/nginx-access-${YESTERDAY}.log ./log/244/nginx-access-${YESTERDAY}.log | grep 'pv_ifeng_news' | wc -l

echo "[200 304]"
cat ./log/243/nginx-access-${YESTERDAY}.log ./log/244/nginx-access-${YESTERDAY}.log | grep 'HTTP/1.1" 200' | wc -l
cat ./log/243/nginx-access-${YESTERDAY}.log ./log/244/nginx-access-${YESTERDAY}.log | grep 'HTTP/1.1" 304' | wc -l

echo "[all count]"
cat ./log/243/nginx-access-${YESTERDAY}.log ./log/244/nginx-access-${YESTERDAY}.log | wc -l