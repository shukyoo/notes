## 腾讯
[https://mirrors.cloud.tencent.com/help/composer.html](https://mirrors.cloud.tencent.com/help/composer.html)

#### 配置全局镜像
```
composer config -g repos.packagist composer https://mirrors.cloud.tencent.com/composer/
```

## 阿里云
[https://developer.aliyun.com/composer](https://developer.aliyun.com/composer)

#### 配置全局镜像
```
composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
```


## 取消配置
```
composer config -g --unset repos.packagist
```

## PS
之前用的阿里云，但是踩过坑，版本并不新，然后换成腾讯云解决问题，因此把腾讯镜像列为首选
