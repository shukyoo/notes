整体上，Spring Boot Test支持的测试种类，大致可以分为如下三类：

* 单元测试：一般面向方法，编写一般业务代码时，测试成本较大。涉及到的注解有@Test。
* 切片测试：一般面向难于测试的边界功能，介于单元测试和功能测试之间。涉及到的注解有@RunWith @WebMvcTest等。
* 功能测试：一般面向某个完整的业务功能，同时也可以使用切面测试中的mock能力，推荐使用。涉及到的注解有@RunWith @SpringBootTest等。

功能测试过程中的几个关键要素及支撑方式如下：

* 测试运行环境：通过@RunWith 和 @SpringBootTest启动spring容器。
* mock能力：Mockito提供了强大mock功能。
* 断言能力：AssertJ、Hamcrest、JsonPath提供了强大的断言能力。

增加spring-boot-starter-test依赖，使用@RunWith和@SpringBootTest注解，即可开始测试。    
添加依赖
```
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-test</artifactId>
  <scope>test</scope>
</dependency>
```
一旦依赖了spring-boot-starter-test，下面这些类库将被一同依赖进去：

* JUnit：java测试事实上的标准，默认依赖版本是4.12（JUnit5和JUnit4差别比较大，集成方式有不同）。
* Spring Test & Spring Boot Test：Spring的测试支持。
* AssertJ：提供了流式的断言方式。
* Hamcrest：提供了丰富的matcher。
* Mockito：mock框架，可以按类型创建mock对象，可以根据方法参数指定特定的响应，也支持对于mock调用过程的断言。
* JSONassert：为JSON提供了断言功能。
* JsonPath：为JSON提供了XPATH功能。

### 单元测试
```java
@RunWith(SpringRunner.class)
@SpringBootTest
public class SpringBootApplicationTests {

    @Autowired
    private UserService userService;

    @Test
    public void testAddUser() {
        User user = new User();
        user.setName("john");
        user.setAddress("earth");
        userService.add(user);
    }
}
```
@RunWith是Junit4提供的注解，将Spring和Junit链接了起来。假如使用Junit5，不再需要使用    
@SpringBootTest替代了spring-test中的@ContextConfiguration注解，目的是加载ApplicationContext，启动spring容器。    
使用@SpringBootTest时并没有像@ContextConfiguration一样显示指定locations或classes属性，原因在于@SpringBootTest注解会自动检索程序的配置文件，检索顺序是从当前包开始，逐级向上查找被@SpringBootApplication或@SpringBootConfiguration注解的类。

### 功能测试
使用@SpringBootTest后，Spring将加载所有被管理的bean，基本等同于启动了整个服务，此时便可以开始功能测试。    

由于web服务是最常见的服务，且我们对于web服务的测试有一些特殊的期望，所以@SpringBootTest注解中，给出了webEnvironment参数指定了web的environment，该参数的值一共有四个可选值：

* MOCK：此值为默认值，该类型提供一个mock环境，可以和@AutoConfigureMockMvc或@AutoConfigureWebTestClient搭配使用，开启Mock相关的功能。注意此时内嵌的服务（servlet容器）并没有真正启动，也不会监听web服务端口。
* RANDOM_PORT：启动一个真实的web服务，监听一个随机端口。
* DEFINED_PORT：启动一个真实的web服务，监听一个定义好的端口（从application.properties读取）。
* NONE：启动一个非web的ApplicationContext，既不提供mock环境，也不提供真实的web服务。
注：如果当前服务的classpath中没有包含web相关的依赖，spring将启动一个非web的ApplicationContext，此时的webEnvironment就没有什么意义了。

### 切片测试
slice是指一些在特定环境下才能执行的模块，比如MVC中的Controller、JDBC数据库访问、Redis客户端等，这些模块大多脱离特定环境后不能独立运行，假如spring没有为此提供测试支持，开发者只能启动完整服务对这些模块进行测试，这在一些复杂的系统中非常不方便，所以spring为这些模块提供了测试支持，使开发者有能力单独对这些模块进行测试。    

通过@\*Test开启具体模块的测试支持，开启后spring仅加载相关的bean，无关内容不会被加载。    

使用@WebMvcTest用来校验controllers是否正常工作的示例：
```java
@RunWith(SpringRunner.class)
@WebMvcTest(IndexController.class)
public class SpringBootTest {
    @Autowired
    private MockMvc mvc;
    
    @Test
    public void testExample() throws Exception {
        //groupManager访问路径
        //param传入参数
        MvcResult result=mvc.perform(MockMvcRequestBuilders.post("/groupManager").param("pageNum","1").param("pageSize","10")).andReturn();
        MockHttpServletResponse response = result.getResponse();
        String content = response.getContentAsString();
        List<JtInfoDto> jtInfoDtoList = GsonUtils.toObjects(content, new TypeToken<List<JtInfoDto>>() {}.getType());
        for(JtInfoDto infoDto : jtInfoDtoList){
            System.out.println(infoDto.getJtCode());
        }
    }
}
```
使用@WebMvcTest和MockMvc搭配使用，可以在不启动web容器的情况下，对Controller进行测试（注意：仅仅只是对controller进行简单的测试，如果Controller中依赖用@Autowired注入的service、dao等则不能这样测试）。


### 注解详解
Spring Boot Test中的注解主要分如下几类：

* 配置类型：@TestConfiguration等。提供一些测试相关的配置入口。
* mock类型：@MockBean等。提供mock支持。
* 启动测试类型：@SpringBootTest。以Test结尾的注解，具有加载applicationContext的能力。
* 自动配置类型：@AutoConfigureJdbc等。以AutoConfigure开头的注解，具有加载测试支持功能的能力。

## 参考
* [SpringBoot Test及注解详解](https://www.cnblogs.com/myitnews/p/12330297.html)

