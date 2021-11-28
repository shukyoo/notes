## groupId命名
* 最好使用总项目名或子组织名（com.alibaba.common, org.sonatype.nexus），不建议直接使用一级组织名（如com.alibaba）
* 全部小写，用点分割，不要使用下划线或中划线等特殊字符

## artifactId命名
* 实际项目或子模块
* 全部小写，用中划线分割，没有其它特殊字符，如spring-core

## packaging标签
* pom：父级项目一定为pom，父级的pom文件只作项目的子模块的整合
* jar：默认，所有java文件都进行编译形成.class文件，且按照原来的java文件层级结构放置，最终压缩为一个jar文件
* war：web项目部署，主要用于tomcat包，依赖包都放置到WEB-INF/lib，java编译后的class放置到WEB-INF/classes

## DependencyManagement标签
通过它元素来管理jar包的版本，让子项目中引用一个依赖而不用显示的列出版本号。Maven会沿着父子层次向上走，直到找到一个拥有dependencyManagement元素的项目，然后它就会使用在这个dependencyManagement元素中指定的版本号。
* 统一管理项目的版本号，确保各个项目的依赖版本一致，因此，在顶层pom中定义共同的依赖关系
* 可以避免在每个使用的子项目中都声明版本号，这样想升级或者切换到另一个版本时，只需要在父类容器里更新；如果某个子项目需要指定版本号时，只需要在dependencies中声明一个版本号即可
* dependencyManagement里只是声明依赖，并不实际引入，因此子项目需要显示的使用dependencies里声明需要用的依赖，只有在子项目中写了该依赖项，并且没有指定具体版本，才会从父项目中继承该项


## scope标签
指定当前包的依赖范围和依赖的传递性，用在依赖定义部分
* compile ：为默认的依赖有效范围，在编译、运行、测试时均有效
* provided ：在编译、测试时有效，但是在运行时无效，例如：servlet-api，运行项目时，容器已经提供，就不需要Maven重复地引入一遍了
* runtime ：在运行、测试时有效，但是在编译代码时无效，例如：JDBC驱动实现，项目代码编译只需要JDK提供的JDBC接口，只有在测试或运行项目时才需要实现上述接口的具体JDBC驱动
* test ：只在测试时有效，例如：JUnit
* system：和provided相同，不过被依赖项不会从maven仓库抓，而是从本地文件系统拿，一定需要配合systemPath属性使用
* import 导入的范围，它只在使用dependencyManagement中，表示从其他pom中导入dependecy的配置

## scope import说明
针对包含了一系列子依赖进的模块导入到当前项目中进行管理使用，而不是把需要用到的依赖一个一个的加入到项目中进行管理，可以理解为多继承模式。
比如在一些场景中：我们只是想单纯加入springboot模块的依赖，而不想将springboot作为父模块引入项目中，此时就可以使用import来处理。    
一般我们会将springboot作为父模块引入到项目中，如：
```
  <parent>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-parent</artifactId>
      <version>2.1.9.RELEASE</version>
      <relativePath/>
  </parent>
```
一个项目一般只能有一个父依赖模块，真实开发中，我们都会自定义自己的父模块，这样就会冲突了。所以我们可以使用import来将springboot做为依赖模块导入自己项目中：
```
  <dependencyManagement>
      <dependencies>
          <dependency>
          <groupId>org.springframework.boot</groupId>
          <artifactId>spring-boot-dependencies</artifactId>
          <version>2.1.9.RELEASE</version>
          <type>pom</type>
          <scope>import</scope>
      </dependency>
      </dependencies>
  </dependencyManagement>
```

如果没有scope=import，这个父模块的dependencyManagement会包含大量的依赖。
如果你想把这些依赖分类以更清晰的管理，import scope依赖能解决这个问题。
你可以把dependencyManagement放到单独的专门用来管理依赖的pom中，然后在需要使用依赖的模块中通过import scope依赖，就可以引入dependencyManagement。


### spring-boot-starter-parent 和 spring-boot-dependencies 的区别
一般情况下,企业都有自己的parent依赖包,然后所有的项目都必须继承对应的parent包,这时候,我们就可以通过spring-boot-dependencies使用springboot,使用这种方式记得指定maven编译版本.    

**共同点：**
* 这两种方式,我们在使用spring-boot-starter的时候都不需要指定版本

**不同点：**
* spring-boot-starter-parent提供了：Java编译版本，UTF-8编码格式，依赖管理部分，可让你对公共依赖省略version标签，继承自spring-boot-dependencies POM，良好的资源过滤，良好的插件配置，还可以通过property覆盖内部的依赖。例如，在pom.xml中升级Spring Data release train。
```
  <properties>
      <spring-data-releasetrain.version>Fowler-SR2</spring-data-releasetrain.version>
  </properties>
```
* spring-boot-dependencies scope=import，这种方式不能使用property的形式覆盖原始的依赖项。要达到同样的效果，需要在dependencyManagement里面的spring-boot-dependencies之前添加依赖的东西。例如，要升级Spring Data release train，pom.xml应该是这样的：
```
  <dependencyManagement>
      <dependencies>
          <!-- Override Spring Data release train provided by Spring Boot -->
          <dependency>
              <groupId>org.springframework.data</groupId>
              <artifactId>spring-data-releasetrain</artifactId>
              <version>Fowler-SR2</version>
              <scope>import</scope>
              <type>pom</type>
         </dependency>
         <dependency>
             <groupId>org.springframework.boot</groupId>
             <artifactId>spring-boot-dependencies</artifactId>
             <version>2.1.3.RELEASE</version>
             <type>pom</type>
             <scope>import</scope>
         </dependency>
     </dependencies>
 </dependencyManagement>
```


## optional标签
<optional>true</optional> maven依赖jar时的一个选项,表示该依赖是可选的.不会被依赖传递
#### 例如
B依赖了日志框架 logback、log4j。    
如果A->B，因为maven有依赖传递机制.那么A项目就会有,logback、log4j。    
只要B项目中把logback、log4j设置成<optional>true</optional>，这时候A依赖B的时候,项目中不会有logback、log4j jar包


