## 简述
2019 年 3 月 debian 发表声明宣布系统的分支 Wheezy,Jessie 将归档，这导致其资源链接由原来的 deb.debian.org 转到 archive.debian.org, 最终结果是，许多依赖 debian:wheezy 或 debian:jessie 的 docker 镜像不能构建。

## 解决方法
source.list使用以下
```
deb http://cdn-fastly.deb.debian.org/debian/ jessie main
deb-src http://cdn-fastly.deb.debian.org/debian/ jessie main
deb http://security.debian.org/ jessie/updates main
deb-src http://security.debian.org/ jessie/updates main
deb http://archive.debian.org/debian jessie-backports main
deb-src http://archive.debian.org/debian jessie-backports main
```
可能某些链接还是可以使用国内镜像，从观察来看镜像中jessie-backports这个没有了，别的都有，没有测试过

## apt-get update问题
出现以下问题：
```
E: Release file for http://archive.debian.org/debian/dists/jessie-backports/InRelease is expired (invalid since 75d 20h 5min 27s). Updates for this repository will not be applied.
```

解决：
```
apt-get -o Acquire::Check-Valid-Until=false update
```
