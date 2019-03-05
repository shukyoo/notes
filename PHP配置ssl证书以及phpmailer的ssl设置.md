# PHP配置ssl证书
1. 建立一个cert目录（可以放到php目录里）
2. 下载证书到cert目录（https://curl.haxx.se/ca/cacert.pem）
3. 修改php.ini
```
;配置CA 证书存放位置
curl.cainfo= /....../cert/cacert.pem
openssl.cafile=/....../cert/cacert.pem

;配置CA 证书目录
openssl.capath=/...../cert
```

# phpmailer的ssl设置
```
# ssl没配好发邮件会出现以下错误信息
smtp_code:"stream_socket_enable_crypto(): SSL operation failed with code 1. OpenSSL Error messages:\nerror:14090086:SSL routines:ssl3_get_server_certificate:certificate verify failed"
```

这里我们关闭ssl验证
```php
$mail->SMTPOptions = array(
    'ssl' => array(
        'verify_peer' => false,
        'verify_peer_name' => false,
        'allow_self_signed' => true,
    )
)
```

