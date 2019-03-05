### 配置文件
```
sqs:aws-sqs-queue-name
email:myemail@gmail.com
```


### shell
```shell
while IFS='' read -r line || [[ -n "$line" ]]; do
  IFS=':' read -r protocol endpoint <<< "$line"
  echo "Protocol: $protocol - Endpoint: $endpoint"
done < "$file"
```

### 输出
```
Protocol: sqs - Endpoint: aws-sqs-queue-name
Protocol: email - Endpoint: myemail@gmail.com
```


### 参考
[https://www.jianshu.com/p/a741d935b2ec](https://www.jianshu.com/p/a741d935b2ec)
