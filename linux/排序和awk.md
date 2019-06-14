## 某个目录下所有目录和文件按从大到小排序（human-readable）
```shell
du -sh /usr/* | sort -rh
```

## 统计nginx最大的访问
awk '{print $7}' access.log | awk -F '?' '{print $1}' | sort | uniq -c | sort -nr | head -20
