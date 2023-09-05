# SSL 认证
可以将 SSL 服务器与客户端之间的通信配置为使用单向或双向 SSL 认证。    

单向 SSL 认证一般是客户端利用服务器传过来的信息验证服务器的合法性，服务器的合法性包括：证书是否过期，发行服务器证书的 CA 是否可靠，发行者证书的公钥能否正确解开服务器证书的“发行者的数字签名”，服务器证书上的域名是否和服务器的实际域名相匹配。    

双向 SSL 认证则除了需要对服务器的合法性进行认证，还需要按照单向 SSL 认证方法对客户端的合法性进行认证。    

在金融支付过程中，对安全要求级别比较高的接口，不仅要验证签名，还要进行双向验证 SSL 证书，因此有些就需要安装在服务开通之后第三方给我们发送的安全证书了。    

为了便于更好的认识和理解 SSL 协议，这里着重介绍 SSL 协议的握手协议。SSL 协议既用到了公钥加密技术又用到了对称加密技术，对称加密技术虽然比公钥加密技术的速度快，可是公钥加密技术提供了更好的身份认证技术。SSL 的握手协议非常有效的让客户和服务器之间完成相互之间的身份认证，其主要过程如下：    
1. 客户端的浏览器向服务器传送客户端 SSL 协议的版本号，加密算法的种类，产生的随机数，以及其他服务器和客户端之间通讯所需要的各种信息。
2. 服务器向客户端传送 SSL 协议的版本号，加密算法的种类，随机数以及其他相关信息，同时服务器还将向客户端传送自己的证书。
3. 客户利用服务器传过来的信息验证服务器的合法性，服务器的合法性包括：证书是否过期，发行服务器证书的 CA 是否可靠，发行者证书的公钥能否正确解开服务器证书的“发行者的数字签名”，服务器证书上的域名是否和服务器的实际域名相匹配。如果合法性验证没有通过，通讯将断开；如果合法性验证通过，将继续进行第四步。
4. 用户端随机产生一个用于后面通讯的“对称密码”，然后用服务器的公钥（服务器的公钥从步骤②中的服务器的证书中获得）对其加密，然后将加密后的“预主密码”传给服务器。
5. 如果服务器要求客户的身份认证（在握手过程中为可选），用户可以建立一个随机数然后对其进行数据签名，将这个含有签名的随机数和客户自己的证书以及加密过的“预主密码”一起传给服务器。
6. 如果服务器要求客户的身份认证，服务器必须检验客户证书和签名随机数的合法性，具体的合法性验证过程包括：客户的证书使用日期是否有效，为客户提供证书的 CA 是否可靠，发行 CA 的公钥能否正确解开客户证书的发行 CA 的数字签名，检查客户的证书是否在证书废止列表（CRL）中。检验如果没有通过，通讯立刻中断；如果验证通过，服务器将用自己的私钥解开加密的“预主密码”，然后执行一系列步骤来产生主通讯密码（客户端也将通过同样的方法产生相同的主通讯密码）。
7. 服务器和客户端用相同的主密码即“通话密码”，一个对称密钥用于 SSL 协议的安全数据通讯的加解密通讯。同时在 SSL 通讯过程中还要完成数据通讯的完整性，防止数据通讯中的任何变化。
8. 客户端向服务器端发出信息，指明后面的数据通讯将使用的步骤⑦中的主密码为对称密钥，同时通知服务器客户端的握手过程结束。
9. 服务器向客户端发出信息，指明后面的数据通讯将使用的步骤⑦中的主密码为对称密钥，同时通知客户端服务器端的握手过程结束。
10. SSL 的握手部分结束，SSL 安全通道的数据通讯开始，客户和服务器开始使用相同的对称密钥进行数据通讯，同时进行通讯完整性的检验。

双向认证 SSL 协议的具体过程
1. 浏览器发送一个连接请求给安全服务器。
2. 服务器将自己的证书，以及同证书相关的信息发送给客户浏览器。
3. 客户浏览器检查服务器送过来的证书是否是由自己信赖的 CA 中心所签发的。如果是，就继续执行协议；如果不是，客户浏览器就给客户一个警告消息：警告客户这个证书不是可以信赖的，询问客户是否需要继续。
4. 接着客户浏览器比较证书里的消息，例如域名和公钥，与服务器刚刚发送的相关消息是否一致，如果是一致的，客户浏览器认可这个服务器的合法身份。
5. 服务器要求客户发送客户自己的证书。收到后，服务器验证客户的证书，如果没有通过验证，拒绝连接；如果通过验证，服务器获得用户的公钥。
6. 客户浏览器告诉服务器自己所能够支持的通讯对称密码方案。
7. 服务器从客户发送过来的密码方案中，选择一种加密程度最高的密码方案，用客户的公钥加过密后通知浏览器。
8. 浏览器针对这个密码方案，选择一个通话密钥，接着用服务器的公钥加过密后发送给服务器。
9. 服务器接收到浏览器送过来的消息，用自己的私钥解密，获得通话密钥。
10. 服务器、浏览器接下来的通讯都是用对称密码方案，对称密钥是加过密的。
  
　　上面所述的是双向认证 SSL 协议的具体通讯过程，这种情况要求服务器和用户双方都有证书。单向认证 SSL 协议不需要客户拥有 CA 证书，具体的过程相对于上面的步骤，只需将服务器端验证客户证书的过程去掉，以及在协商对称密码方案，对称通话密钥时，服务器发送给客户的是没有加过密的（这并不影响 SSL 过程的安全性）密码方案。 这样，双方具体的通讯内容，就是加过密的数据，如果有第三方攻击，获得的只是加密的数据，第三方要获得有用的信息，就需要对加密的数据进行解密，这时候的安全就依赖于密码方案的安全。而幸运的是，目前所用的密码方案，只要通讯密钥长度足够的长，就足够的安全。这也是我们强调要求使用 128 位加密通讯的原因。

# 认证实现
与 SSL 单向认证相关的 curl_easy_setopt 选项有以下几个：

* CURLOPT_SSL_VERIFYPEER： cURL 是否验证对等证书（peer's certificate），值为 1，则验证，为 0 则不验证。要验证的交换证书可以在 CURLOPT_CAINFO 选项中设置，或在 CURLOPT_CAPATH中设置证书目录。
* CURLOPT_SSL_VERIFYHOST：值为1 ： cURL 检查服务器SSL证书中是否存在一个公用名(common name)；值为2： cURL 会检查公用名是否存在，并且是否与提供的主机名匹配；0 为不检查名称。这里的 common name 是在创建证书过程中指定，例如 subj 选项值中的 /CN 值； openssl req -subj "/C=CN/ST=IL/L=ShenZhen/O=Tencent/OU=Tencent/CN=luffichen_server.tencent.com/emailAddress=luffichen@www.tencent.com" ...
* CURLOPT_CAINFO：一个保存着1个或多个用来让服务端验证的证书的文件名。这个参数仅仅在和CURLOPT_SSL_VERIFYPEER一起使用时才有意义。
* CURLOPT_CAPATH：一个保存着多个CA证书的目录。这个选项是和CURLOPT_SSL_VERIFYPEER一起使用的。

与 SSL 双向认证相关的 curl_easy_setopt 选项有以下几个：

* CURLOPT_SSLCERT：客户端证书路径
* CURLOPT_SSLCERTTYPE：证书的类型。支持的格式有"PEM" (默认值), "DER"和"ENG"。
* CURLOPT_SSLKEY：客户端私钥的文件路径
* CURLOPT_SSLKEYTYPE：客户端私钥类型，支持的私钥类型为"PEM"(默认值)、"DER"和"ENG"。
* CURLOPT_KEYPASSWD：客户端私钥密码，私钥在创建时可以选择加密。
```
if(!oneway_certification)
{
    // 验证服务器证书有效性
    curl_easy_setopt(m_curl_handler, CURLOPT_SSL_VERIFYPEER, 1);
    // 检验证书中的主机名和你访问的主机名一致
    curl_easy_setopt(m_curl_handler, CURLOPT_SSL_VERIFYHOST, 2);
    // 指定 CA 证书路径
    curl_easy_setopt(m_curl_handler, CURLOPT_CAINFO, m_ca_cert_file.c_str());
}
else
{
    // 不验证服务器证书
    curl_easy_setopt(m_curl_handler, CURLOPT_SSL_VERIFYPEER, 0);
    curl_easy_setopt(m_curl_handler, CURLOPT_SSL_VERIFYHOST, 0);
}

if(!client_cert_file.empty())
{
    // 客户端证书，用于双向认证
    curl_easy_setopt(m_curl_handler, CURLOPT_SSLCERT, client_cert_file.c_str());
}

if(!client_cert_type.empty())
{
    // 客户端证书类型，用于双向认证
    curl_easy_setopt(m_curl_handler, CURLOPT_SSLCERTTYPE, client_cert_type.c_str());
}

if(!private_key.empty())
{
    // 客户端证书私钥，用于双向认证
    curl_easy_setopt(m_curl_handler, CURLOPT_SSLKEY, private_key.c_str());
}

if(!private_key_type.empty())
{
    // 客户端证书私钥类型，用于双向认证
    curl_easy_setopt(m_curl_handler, CURLOPT_SSLKEYTYPE, private_key_type.c_str());
}

if(!private_key_passwd.empty())
{
    // 客户端证书私钥密码
    curl_easy_setopt(m_curl_handler, CURLOPT_KEYPASSWD, private_key_passwd.c_str());
}
```
说明：设置 curl 选项时，这里对空值进行判断，如果为空，则不进行双向认证了。

# 问题解决
## curl不支持 https
```
curl -V
curl 7.56.0-DEV (Linux) libcurl/7.56.0-DEV OpenSSL/1.0.1e zlib/1.2.3
Release-Date: [unreleased]
Protocols: dict file ftp ftps gopher http https imap imaps pop3 pop3s rtsp smb smbs smtp smtps telnet tftp 
Features: AsynchDNS IPv6 Largefile NTLM SSL libz UnixSockets HTTPS-proxy 
```
如果没有，Features 中没有 ssl，则需要重新编译支持 ssl 的 curl 版本（./configure --with-ssl）    

在编译时，可按照 curl 官网给出的方法进行：
```
./configure --with-ssl
If you have OpenSSL installed somewhere else (for example, /opt/OpenSSL) and you have pkg-config installed, set the pkg-config path first, like this:

env PKG_CONFIG_PATH=/opt/OpenSSL/lib/pkgconfig ./configure --with-ssl
Without pkg-config installed, use this:

./configure --with-ssl=/opt/OpenSSL

If you insist on forcing a build without SSL support, even though you may have OpenSSL installed in your system, you can run configure like this:

./configure --without-ssl

If you have OpenSSL installed, but with the libraries in one place and the header files somewhere else, you have to set the LDFLAGS and CPPFLAGS environment variables prior to running configure. Something like this should work:

CPPFLAGS="-I/path/to/ssl/include" LDFLAGS="-L/path/to/ssl/lib" ./configure
If you have shared SSL libs installed in a directory where your run-time linker doesn't find them (which usually causes configure failures), you can provide the -R option to ld on some operating systems to set a hard-coded path to the run-time linker:

LDFLAGS=-R/usr/local/ssl/lib ./configure --with-ssl
```
另外要注意 openssl 不同版本对 ssl 协议版本的支持。仅 openssl 1.0.2 及其以上版本目前支持 TLS 1.2 版本的。    

在编译 openssl 1.0.2h 时发现其生成的 libssl 文件为 libss.so.1.0.0/libcrypto.so.1.0.0 而不是 libssl.so.1.0.2/libcrypto.so.1.0.2，这里的 ssl 库的版本和软件版本的编号是不一致的，这么做的原因 Richard Levitte 做了解释：

> We recognised that our shared library version numbering was confusing, so from OpenSSL version 1.1.0 and up, the shared library version retains the two first digits of the OpenSSL version only, which reflects our intent that for any versions x.y.z where x.y stays the same, ABI backward compatibility will be maintained.

## SSL certificate problem, verify that the CA cert is OK
当 CURLOPT_SSL_VERIFYPEER 为 1 时，表示启用了验证访问的服务器合法性，且必须设置 CURLOPT_CAINFO 或 CURLOPT_CAPATH 其中一个，而 CURLOPT_SSL_VERIFYHOST 为 2 时，表示验证 CA 证书中的 common name 是否与访问的服务器域名是否一致。在测试的时候，需要记得为客户端侧机器添加相应的 host 域名 IP 解析，如果直接使用 IP 访问也会报 SSL certificate problem, verify that the CA cert is OK 错误。

## curl: (60) SSL certificate : unable to get local issuer certificate
问题的原因有很多，这里只列举一二。    

在验证服务器证书时，找不到CA证书，如果正确设置了 cainfo 或 capath 参数且 CA 证书已经是 rootCA，依然出错，那么可能是证书生成的时候出错，再重新生成一个；如果 CA 证书由一个中间证书签发，rootCA 签发中间证书，那么如果服务器没有提供中间证书，在验证过程中，openssl 在形成完整的证书链也会报这个错误，所以 cat intermediate.crt >> domain.crt 将所有中间证书与rootCA证书捆绑在一起。


# 补充
CURL访问HTTPS，返回错误35 SSL connect error
先尝试升级nss等
```
yum update nss nss-util nspr -y
```
升级不行的话：
尝试用 curl -k1 https://xxx 能通
增加：curl_setopt($ch, CURLOPT_SSLVERSION, 1);
变成如下：
```
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
curl_setopt($ch, CURLOPT_SSLVERSION, 1);
```

# 参考
* [使用 curl 进行 ssl 认证](https://www.cnblogs.com/cposture/p/9029014.html)
* [PHP使用CURL访问HTTPS，返回错误35 SSL connect error](https://blog.csdn.net/weixin_36441117/article/details/114684742)
