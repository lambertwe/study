# 打开防火墙端口
```
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --reload
```


1.

`firewall-cmd --state  `

#查看firewall的状态

`firewall-cmd --list-all `

`#查看防火墙规则（只显示/etc/firewalld/zones/``public``.xml中防火墙策略）`

`firewall-cmd --list-all-zones `

`#查看所有的防火墙策略（即显示/etc/firewalld/zones/下的所有策略）`

`firewall-cmd --reload`

`#重新加载配置文件`

2、关闭firewall： 
``` 
systemctl stop firewalld.service #停止firewall  
systemctl disable firewalld.service #禁止firewall开机启动  
firewall-cmd --state #查看默认防火墙状态（关闭后显示notrunning，开启后显示running）
```

1、firewalld的基本使用
启动： systemctl start firewalld
查看状态： systemctl status firewalld 
停止： systemctl disable firewalld
禁用： systemctl stop firewalld
2.systemctl是CentOS7的服务管理工具中主要的工具，它融合之前service和chkconfig的功能于一体。
启动一个服务：systemctl start firewalld.service  
关闭一个服务：systemctl stop firewalld.service  
重启一个服务：systemctl restart firewalld.service  
显示一个服务的状态：systemctl status firewalld.service  
在开机时启用一个服务：systemctl enable firewalld.service  
在开机时禁用一个服务：systemctl disable firewalld.service  
查看服务是否开机启动：systemctl is-enabled firewalld.service  
查看已启动的服务列表：systemctl list-unit-files|grep enabled  
查看启动失败的服务列表：systemctl --failed
3.配置firewalld-cmd
查看版本： firewall-cmd --version
查看帮助： firewall-cmd --help
显示状态： firewall-cmd --state
查看所有打开的端口： firewall-cmd --zone=public --list-ports
更新防火墙规则： firewall-cmd --reload
查看区域信息:  firewall-cmd --get-active-zones
查看指定接口所属区域： firewall-cmd --get-zone-of-interface=eth0
拒绝所有包：firewall-cmd --panic-on
取消拒绝状态： firewall-cmd --panic-off
查看是否拒绝： firewall-cmd --query-panic
那怎么开启一个端口呢
添加
firewall-cmd --zone=public --add-port=80/tcp --permanent    （--permanent永久生效，没有此参数重启后失效）
重新载入
firewall-cmd --reload
查看
firewall-cmd --zone= public --query-port=80/tcp
删除
firewall-cmd --zone= public --remove-port=80/tcp --permanent




方法1、修改配置文件/etc/firewalld/zones/public.xml，重启或重新加载配置生效

~~~
[root@nginx01 zones]# cat public.xml
<?xml version="1.0" encoding="utf-8"?>
<zone>
  <short>Public</short>
  <description>For use in public areas. You do not trust the other computers on networks to not harm your computer. Only selected incoming connections are accepted.</description>
  <rule family="ipv4">
    <source address="122.x.x.234"/>
    <port protocol="udp" port="514"/>
    <accept/>
  </rule>
  <rule family="ipv4">
    <source address="123.x.x.14"/>
    <port protocol="tcp" port="10050-10051"/> ##可以开放端口地址范围"10050-10051"，不单只限定一个端口
    <accept/>
  </rule>
 <rule family="ipv4">
    <source address="192.x.x.114"/>      ##放通指定ip，指定端口、协议
    <port protocol="tcp" port="80"/>
    <accept/>
  </rule>
<rule family="ipv4">                        ##放通任意ip访问服务器的9527端口
    <port protocol="tcp" port="9527"/>
    <accept/>
  </rule>
</zone>


firewall-cmd --reload
service firewalld restart    #使配置文件重新加载
~~~

  

方法2、命令行修改防火墙策略，仍需重启firewalld.service或重新加载防火墙配置文件  

~~~
firwall-cmd --permanent --add-port=9527/tcp    插入防火墙规则，放通9527端口。
success 

#命令执行成功同时，在/etc/firewall/zones/public.xml中自动生成该规则。
<zone>
  <short>xx.</short>
  <description>xxx.</description>
  <port protocol="tcp" port="9527"/>
</zone>

service firewalld restart
firewall-cmd --reload         #重启或重新加载配置文件，使配置生效   
firewall-cmd --list-all
firewall-cmd --permanent --query-port=9527/tcp    #查询刚插入的规则是否生效
~~~

  

firewall-cmd --zone=public --add-port=80/tcp --permanent    添加防火墙规则；

firewall-cmd --reload    重新加载防火墙；

firewall-cmd --permanent --zone=public --add-masquerade    允许内网上网；

  

/etc/firewalld/zones/public.xml添加策略标准规则：

~~~
firewall-cmd --permanent --add-rich-rule 'rule family=ipv4 source address=122.x.x.234/24 port port=5423 protocol=tcp drop'    
firewall-cmd --permanent --add-rich-rule 'rule family=ipv4 source address=122.x.x.234 port port=80 protocol=tcp accept'    
firewall-cmd --reload
[root@nginx02 ~]# firewall-cmd --list-all
public (default, active)
  interfaces: em1
  sources: 
  services: 
  ports: 
  masquerade: no
  forward-ports: 
  icmp-blocks: 
  rich rules: 
    rule family="ipv4" source address="122.x.x.234" port port="5234" protocol="tcp" drop
    rule family="ipv4" source address="122.x.x.234" port port="80" protocol="tcp" accept
    rule family="ipv4" source address="123.x.x.14" port port="10050-10051" protocol="tcp" accept
~~~

  

二、以服务的形式（例如：ssh.xml/http.xml）添加新的防火墙策略

~~~
cat /etc/firewalld/zones/ssh.xml
<?xml version='1.0' encoding='utf-8'?>
<zone>
  <short>ssh</short>
  <description>ssh.</description>
#fortress-new
  <source address='122.x.x.2/29'/>
  <service name='ssh'/>
</zone>

firewall-cmd --list-all-zones
...
ssh
  interfaces: 
  sources: 122.x.x.2/29 
  services: ssh
  ports: 
  masquerade: no
  forward-ports: 
  icmp-blocks: 
  rich rules:
...
~~~

  

因为在/usr/lib/firewalld/services/中事先定义了ssh.xml的相应的规则

~~~
cat /usr/lib/firewalld/services/ssh.xml 

<?xml version="1.0" encoding="utf-8"?>
<service>
  <short>SSH</short>
  <description>Secure Shell (SSH) is a protocol for logging into and executing commands on remote machines. It provides secure encrypted communications. If you plan on accessing your machine remotely via SSH over a firewalled interface, enable this option. You need the openssh-server package installed for this option to be useful.</description>
  <port protocol="tcp" port="22"/>
</service>
##定义ssh.xml服务使用的协议，和通信的端口信息。
~~~

  

~~~
自定义服务(mongo.xml)模块
cat /usr/lib/firewalld/services/mongo.xml
<service>
  <short>mongo</short>
  <description>The service of mongo.</description>
  <port protocol="tcp" port="27017"/>
</service>

防火墙应用服务器模块
cat /etc/firewalld/zones/mongo.xml
<zone>
  <short>mongo</short>
  <description>mongo service</description>
  <source address="2.2.2.2/24"/>
  <service name="mongo"/>
</zone>

查看mongo.xml服务的防火墙生效情况
firewall-cmd --list-all-zones
...
mongo
  interfaces: 
  sources: 2.2.2.2/24 
  services: mongo
  ports: 
  masquerade: no
  forward-ports: 
  icmp-blocks: 
  rich rules:
...
~~~

  

PS：如果一个IP同时应用在多个.xml服务，则只会在最先匹配的服务生效，之后的服务则不匹配该IP。若需要将该IP应用在多个服务，则需要另开服务，将该IP应用的服务都绑定在该服务下。

  

例如：10.10.86.44同时需要放通ssh、http、mysql等服务

~~~
cat multi.xml 

<zone>
  <short> multi services</short>
  <description>IP of 10.10.86.44 apply in multi srevices.</description>
  <source address="10.10.86.44"/>
  <service name="ssh"/>
  <service name="mysql"/>
  <service name="http"/>        ##同时添加多个服务
</zone>

firewall-cmd --list-all-zones
...
multi
  interfaces: 
  sources: 10.10.86.44
  services: http mysql ssh
  ports: 
  masquerade: no
  forward-ports: 
  icmp-blocks: 
  rich rules:
...
~~~

  

总结：

（1）修改配置文件的方法和命令行添加防火墙策略的方法，都不能立即生效，需要重启或重新加载防火墙配置文件，是新的策略生效。

service firewalld restart

firewall-cmd --reload

（2）修改完防火墙后，一定要检查防火墙状态和策略加载状态，若失败则可能拦截所有请求。

（3）以服务（ssh.xml）的方式添加防火墙，可以方便管理。前提需要先查看/usr/lib/firewalld/services中是否定义相应的服务。

（4）若一个IP同时应用多个了服务，则会最先匹配第一个应用了该ip的服务，之后的服务中则不匹配。若需要同时应用到多个服务，则需要另开服务，在该服务(multi.xml)下同时应用多个服务(ssh/http/mysql等)

