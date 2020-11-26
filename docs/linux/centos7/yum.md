# 解决Centos7使用yum安装mysql下载速度慢的问题
**1、备份系统自带的yum源文件**

~~~
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
~~~

**2、下载阿里云的yum配置文件**

~~~
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
~~~

**3、运行yum makecache 生成缓存**

~~~
yum makecache
~~~
