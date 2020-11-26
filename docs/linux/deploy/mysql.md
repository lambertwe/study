# 下载mylsql软件和安装mysql
8.0版本
```
wget -i -c https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
yum -y install mysql80-community-release-el7-3.noarch.rpm
yum -y install mysql-community-server
```
下载mylsql软件和安装mysql
5.7版本
```
wget -i -c http://dev.mysql.com/get/mysql57-community-release-el7-10.noarch.rpm
yum -y install mysql57-community-release-el7-10.noarch.rpm
yum -y install mysql-community-server
```
#启动msql服务
```
systemctl start  mysqld.service
```
#查看mysql运行状态
```
systemctl status  mysqld.service
```
#获取mysql初始密码
```
grep "password" /var/log/mysqld.log
```
登录mysql 将mysql登录密码设置为123456
```
mysql -uroot -p
```
#mysql 设置
```
set global validate_password.policy=0;
set global validate_password.length=4; 
ALTER USER 'root'@'localhost' IDENTIFIED BY '123456';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456'
#创建用户
CREATE USER 'admin'@'%' IDENTIFIED BY '123456';
GRANT ALL ON *.* TO 'admin'@'%';
CREATE USER 'admin'@'localhost' IDENTIFIED BY '123456';
GRANT ALL ON *.* TO 'admin'@'localhost';
#刷新一下生效
flush privileges;
#创建数据库
create database videoweb charset utf8;
exit;//退出mysql
```

#将数据库表导入到数据库中
```
mysql -u root -p videoweb < /home/web/videoweb4.sql
```
#mysql表增加字段


```

ALTER TABLE table_xxx ADD COLUMN return_time datetime DEFAULT null comment '订单返回时间';
ALTER TABLE table_xxx ADD COLUMN return_time datetime DEFAULT null comment '订单返回时间';
```

 可以用这个命令：

```
show index from table_name;
 select database();
 SHOW CREATE TABLE tbl_name

//修改字段长度
alter table table1 modify name char(15);
//修改字段名称以及长度
alter table xxx change legalcard_num legal_card_num text(100);
alter table xxx change legalcard_num legal_card_num text(100);
alter table table1 change id id int(10);

#设置数据库时区
my.ini
default-time_zone='+8:00'
```

connMysql.sh 自动连接数据命令

```
#!/bin/sh
HOST=''
USER='root'
PASSWORD='root'
DATABASE='test'

echo try to connect host: $HOST
echo logging into db ${DATABASE} as ${USER}

# mysql -h host -u user_name -p --database data_base
mysql -h $HOST -u $USER --password=$PASSWORD --database=$DATABASE

```