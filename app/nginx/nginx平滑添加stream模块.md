## 简介
nginx从1.9.0版本开始，新增了ngx_stream_core_module模块，使nginx支持四层负载均衡。默认编译的时候该模块并未编译进去，需要编译的时候添加--with-stream，使其支持stream代理。

## 查看原nginx编译参数
```
[root@test-server sbin]# nginx -V
nginx version: nginx/1.13.4
built by gcc 4.8.5 20150623 (Red Hat 4.8.5-16) (GCC) 
built with OpenSSL 1.0.2k-fips  26 Jan 2017
TLS SNI support enabled
configure arguments: --prefix=/usr/local/nginx --user=www --group=www --with-http_ssl_module --with-http_gzip_static_module --http-client-body-temp-path=/usr/local/nginx/tmp/client/ --http-proxy-temp-path=/usr/local/nginx/tmp/proxy/ --http-fastcgi-temp-path=/usr/local/nginx/tmp/fcgi/ --with-poll_module --with-file-aio --with-http_realip_module --with-http_addition_module --with-http_addition_module --with-http_random_index_module --with-http_stub_status_module --http-uwsgi-temp-path=/usr/local/nginx/uwsgi_temp --http-scgi-temp-path=/usr/local/nginx/scgi_temp --with-pcre=/usr/local/src/pcre-8.41
```

## 添加stream模块进行重新编译
```
./configure --prefix=/usr/local/nginx --user=www --group=www --with-http_ssl_module --with-http_gzip_static_module --http-client-body-temp-path=/usr/local/nginx/tmp/client/ --http-proxy-temp-path=/usr/local/nginx/tmp/proxy/ --http-fastcgi-temp-path=/usr/local/nginx/tmp/fcgi/ --with-poll_module --with-file-aio --with-http_realip_module --with-http_addition_module --with-http_addition_module --with-http_random_index_module --with-http_stub_status_module --http-uwsgi-temp-path=/usr/local/nginx/uwsgi_temp --http-scgi-temp-path=/usr/local/nginx/scgi_temp --with-pcre=/usr/local/src/pcre-8.41 --with-stream
```

## 进行make操作
此处一定不能使用make install命令，执行该命令会将原有nginx目录进行覆盖。

## 关停nginx同时复制新的nginx启动文件
```
关闭nginx服务
systemctl stop nginx
 
备份原有nginx二进制文件。
cp /usr/local/nginx/sbin/nginx /usr/local/nginx/sbin/nginx-no-strem
 
复制新编译好的nginx二进制文件。从此处nginx源码目录为：/usr/local/nginx-1.13.4。即为编译命令执行目录。
cp ./objs/nginx /usr/local/nginx/sbin/nginx
```

## 启动
```
systemctl start nginx
```

## stream使用
```
stream {
    upstream zk_server {
        server 172.16.3.8:2181 weight=5;
    }
    server {
        listen 2181 tcp;
        proxy_responses 1;
        proxy_timeout 20s;
        proxy_pass zk_server;
    }
}

```

## 参考
[编译nginx平滑添加stream模块](https://www.cnblogs.com/crysmile/p/9565048.html)
