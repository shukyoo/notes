## @Value注解
该注解作用的作用是将我们配置文件的属性读出来，有@Value("${}")和@Value("#{}")两种方式
* @Value("${property : default_value}"): 获取配置文件中的信息
* @Value("#{obj.property? :default_value}")：获取对象的property属性值

## @SpingBootTest
使用@SpringBootTest后，Spring将加载所有被管理的bean，基本等同于启动了整个服务，此时便可以开始功能测试。    
详见：[SpringBoot测试](https://github.com/shukyoo/notes/blob/master/java/Spring/SpringBoot%E6%B5%8B%E8%AF%95.md)
