# 部署jar
mkdir {backup,deploy,app}

cd deploy 

```
vim deploy.sh

#!/bin/sh
echo "Input something: |"
read input
echo "Your input is: $input"
projectName=xx-$input-1.0.0

ps -ef|grep java | grep $projectName |grep -v grep | awk '{print $2}' |xargs kill -9 ;
mv ../apps/$projectName-*.jar ../backup/ ;
mv $projectName-*.jar ../apps/;
cd ../apps;
sh start.sh $input;

```
cd app

start.sh

```
#!/bin/sh
nohup java -Xms256m -Xmx256m -jar cr-$1-1.0.0-*.jar --spring.profiles.active=test >logs/$1.log 2>&1 &
tail -f logs/$1.log
```
restart.sh

```
#/bin/sh
ps -ef|grep java |grep -v "grep" | grep $1 | awk '{print $2}' |xargs kill -9
sh start.sh $1
```