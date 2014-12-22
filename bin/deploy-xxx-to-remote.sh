#!/bin/bash
mvn clean
mvn package -Dmaven.test.skip=true
scp ./target/ezine-front-webapp.war root@172.18.100.68:/nh/appdir/java/ezine-front/
echo "run shell on remote"
ssh root@172.18.100.68 "/nh/appdir/java/ezine-front/deploy-xxx-on-remote.sh"