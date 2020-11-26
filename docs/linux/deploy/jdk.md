# 1.这里需要上传jdk版本1.8
 yum安装方法
 
```
yum install java-1.8.0-openjdk* -y

```
#2.手动安装jdk
首先上传jdk
#然后将jkd解压.

```
#vim /etc/profile  #在最后面增加一行

	export JAVA_HOME=/home/web/jdk1.8.0_131
	export PATH=$PATH:$JAVA_HOME/bin
	export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

#source /etc/profile
```