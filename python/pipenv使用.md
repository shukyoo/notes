## pipenv命令
```
pip install --user --upgrade pipenv# 用户安装pipenv
 
pipenv --three  # 会使用当前系统的Python3创建环境
pipenv --two  # 使用python2创建
pipenv --python 3.6 指定某一Python版本创建环境
 
pipenv run python 文件名
pipenv run pip ...  # 运行pip
 
pipenv shell 激活虚拟环境
 
pipenv --where 显示目录信息
 
pipenv --venv 显示虚拟环境信息
 
pipenv --py 显示Python解释器信息
 
pipenv install requests 安装相关模块并加入到Pipfile
 
pipenv install django==1.11 安装固定版本模块并加入到Pipfile
 
pipenv graph # 显示依赖图
 
pipenv check #检查安全漏洞
 
pipenv uninstall requests# 卸载包并从Pipfile中移除
 
pipenv uninstall --all# 卸载全部包
```
