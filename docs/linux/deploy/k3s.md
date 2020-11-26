# 进入docker内部
docker run -itd mysql:5.7 /bin/bash  
1.查找镜像

```
docker search mysql
```
2.下载镜像（如上一步，可以指定想要的版本，不指定则为最新版）

```
docker pull mysql
```
3.通过镜像创建容器并运行：

```
docker run -p 3306:3306 --name mymysql -v $PWD/conf:/etc/mysql/conf.d -v $PWD/logs:/logs -v $PWD/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -d mysql
```
 
-p 3306:3306：将容器的 3306 端口映射到主机的 3306 端口。
 
 
-v -v $PWD/conf:/etc/mysql/conf.d：将主机当前目录下的 conf/my.cnf 挂载到容器的 /etc/mysql/my.cnf。
 
 
-v $PWD/logs:/logs：将主机当前目录下的 logs 目录挂载到容器的 /logs。
 
 
-v $PWD/data:/var/lib/mysql ：将主机当前目录下的data目录挂载到容器的 /var/lib/mysql 。
 
 
-e MYSQL_ROOT_PASSWORD=123456：初始化 root 用户的密码。
此时，用navicat for mysql连接mysql发现报错：Client does not support authentication protocol requested  by server。。。




进入docker容器内部：

```
docker exec -it 62349aa31687 /bin/bash
```
进入mysql：　

```
mysql -uroot -p
```
授权：

```
mysql> GRANT ALL ON *.* TO 'root'@'%';
```
刷新权限：

```
mysql> flush privileges;
```
更新加密规则：

```
mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'password' PASSWORD EXPIRE NEVER;
```
更新root用户密码：

```
mysql> ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '123456';
```
刷新权限：

```
mysql> flush privileges;

 
```


curl http://pigx.vip/os7init.sh | sh -s nginx150
curl http://pigx.vip/os7init.sh | sh -s server151
curl http://pigx.vip/os7init.sh | sh -s server152
curl http://pigx.vip/os7init.sh | sh -s agent153
curl http://pigx.vip/os7init.sh | sh -s agent154
curl http://pigx.vip/docker_install.sh | sh


docker run --name mysql5.7 --net host --restart=always -e MYSQL_ROOT_PASSWORD=root -d mysql:5.7 --lower_case_table_names=1

mysql -uroot -proot -h 192.168.2.150




create database k3s;

#export INSTALL_K3S_VERSION=v1.17.3-k3s1

export INSTALL_K3S_EXEC="--datastore-endpoint=mysql://root:root@tcp(192.168.2.150:3306)/k3s --docker --kube-apiserver-arg service-node-port-range=1-65000 --no-deploy traefik --write-kubeconfig ~/.kube/config --write-kubeconfig-mode 666"

#curl -sfL https://docs.rancher.cn/k3s/k3s-install.sh | INSTALL_K3S_MIRROR=cn sh -
curl -sfL http://rancher-mirror.cnrancher.com/k3s/k3s-install.sh | INSTALL_K3S_MIRROR=cn sh -
#curl -sfL https://get.k3s.io | INSTALL_K3S_MIRROR=cn sh -



vim /etc/yum.repos.d/nginx.repo

```
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true

[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/centos/$releasever/$basearch/
gpgcheck=1
enabled=0
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true
```

sudo yum-config-manager --enable nginx-mainline
sudo yum install nginx




nginx 

```
stream{
	upstream k3sList {
		server 192.168.2.151:6443
		server 192.168.2.152:6443
	}
	
	server {
		listen 6443:
		proxy_pass k3sList;
	}
}

```

安装agent


```
cat /var/lib/rancher/k3s/server/node-token
export INSTALL_K3S_VERSION=v1.17.3-k3s1
export K3S_TOKEN=K1092ef50b3852d77a54c3b23a74cbabaa0ca955fb9b8366be4a4a2f0d893e2c77f::server:697f21c12e4a565e494efccd0f3fd158
export K3S_URL=https://192.168.2.150:6443

export INSTALL_K3S_EXEC="--docker --kube-apiserver-arg service-node-port-range=1-65000 --no-deploy traefik --write-kubeconfig ~/.kube/config --write-kubeconfig-mode 666"
curl -sfL http://rancher-mirror.cnrancher.com/k3s/k3s-install.sh | INSTALL_K3S_MIRROR=cn sh -

docker run -d -v /data/docker/rancher-server/var/lib/rancher/:/var/lib/rancher/ --restart=unless-stopped --name rancher-server -p 9443:443 rancher/rancher:stable

docker run -d -v /data/docker/rancher-server/var/lib/rancher/

cr.console.aliyun.com/cn-hangzhou/instances/repositories

registry.cn-hangzhou.aliyuncs.com/pig4cloud/pig-mysql:2.7.0
registry.cn-hangzhou.aliyuncs.com/pig4cloud/pig-register:2.7.0
registry.cn-hangzhou.aliyuncs.com/pig4cloud/pig-gateway:2.7.0
registry.cn-hangzhou.aliyuncs.com/pig4cloud/pig-auth:2.7.0
registry.cn-hangzhou.aliyuncs.com/pig4cloud/pig-upms-biz:2.7.0
registry.cn-hangzhou.aliyuncs.com/pig4cloud/pig-codegen:2.7.0
registry.cn-hangzhou.aliyuncs.com/pig4cloud/pig-ui:2.7.0

```
