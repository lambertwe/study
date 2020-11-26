# centos Ip 设置

```
vi /etc/sysconfig/network-scripts/ifcfg-eth0

DEVICE=eth0
BOOTPROTO=static
HWADDR=00:0C:29:F4:7E:C9
IPV6INIT=yes
NM_CONTROLLED=yes
ONBOOT=yes
TYPE=Ethernet
UUID=2a76c2f8-cd47-44af-936d-11559b3a498d
IPADDR=192.168.73.100
NETMASK=255.255.255.0
GATEWAY=192.168.73.1
DNS1=114.114.114.114
```