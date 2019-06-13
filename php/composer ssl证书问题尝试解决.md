## composer ssl证书问题尝试解决

* 使用国内镜像：
    * 镜像1：[https://packagist.phpcomposer.com](https://packagist.phpcomposer.com)
    * 镜像2：[https://packagist.laravel-china.org](https://packagist.laravel-china.org)
```
# 方法1，全局设置
composer config -g repo.packagist composer https://packagist.phpcomposer.com

# 方法2，当前设置
composer config repo.packagist composer https://packagist.phpcomposer.com

# 方法3，手动改composer.json
"repositories": {
    "packagist": {
        "type": "composer",
        "url": "https://packagist.phpcomposer.com"
    }
}
```

* 更新本地证书
    * 下载证书 https://curl.haxx.se/ca/cacert.pem 放到某个目录
    * 配置php.ini里的cainfo, cafile

* 尝试配置默认证书地址
    * php -r "print_r(openssl_get_cert_locations());" 查看证书路径
    * 把default路径都建起来，把证书丢进去
    
* 最后尝试翻墙
