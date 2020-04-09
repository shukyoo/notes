## 一般的php server配置
```
server {
  listen  80 default;
  server_name test.com;
  root   your root dirname;
  
  location / {
    index  index.html index.php index.htm;
    try_files $uri $uri/ /index.php?$query_string;
  }
  
  location ~*\.php$ {
    fastcgi_pass   127.0.0.1:9000;
    fastcgi_index  index.php;
    fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
    include        fastcgi_params;
  }
}
```
