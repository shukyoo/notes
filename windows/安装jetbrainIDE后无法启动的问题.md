## 问题
安装完goland，无法启动，没有响应

## 排查过程
1. 打开cmd console
2. cd到goland/bin目录，执行goland.bat，它会有错误输出
3. 我这次的错误是类型 EXCEPTION_ACCESS_VIOLATION  C [SrjdDll64.dll] 字样
4. 使用Everything工具查找这个ddl, 方法一是把软件卸载，方法二是设置此ddl权限

## 权限设置方式
1. 右键 - 属性 - 安全
2. 编辑 - 添加 - 输入everyone - 勾选Everyone的权限都为拒绝

