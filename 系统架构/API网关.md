## API网关要起到的作用
认证、鉴权、安全、流量管控、缓存、服务路由，协议转换、服务编排、熔断、灰度发布、监控报警


## 选型和比较
| 技术栈 | 特点 | 代表 | 备注 |
| --- | --- | --- | --- |
| openresty+lua |	超强性能 |	Kong、APISIX、3scale、API Umbrella |	Kong不用做太多介绍，应该是开源里面最热的一个api网关了，相对庞大复杂    APISIX，轻巧+极致性能+热插件，值得一提到是插件中有个serverless的支持，简单说就是写一段自定义lua脚本，挂载到openresty任意阶段执行！ |
| golang |	性能，跨平台，部署方便 |	Tky、Manba、GOKU API Gateway、Ambassador(基于Envoy)、Gloo(基于Envoy)、KrakenD、BFE	  |
| java	 |  | 	Gravitee、Zuul、Sentinel、MuleSoft、WSO2、Soul	 |

## 参考
[各大API网关性能比较](https://cloud.tencent.com/developer/article/1415041)
