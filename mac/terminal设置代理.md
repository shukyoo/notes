## socks5方式
socks5 代理方式，可以通过 ALL_PROXY 参数值来设置。    
编辑 ~/.zshrc 文件，假设代理工具的 socks5 端口为 1080 ，则：
```
alias proxys5='export ALL_PROXY=socks5://127.0.0.1:1080'
alias unproxys5='unset ALL_PROXY'
```
之后执行 source ~/.zshrc 使配置生效。    
那么，启用和关闭终端下的代理则执行 proxys5 和 unproxys5 即可。

## http方式
http 方式需要通过 http_proxy 和 https_proxy 两个参数来配置。    
编辑 ~/.zshrc 文件，假设代理工具的 http 端口为 1087 ，则：
```
alias proxyhp='export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;'
alias unproxyhp='unset http_proxy https_proxy'
```
之后执行 source ~/.zshrc 使配置生效。    
那么，启用和关闭终端下的代理则执行 proxyhp 和 unproxyhp 即可。

