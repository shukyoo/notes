## gcc, gcc-c++, toolchain等等的工具升级或版本更换

```
yum install centos-release-scl -y
yum install devtoolset-6-gcc -y  （devtoolset有很多版本可选）
# yum install devtoolset-6-toolchain -y （工具链，按需求安装）
# devtoolset-1.1  devtoolset-2  devtoolset-3 devtoolset-4，以上版本分别对应gcc的版本为4.7、4.8、4.9、5.2......
source /opt/rh/devtoolset-6/enable  （启用）
```
