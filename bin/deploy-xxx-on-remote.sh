#!/bin/bash
echo "set env..."
export JAVA_HOME=/usr/java/jdk
export CLASSPATH=.:$JAVA_HOME/lib
export PATH=$JAVA_HOME/bin:$PATH
echo "JAVA_HOME:$JAVA_HOME"
echo "PATH:$PATH"

TOMCAT_PATH="/usr/local/tomcat-ezine-front"
WEBAPP_PATH="/nh/appdir/java/ezine-front"

echo "tomcat stopping..."
$TOMCAT_PATH/bin/shutdown.sh
sleep 30s

echo "deploying..."
cd $WEBAPP_PATH
rm -rf index.jsp
rm -rf META-INF/
rm -rf res/
rm -rf show-gallery.html
rm -rf WEB-INF/
jar -xvf $WEBAPP_PATH/ezine-front-webapp.war
rm -f $WEBAPP_PATH/ezine-front-webapp.war

echo "tomcat starting..."
$TOMCAT_PATH/bin/startup.sh

echo "started, tail -fn 400 $TOMCAT_PATH/logs/catalina.out"
exit 0