
# centos安装新版supervisor

## 安装
```
# yum install python-setuptools
# easy_install supervisor==3.3.3
```

## 配置和启动
```
#echo_supervisord_conf > /etc/supervisord.conf
#supervisord -c /etc/supervisord.conf
```


## 使用
```
supervisorctl status
supervisorctl start xxx
supervisorctl stop xxx
supervisorctl restart xxx:*
supervisorctl restart all
```


# centos6 python2.6安装supervisor3.3.3
```
// 先安装pip
# yum install python-pip -y

// 再用pip安装supervisor
# pip install supervisor==3.3.3

// 配置生成
# echo_supervisord_conf > /etc/supervisord.conf
// 一般会报以下错误
pkg_resources.DistributionNotFound: meld3>=0.6.5
// 修改
# vi /usr/lib/python2.6/site-packages/supervisor-3.3.3-py2.6.egg-info/requires.txt
// 注释掉第一行meld3
// 再运行就可以了
```
