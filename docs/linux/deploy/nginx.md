# centos 7 nginx安装:

```
vim /etc/yum.repos.d/nginx.repo
```

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

```
sudo yum-config-manager --enable nginx-mainline
sudo yum install nginx
```


websocket配置

```
location /websocket {
        proxy_pass http://localhost:8081;
 
        proxy_http_version 1.1;
        proxy_read_timeout 360s;   
        proxy_redirect off;   
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host:$server_port;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header REMOTE-HOST $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
}

server {
	listen 443;
	server_name 192.168.1.1;

	ssl on;
	ssl_certificate /usr/local/nginx/conf/ssl/server-1.crt;
	ssl_certificate_key /usr/local/nginx/conf/ssl/server.key;

	ssl_protocols  SSLv2 SSLv3 TLSv1;
	proxy_set_header Host $host;
	proxy_set_header X-Real-IP $remote_addr;
	proxy_set_header REMOTE-HOST $remote_addr;
	proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

	location =/ {
			rewrite / /login/;
	}
	location /desk/{
			proxy_pass http://desk;
	}
}
```
