## 什么是JWT
JSON Web Token (JWT)是一个开放标准(RFC 7519)，它定义了一种紧凑的、自包含的方式，用于作为JSON对象在各方之间安全地传输信息。该信息可以被验证和信任，因为它是数字签名的。

## JWT特点
* 紧凑：指的是这个串很小，能通过url 参数，http 请求提交的数据以及http header的方式来传递
* 自包含：这个串可以包含很多信息，比如用户的id、角色等，别人拿到这个串，就能拿到这些关键的业务信息，从而避免再通过数据库查询等方式才能得到它们

## JWT结构
**header:**
> Authorization: Bearer JWT_TOKEN
这里的token就是jwt内容，它分为三段：header（头部）、payload（载荷）、signature（签名），以.进行分割，（aaaa.bbbb.cccc）
如：
```
eyJhbGciOiJIUzUxMiJ9.eyJsb2dpbl91c2VyX2tleSI6IjEyYjQyMzEwLTkxMDktNGZhOC1iMjBkLTliZTQyMzY0YmUzNiJ9.vfzudtIIdviuz9uK1bpRQAP6aONJjtBVBqKrRITBycOnYOngrTPudi1USWalco8_D8Lw6HofmTrJiQIEF2Z-sw
```
* header用来声明类型（typ）和算法（alg）。
* payload一般存放一些不敏感的信息，比如用户名、权限、角色等。
* signature则是将header和payload对应的json结构进行base64url编码之后得到的两个串用英文句点号拼接起来，然后根据header里面alg指定的签名算法生成出来的。

## 和session的区别
* Session传递的sessionId虽然是一个更简单的字符串，但它本身并没有任何含义
* JWT的header和payload其实是有json转变过来的，因此解析起来较为简单，不需要其他辅助的内容，sessionId是服务器存储的用户对象的标识，理论上需要一个额外的map才能找出当前用户的信息。
* JWT理论上用于无状态的请求，因此其用户管理也只是依赖本身而已。我们一般是在它的payload中加入过期时间，Session因为它本就是存储在服务器端的，因此管理方案就有很多
* JWT本身就是基于json的，因此它是比较容易跨平台的
  
## 适用场景
### JWT
JWT的最佳用途是一次性授权Token，这种场景下的Token的特性如下：

* 有效期短
* 只希望被使用一次

**下列场景中使用JWT是很有用的**
* Authorization (授权) : 这是使用JWT的最常见场景。一旦用户登录，后续每个请求都将包含JWT，允许用户访问该令牌允许的路由、服务和资源。单点登录是现在广泛使用的JWT的一个特性，因为它的开销很小，并且可以轻松地跨域使用。
* Information Exchange (信息交换) : 对于安全的在各方之间传输信息而言，JSON Web Tokens无疑是一种很好的方式。因为JWTs可以被签名，例如，用公钥/私钥对，你可以确定发送人就是它们所说的那个人。另外，由于签名是使用头和有效负载计算的，您还可以验证内容没有被篡改。


### Session
Session比较适用于Web应用的会话管理，其特点一般是：

* 权限多，如果用JWT则其长度会很长，很有可能突破Cookie的存储限制。
* 基本信息容易变动。如果是一般的后台管理系统，肯定会涉及到人员的变化，那么其权限也会相应变化，如果使用JWT，那就需要服务器端进行主动失效，这样就将原本无状态的JWT变成有状态，改变了其本意。

## 参考
* [JWT与Session的比较](https://zhuanlan.zhihu.com/p/82785839)
* [BearerToken之JWT的介绍](https://www.cnblogs.com/lori/p/11246611.html)
* [JWT与Session比较和作用](https://www.cnblogs.com/hellohorld/p/11022967.html)
