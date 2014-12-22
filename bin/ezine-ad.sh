#! /bin/sh
### BEGIN INIT INFO
#
# Provides:          ezine-ad
# Required-Start:    $local_fs $remote_fs
# Required-Stop:     $local_fs $remote_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: initscript
# Description:       This file should be used to construct scripts to be placed in /etc/init.d.
#
### END INIT INFO

# **NOTE** bash will exit immediately if any command exits with non-zero.
set -e

PACKAGE_NAME=ezine-ad
INSTALL_PATH=/usr/local/${PACKAGE_NAME}
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

start_app() {
    echo -n "Starting ${PACKAGE_NAME}: "
    supervisord -c config/supervisord-${PACKAGE_NAME}.conf
    echo "done."
    echo "sudo tail -F /var/log/${PACKAGE_NAME}/*.log to view logs"
}

stop_app() {
    echo -n "Stopping ${PACKAGE_NAME}: "
    kill -QUIT $(cat /var/run/supervisord-${PACKAGE_NAME}.pid)
    echo "done."
}

restart_app() {
    echo -n "Restart ${PACKAGE_NAME}: "
    kill -HUP $(cat /var/run/supervisord-${PACKAGE_NAME}.pid)
    echo "done."
}

start_nginx() {
    echo -n "Starting nginx: "
    nginx -p ${INSTALL_PATH}/ -c config/nginx.conf
    echo "done."
}

stop_nginx() {
    echo -n "Stopping nginx: "
    kill -QUIT $(cat /var/run/nginx-${PACKAGE_NAME}.pid)
    echo "done."
}

reload_nginx() {
    echo -n "Reloading nginx: "
    kill -HUP $(cat /var/run/nginx-${PACKAGE_NAME}.pid)
    echo "done."
}

restart() {
    restart_app
    reload_nginx
}

usage() {
    N=$(basename "$0")
    echo "Usage: sudo $N {start|stop|restart|start_app|stop_app|restart_app|start_nginx|stop_nginx|reload_nginx}" >&2
    exit 1
}

if [ "$(id -u)" != "0" ]; then
    echo "please use sudo to run ${PACKAGE_NAME}"
    exit 0
fi

cd ${INSTALL_PATH}

case "$1" in
  start)
    start_app
    start_nginx
    ;;
  stop)
    stop_app
    stop_nginx
    ;;
  restart|force-reload)
    restart
    ;;
  start_app)
    start_app
    ;;
  stop_app)
    stop_app
    ;;
  restart_app)
    restart_app
    ;;
  start_nginx)
    start_nginx
    ;;
  stop_nginx)
    stop_nginx
    ;;
  reload_nginx)
    reload_nginx
    ;;
  *)
    usage
    ;;
esac

exit 0

