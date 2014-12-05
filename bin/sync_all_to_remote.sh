#!/bin/bash
chown root:root -R ../sitepatch/www
chmod 755 -R ../sitepatch/www

rsync -vzropg --progress --delete ./sitepatch/www root@59.151.95.243:/usr/local/sitepatch/
rsync -vzropg --progress --delete ./sitepatch/www root@59.151.95.244:/usr/local/sitepatch/