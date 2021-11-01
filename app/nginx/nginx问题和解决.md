## nginx error.log出现大量的a client request body is buffered to a temporary file
* 是取客户端请求体的缓冲区太小的原因
```
client_max_body_size 50m;
client_body_buffer_size 30m;
```
