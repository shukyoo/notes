## 删除所有容器
```
docker rm `docker ps -a -q`  // -q表示只列出id
```

## 删除所有停止状态的容器
```
# 方法1
docker container prune

# 方法2
docker rm $(docker ps -qf status=exited)
```

## 停止/删除查找出的容器
```
docker stop `docker ps -a | grep test- | awk '{print $1}'`
docker rm `docker ps -a | grep test- | awk '{print $1}'`
```

## 删除所有镜像
```
docker rmi `docker images -q`
```

## 按条件删除镜像
```
# 没有打标签
docker rmi `docker images -q | awk '/^<none>/ { print $3 }'`

# 镜像名包含关键字
docker rmi --force `docker images | grep doss-api | awk '{print $3}'`    //其中doss-api为关键字
```

## 删除所有未使用的容器，镜像、网络
```
docker system prune -a -f
```

## 删除所有未使用的镜像
```
docker image prune
```

## 删除所有未使用的网络
```
docker network prune
```

## 删除所有不使用的数据卷
```
docker volume prune
```
