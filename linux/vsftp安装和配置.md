## 安装

1. yum install vsftpd

2. 创建ftp用户 （useradd -s /sbin/nologin vsftpd）

3. 建立虚拟用户：
```
# 编辑虚拟用户名单文件：
#（第一行账号，第二行密码，注意：不能使用root做用户名，系统保留）
vim /etc/vsftpd/virtusers
# 编辑内容，下面是 virtusers 内容
test
123456

# 添加到chroot管理列表
vim /etc/vsftpd/chroot_list
# 用户列表
test
```

4. 生成虚拟用户数据文件
```
rpm -qa | grep db
# 确实没安装，就查下yum可提供的版本
yum  search db4
# 安装（或者安装libdb-utils.x86_64）
yum install-y compat-db47.x86_64
```
```
# 利用db_load命令生成数据文件
db_load -T -t hash -f /etc/vsftpd/virtusers /etc/vsftpd/virtusers.db
# 设定PAM验证文件，并指定对虚拟用户数据库文件进行读取(权限r,w即可)
chmod 600 /etc/vsftpd/virtusers.db
```

5. 添加vsftpd的虚拟用户的验证
```
vim /etc/pam.d/vsftpd
# -------------内容如下-----------------
#%PAM-1.0
auth sufficient /lib64/security/pam_userdb.so db=/etc/vsftpd/virtusers
account sufficient /lib64/security/pam_userdb.so db=/etc/vsftpd/virtusers
session    optional     pam_keyinit.so    force revoke
auth       required pam_listfile.so item=user sense=deny file=/etc/vsftpd/ftpusers onerr=succeed
auth       required pam_shells.so
auth       include  password-auth
account    include  password-auth
session    required     pam_loginuid.so
session    include  password-auth
```

6. 创建虚拟用户个人配置文件
```
# 建立虚拟用户个人vsftp的配置文件
mkdir -p /etc/vsftpd/vconf
# 进入目录
cd /etc/vsftpd/vconf

# 创建并编辑用户的配置文件
vim test

# 用户 test 配置目录
local_root=/home/vsftpd/test
# 允许本地用户对FTP服务器文件具有写权限
write_enable=YES
anon_world_readable_only=NO
# 允许匿名用户上传文件(须将全局的write_enable=YES,默认YES)
anon_upload_enable=YES
# 允许匿名用户创建目录
anon_mkdir_write_enable=YES
# 允许匿名用户删除和重命名权限(自行添加)
anon_other_write_enable=YES
```
```
# 创建用户目录
mkdir -p /home/vsftpd/test
```

7. 修改配置文件：/etc/vsftpd/vsftpd.conf
```
# 开启虚拟用户
guest_enable=YES
# 主虚拟用户名vsftpd，等下会建立
guest_username=vsftpd
# 虚拟用户配置（可以对每一个虚拟用户进行单独的权限配置）
user_config_dir=/etc/vsftpd/vconf

# 虚拟用户和本地用户有相同的权限
virtual_use_local_privs=YES
```

## 使用
```shell
#从FTP上下载单文件到本地
#!/bin/sh
ftp -v -n 10.11.10.11<<EOF
user ftpuser ftppwd
binary
cd Down
lcd ./
prompt
#get down.txt
get down.txt note.txt
bye
EOF
echo "download from ftp successfully"
```


## 参考：
[CentOS 安装FTP服务器](https://blog.csdn.net/kxwinxp/article/details/78595044)

[Shell脚本实现FTP上传下载文件](https://blog.csdn.net/u012842255/article/details/66969501)

[FTP Commands for Linux and UNIX](https://www.serv-u.com/features/file-transfer-protocol-server-linux/commands)
