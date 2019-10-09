## composer手工安装
1. 先下载composer.phar：[https://getcomposer.org/download/](https://getcomposer.org/download/)
2. 把composer.phar放到一个目录里，目录加入path，如：C:\bin
3. 制作composer.bat如下：
```bat
@php %~dp0composer.phar %*
```
