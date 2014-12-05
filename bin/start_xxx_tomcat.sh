#!/bin/bash
rm -rf index.jsp
rm -rf META-INF/
rm -rf res/
rm -rf show-gallery.html
rm -rf WEB-INF/

jar -xvf /nh/appdir/java/ezine-front/ezine-front-webapp.war
/usr/local/tomcat-ezine-front/bin/startup.sh
tail -fn 400 /usr/local/tomcat-ezine-front/logs/catalina.out