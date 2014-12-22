#!/bin/bash
### BEGIN INIT INFO
#
# Provides: xxx_server
# Required-Start: $local_fs $remote_fs
# Required-Stop: $local_fs $remote_fs
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: initscript
# Description: This file should be used to construct scripts to be placed in /etc/init.d.
#
### END INIT INFO

# **NOTE** bash will exit immediately if any command exits with non-zero.
set -e

## Fill in name of program here.
PROG="test"
PROG_PATH="/home/luke/gitrep/web-support/bin" ## Not need, but sometimes helpful (if $PROG resides in /opt for example).
PID_PATH="/var/run"
PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin"

start_app() {
    echo "starting $PROG..."
    if [ -s "$PID_PATH/$PROG.pid" ]; then
        ## Program is running, exit with error.
        echo "Error! $PROG is currently running! see 'cat $PID_PATH/$PROG.pid'" 1>&2
        exit 1
    else
        ## Startup program, Change from /dev/null to something like /var/log/$PROG if you want to save output.
        python $PROG_PATH/$PROG.py > /var/log/$PROG.log 2>&1 &
        #nohup python $PROG_PATH/$PROG.py &

        ## Get running pid
        PID=`ps ax | grep -i 'test.py' | sed 's/^\([0-9]\{1,\}\).*/\1/g' | head -n 1`
        ## Create a pid file for this app
        echo $PID > "$PID_PATH/$PROG.pid"
        echo "$PROG started"
    fi
}

stop_app() {
    echo "stopping $PROG..."
    if [ -s "$PID_PATH/$PROG.pid" ]; then
        ## Program is running, so stop it
        #kill -QUIT $(cat $PID_PATH/$PROG.pid)
        kill -KILL $(cat $PID_PATH/$PROG.pid)
        rm -f "$PID_PATH/$PROG.pid"
        echo "$PROG stopped"
    else
        ## Program is not running, exit with error.
        echo "Error! $PROG not started!"  1>&2
        exit 1
    fi
}

restart_app() {
    stop_app
    start_app
}

start_nginx() {
    echo -n "starting nginx..."
    nginx -p $PROG_PATH/ -c config/nginx-${PROG}.conf
    echo "done."
}

stop_nginx() {
    echo -n "stopping nginx..."
    kill -QUIT $(cat /var/run/nginx-$PROG.pid)
    echo "done."
}

restart_nginx() {
    echo -n "reloading nginx..."
    kill -HUP $(cat /var/run/nginx-$PROG.pid)
    echo "done."
}

start_supervisord() {
    echo -n "starting ${PROG}: "
    cd ${PROG_PATH}
    supervisord -c config/supervisord-${PROG}.conf
    echo "done."
    echo "sudo tail -F /var/log/${PROG}/*.log to view logs"
}

stop_supervisord() {
    echo -n "stopping ${PROG}: "
    kill -QUIT $(cat /var/run/supervisord-${PROG}.pid)
    echo "done."
}

restart_supervisord() {
    echo -n "restart ${PROG}: "
    kill -HUP $(cat /var/run/supervisord-${PROG}.pid)
    echo "done."
}

## Check to see if we are running as root first.
## Found at http://www.cyberciti.biz/tips/shell-root-user-check-script.html
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

case "$1" in
    start)
        start_app
        #start_nginx
        #start_supervisord
        exit 0
        ;;
    stop)
        stop_app
        #stop_nginx
        #stop_supervisord
        exit 0
        ;;
    restart|reload|force-reload)
        restart_app
        #restart_nginx
        #restart_supervisord
        exit 0
        ;;
    **)
        echo "Usage: $0 {start|stop|restart}" 1>&2
        exit 1
        ;;
esac