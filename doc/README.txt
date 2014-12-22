1. 自动上线脚本
   本地编译打包，自动部署到远程，并重启远程服务
   deploy-xxx-to-remote.sh 是mvn本地编译打包，传包到远程，并调用远程脚本。
   deploy-xxx-on-remote.sh 是部署程序及重启Tomcat的脚本，可以被远程调用。

2. 程序作为Linux Service启动
   xxx-service


