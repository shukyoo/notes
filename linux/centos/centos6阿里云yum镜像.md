## 备份
```
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
```

## 官方6的源好像删除了，然后阿里的好像也不能用了，使用以下
```
curl -o /etc/yum.repos.d/CentOS-Base.repo http://file.kangle.odata.cc/repo/Centos-6.repo
curl -o /etc/yum.repos.d/epel.repo http://file.kangle.odata.cc/repo/epel-6.repo
yum clean all
yum makecache
```



-------------------------------------------------------------------------

## 创建
```
vim CentOS6-Base-aliyun.repo
```

## 清缓存生成缓存
```
yum clean all
yum makecache
```

## CentOS-Base.repo内容如下：
```
# geographically close to the client.  You should use this for CentOS updates
# unless you are manually picking other mirrors.
#
# If the mirrorlist= does not work for you, as a fall back you can try the 
# remarked out baseurl= line instead.
#
#

[base]
name=CentOS-$releasever - Base - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos-vault/6.10/os/$basearch/
        http://mirrors.aliyuncs.com/centos-vault/6.10/os/$basearch/
        http://mirrors.cloud.tencent.com/centos/$releasever/os/$basearch/
        http://mirrors.tencentyun.com/centos/$releasever/os/$basearch/
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-6

#released updates 
[updates]
name=CentOS-$releasever - Updates - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos-vault/6.10/updates/$basearch/
        http://mirrors.aliyuncs.com/centos-vault/6.10/updates/$basearch/
        http://mirrors.cloud.tencent.com/centos/$releasever/updates/$basearch/
        http://mirrors.tencentyun.com/centos/$releasever/updates/$basearch/
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-6

#additional packages that may be useful
[extras]
name=CentOS-$releasever - Extras - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos-vault/6.10/extras/$basearch/
        http://mirrors.aliyuncs.com/centos-vault/6.10/extras/$basearch/
        http://mirrors.cloud.tencent.com/centos/$releasever/extras/$basearch/
        http://mirrors.tencentyun.com/centos/$releasever/extras/$basearch/
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras
gpgcheck=1
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-6

#additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-$releasever - Plus - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos-vault/6.10/centosplus/$basearch/
        http://mirrors.aliyuncs.com/centos-vault/6.10/centosplus/$basearch/
        http://mirrors.cloud.tencent.com/centos/$releasever/centosplus/$basearch/
        http://mirrors.tencentyun.com/centos/$releasever/centosplus/$basearch/
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus
gpgcheck=1
enabled=0
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-6

#contrib - packages by Centos Users
[contrib]
name=CentOS-$releasever - Contrib - mirrors.aliyun.com
failovermethod=priority
baseurl=http://mirrors.aliyun.com/centos-vault/6.10/contrib/$basearch/
        http://mirrors.aliyuncs.com/centos-vault/6.10/contrib/$basearch/
        http://mirrors.cloud.tencent.com/centos/$releasever/contrib/$basearch/
        http://mirrors.tencentyun.com/centos/$releasever/contrib/$basearch/
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=contrib                                                                                                                              
gpgcheck=1
enabled=0
gpgkey=http://mirrors.aliyun.com/centos/RPM-GPG-KEY-CentOS-6
```


## epel.repo内容
```
[epel]
name=Extra Packages for Enterprise Linux 6 - $basearch
baseurl=http://mirrors.aliyun.com/epel-archive/6/$basearch
        http://mirrors.aliyuncs.com/epel-archive/6/$basearch
        http://mirrors.cloud.tencent.com/epel/6/$basearch
        http://mirrors.tencentyun.com/epel/6/$basearch
#mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch
failovermethod=priority
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6

[epel-debuginfo]
name=Extra Packages for Enterprise Linux 6 - $basearch - Debug
baseurl=http://mirrors.aliyun.com/epel-archive/6/$basearch/debug
        http://mirrors.aliyuncs.com/epel-archive/6/$basearch/debug
        http://mirrors.cloud.tencent.com/epel/6/$basearch/debug
        http://mirrors.tencentyun.com/epel/6/$basearch/debug
#mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-debug-6&arch=$basearch
failovermethod=priority
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
gpgcheck=0

[epel-source]
name=Extra Packages for Enterprise Linux 6 - $basearch - Source
baseurl=http://mirrors.aliyun.com/epel-archive/6/SRPMS
        http://mirrors.aliyuncs.com/epel-archive/6/SRPMS
        http://mirrors.cloud.tencent.com/epel/6/SRPMS
        http://mirrors.tencentyun.com/epel/6/SRPMS
#mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-source-6&arch=$basearch
failovermethod=priority
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
gpgcheck=0
```
