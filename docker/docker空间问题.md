## devicemapper
* [Docker内部存储结构（devicemapper）解析](https://hustcat.github.io/docker-devicemapper/)
* [Docker存储驱动devicemapper配置](https://www.jianshu.com/p/4fb3e3103762)
* [Docker动态扩容Pool大小与container大小](https://docs.lvrui.io/2016/12/12/Docker%E5%8A%A8%E6%80%81%E6%89%A9%E5%AE%B9Pool%E5%A4%A7%E5%B0%8F%E4%B8%8Econtainer%E5%A4%A7%E5%B0%8F/)


## 查看空间占用
```shell
docker system df
docker  system df -v  # 更详细
```

## 根据目录找到容器
```shell
# 先通过du找到最大的目录
du -sh * | sort -hr

# 再通过目录名找到容器
for c in `docker ps -qa`; \
do \
  docker inspect $c \
  | grep -i '9725023.....5a185c73' && \
  echo $c; \
done
```


## 空间清理
```shell
# 清理停掉的container、悬挂的image（没有tag）、没有使用的network、数据卷
docker system  prune

# 可以清理所有的东西，包括没有使用的镜像
docker system  prune -a
```
