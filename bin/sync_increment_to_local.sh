#!/bin/bash
rsync -vzropg --progress --exclude "nginx-access.log" --exclude "nginx-error.log" root@59.151.95.243:/var/log/sitepatch/*.log /var/log/243/
rsync -vzropg --progress --exclude "nginx-access.log" --exclude "nginx-error.log" root@59.151.95.244:/var/log/sitepatch/*.log /var/log/244/