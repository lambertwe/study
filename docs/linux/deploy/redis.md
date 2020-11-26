# redis 部署方法

```
yum -y install gcc gcc-c++ libstdc++-devel
wget http://download.redis.io/releases/redis-4.0.6.tar.gz
tar xzf redis-4.0.6.tar.gz
cd redis-4.0.6
make

vim startup.sh 
    ####startup.sh 里面内容: 
	#/bin/sh
	nohup ./src/redis-server >redis.log 2>&1 &
	
chmod +x startup.sh
./startup.sh 
```