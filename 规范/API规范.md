## 简述
业务接口code定义，统一和规范code定义   
如果header返回http code，则业务code跟http code保持一致，比如200，反之未必   
除此以外，业务code不占用http code，通过自定义code 定义业务结果

## 接口格式
#### 成功
```json
{
  "code": 200,
  "data": {  // 成功数据封装，可选
  },
  "meta": {  // 成功meta数据，如总数等，可选
  }
}
```

####  失败
```json
{
  "code": 1000,
  "msg": "xxxx",
  "data": {  // 附带数据，可选
  }
}
```

## 定义
| code | 定义 | 备注 |
| --- | --- | --- |
| 200 | 成功 | 同时http code = 200；另外http code=200也只代表接口请求成功，可能业务code是失败的；只有业务code=200即明确的成功 |
| 404	| 接口不存在 方法不存在 | 同时http code = 404 |
| 405	| 方法不允许 如：GET请求POST | 同时http code=405 |
| 401	| 未授权，未登录等 |	同时http code=401 |
| 403	| forbiden |	同时http code=403 |
| --- |  |  |
| 1000 | 一般性通用错误 | 适用于对错误code无要求的一般性通用错误；同时一般1000以上的业务错误code对应的http code=200 |
| --- |  |  |
| **11xx** |	代表输入验证错误 |	更多待补充，1150后可自定义 |
| 1101 |	请求参数错误	| | 
| 1102 |	签名错误	 | |
| 1103 |	请求验证失败	| | 
| --- |  |  |
| **12xx** |	代表数据结果错误 |	更多待补充，1250后可自定义 |
| 1201 |	数据不存在	 | |
| 1202 |	数据不一致	 | |
| 1203 |	数据状态/类型/属性错误	 | |
| --- |  |  |
| **20xx** |	代表数据写入错误 |	更多待补充，2050后可自定义 |
| 2001 |	数据更新失败	 | |

13xx, 14xx, 21xx, 22xx 等意义都可待补充定义
 	 	 
