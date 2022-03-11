```
# http重定向到https
server {
    listen       80;
    server_name  www.xxxx.com m.xxx.com;
    return 301 https://$host$request_uri;
}

# 根域名重定向到www
server {
    listen       80;
    listen       443 ssl;
    ssl_certificate      /usr/local/nginx/key/nginx.crt;
    ssl_certificate_key  /usr/local/nginx/key/nginx.key;
    server_name  xxx.com;
    return 301 https://www.xxx.com$request_uri;
}

# ---
server {
    listen       443 ssl;
    ssl_certificate      /usr/local/nginx/key/nginx.crt;
    ssl_certificate_key  /usr/local/nginx/key/nginx.key;
    server_name  www.xxx.com m.xxx.com;
    root         /srv/www/xxx/public;
    location / {
        index index.php;
        try_files $uri $uri/ /index.php?$query_string;
    }
    location ~ \.php {
        include        fastcgi_params;
        set $path_info "";
        set $real_script_name $fastcgi_script_name;
        fastcgi_param  SCRIPT_FILENAME  $document_root$real_script_name;
        fastcgi_param SCRIPT_NAME $real_script_name;
        fastcgi_param PATH_INFO $path_info;
        fastcgi_pass   127.0.0.1:9000;
        fastcgi_index  index.php;
    }
```
