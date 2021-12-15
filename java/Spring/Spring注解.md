## @Value注解
该注解作用的作用是将我们配置文件的属性读出来，有@Value("${}")和@Value("#{}")两种方式
* @Value("${property : default_value}"): 获取配置文件中的信息
* @Value("#{obj.property? :default_value}")：获取对象的property属性值

## @SpingBootTest
使用@SpringBootTest后，Spring将加载所有被管理的bean，基本等同于启动了整个服务，此时便可以开始功能测试。    
详见：[SpringBoot测试](https://github.com/shukyoo/notes/blob/master/java/Spring/SpringBoot%E6%B5%8B%E8%AF%95.md)

## @Resource和@Autowired
@Resource和@Autowired注解都是用来实现依赖注入的。只是@AutoWried按by type自动注入，而@Resource默认按byName自动注入。
* @Autowired默认按类型装配（这个注解是属业spring的），默认情况下必须要求依赖对象必须存在，如果要允许null 值，可以设置它的required属性为false，如：@Autowired(required=false) ，如果我们想使用名称装配可以结合@Qualifier注解进行使用，如下： 
```
@Autowired() @Qualifier("baseDao")     
private BaseDao baseDao;   
```
* @Resource（这个注解属于J2EE的），默认安照名称进行装配，名称可以通过name属性进行指定， 
如果没有指定name属性，当注解写在字段上时，默认取字段名进行按照名称查找，如果注解写在setter方法上默认取属性名进行装配。 当找不到与名称匹配的bean时才按照类型进行装配。但是需要注意的是，如果name属性一旦指定，就只会按照名称进行装配。
```
@Resource(name="baseDao")     
private BaseDao baseDao;
```
推荐使用：@Resource注解在字段上，且这个注解是属于J2EE的，减少了与spring的耦合，这样代码看起就比较优雅。

## @Mapper和MapperScan
* @Mapper 让mybatis的mapper接口导入spring容器中管理，每个Mapper类都要加此注解；
* @MapperScan 在启动类中加此注解，指定要扫描的Mapper类的包的路径，也可以指定多个包；

## @Service注解
1. 声明当前service是一个bean，导入到spring容器管理
2. @service引用了@component注解，也就是component注解实现的功能@service都能实现
3. 被spring认定是业务逻辑层，里面有spring对业务逻辑层管理的一对逻辑
4. 括号内指定别名
