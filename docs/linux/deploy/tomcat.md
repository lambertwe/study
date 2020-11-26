# jar 部署命令
deploy.sh 

```
#!/bin/bash
# 上面中的 #! 是一种约定标记, 它可以告诉系统这个脚本需要什么样的解释器来执行;

APP_NAME=lotteryCapture-0.0.1-SNAPSHOT.jar
APP_LOG_NAME=lotteryCapture.log

#使用说明，用来提示输入参数
usage() {
    echo "Usage: sh $APP_NAME.sh [start|stop|restart|status]"
    exit 1
}
#检查程序是否在运行
is_exist() {
    pid=$(ps -aux | grep $APP_NAME | grep -v grep | grep -v deploy | awk '{print $2}')
    #如果不存在返回1，存在返回0
    if [ -z "$pid" ]; then
        return 1
    else
        return 0
    fi
}
#启动方法
start() {
    is_exist
    if [ $? -eq 0 ]; then
        echo "$APP_NAME is already running. pid=$pid"
    else
        nohup /home/apps/jdk1.8.0_131/bin/java -jar $APP_NAME >> $APP_LOG_NAME 2>&1 &
    fi
}
#停止方法
stop() {
    echo "开始关闭java应用"
    is_exist
    if [ $? -eq "0" ]; then
        kill -9 $pid
    else
        echo "$APP_NAME is not running"
    fi
}
#输出运行状态
status() {
    is_exist
    if [ $? -eq "0" ]; then
        echo "$APP_NAME is running. Pid is $pid"
    else
        echo "$APP_NAME is NOT running."
    fi
}
#重启
restart() {
    stop
    sleep 5
    start
}
#根据输入参数，选择执行对应方法，不输入则执行使用说明
case "$1" in
"start")
    start
    ;;
"stop")
    stop
    ;;
"status")
    status
    ;;
"restart")
    restart
    ;;
*)
    usage
    ;;
esac

```


一个tomcat部署多个实例:
```
mkdir {tomcat_1,tomcat_2}
cp -r apache-tomcat-8.5.14/{conf,webapps,temp,logs,work} tomcat_1
cp -r apache-tomcat-8.5.14/{conf,webapps,temp,logs,work} tomcat_2

./restart.sh tomcat_1
./shutdown.sh tomcat_1
```


restart.sh

```
#!/bin/sh
export CATALINA_HOME=/home/apps/apache-tomcat-8.5.14
export CATALINA_BASE=${1%/}

echo $CATALINA_BASE
# 找到tomcat实例的进程ID
TOMCAT_ID=`ps aux |grep "java"|grep "Dcatalina.base=$CATALINA_BASE "|grep -v "grep"|awk '{ print $2}'`

if [ -n "$TOMCAT_ID" ] ; then
        echo "tomcat(${TOMCAT_ID}) is running now ,shutdown it！";
        kill -9 $TOMCAT_ID
        # exit 2;
fi

TOMCAT_START_LOG=`$CATALINA_HOME/bin/startup.sh`
if [ "$?" = "0" ]; then
        echo "$0 ${1%/} start succeed"
else
        echo "$0 ${1%/} start failed"
        echo $TOMCAT_START_LOG
fi
tail -f $CATALINA_BASE/logs/catalina.out
```
shutdown.sh

```
#1/bin/sh
export CATALINA_HOME=/home/apps/apache-tomcat-8.5.14
export CATALINA_BASE=${1%/}

echo $CATALINA_BASE

TOMCAT_ID=`ps aux |grep "java"|grep "[D]catalina.base=$CATALINA_BASE "|awk '{ print $2}'`

if [ -n "$TOMCAT_ID" ] ; then
TOMCAT_STOP_LOG=`$CATALINA_HOME/bin/shutdown.sh`
else
  echo "Tomcat instance not found : ${1%/}"
  exit
fi

if [ "$?" = "0" ]; then
    echo "$0 ${1%/} stop succeed"
else
    echo "$0 ${1%/} stop failed"
    echo $TOMCAT_STOP_LOG
fi

```