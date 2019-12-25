```
version: '3.2'

services:
    my-test:
      image: php7.1
      restart: always
      cap_add:   // php要加这个才能记error-log
        - SYS_PTRACE
      volumes:
        - /usr/local/data/p1/src:/var/data
        - /usr/local/data/p1/logs:/var/log
      stdin_open: true  // 这两行在docker-compose up的时候真正attach进，为-it的功能
      tty: true
      ports:
        - "8080:8000"  // 端口绑定
      expose:
        - "8000"  // 只暴露端口，不绑定
      depends_on:  // 先后依赖
        - db
        - redis
    environment:  // 环境变量
      VIRTUAL_HOST: p1.test
    extra_hosts:  // hosts
      - "mysql:ip"
      - "nginx:ip"
    networks:
      p1-net:
        aliases:
          - p1.test

// 或者以下的网络配置
networks:
    default:
        external:
            name: test2-net
```
