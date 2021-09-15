## 什么是JPA
JPA是Java Persistence API的简称，中文名Java持久层API，是处理数据持久化的一个接口，规范。    
JPA的出现有两个原因：
* 简化现有Java EE和Java SE应用的对象持久化的开发工作；
* Sun希望整合对ORM技术，实现持久化领域的统一。
实现了JPA规范的主要有：
* Hibernate
* TopLink
* OpenJPA
* EclipseLink

## JPA有以下3方面技术
### ORM映射元数据
JPA支持XML和JDK5.0注解两种元数据的形式，元数据描述对象和表之间的映射关系，框架据此将实体对象持久化到数据库表中；

### API
用来操作实体对象，执行CRUD操作，框架在后台替代我们完成所有的事情，开发者从繁琐的JDBC和SQL代码中解脱出来。

### 查询语言
这是持久化操作中很重要的一个方面，通过面向对象而非面向数据库的查询语言查询数据，避免程序的SQL语句紧密耦合。

## JPA优势
### 标准化
JPA 是 JCP 组织发布的 Java EE 标准之一，因此任何声称符合 JPA 标准的框架都遵循同样的架构，提供相同的访问API，这保证了基于JPA开发的企业应用能够经过少量的修改就能够在不同的JPA框架下运行。

### 容器级特性的支持
JPA框架中支持大数据集、事务、并发等容器级事务，这使得 JPA 超越了简单持久化框架的局限，在企业应用发挥更大的作用。

### 简单方便
JPA的主要目标之一就是提供更加简单的编程模型：在JPA框架下创建实体和创建Java 类一样简单，没有任何的约束和限制，只需要使用 javax.persistence.Entity进行注释，JPA的框架和接口也都非常简单，没有太多特别的规则和设计模式的要求，开发者可以很容易地掌握。JPA基于非侵入式原则设计，因此可以很容易地和其它框架或者容器集成。

### 查询能力
JPA的查询语言是面向对象而非面向数据库的，它以面向对象的自然语法构造查询语句，可以看成是Hibernate HQL的等价物。JPA定义了独特的JPQL（Java Persistence Query Language），JPQL是EJB QL的一种扩展，它是针对实体的一种查询语言，操作对象是实体，而不是关系数据库的表

### 高级特性
JPA 中能够支持面向对象的高级特性，如类之间的继承、多态和类之间的复杂关系，这样的支持能够让开发者最大限度的使用面向对象的模型设计企业应用，而不需要自行处理这些特性在关系数据库的持久化。

## 供应商
JPA 的目标之一是制定一个可以由很多供应商实现的API，并且开发人员可以编码来实现该API，而不是使用私有供应商特有的API。因此开发人员只需使用供应商特有的API来获得JPA规范没有解决但应用程序中需要的功能。尽可能地使用JPA API，但是当需要供应商公开但是规范中没有提供的功能时，则使用供应商特有的API。

### Hibernate
JPA是需要Provider来实现其功能的，Hibernate就是JPA Provider中很强的一个，应该说无人能出其右。从功能上来说，JPA就是Hibernate功能的一个子集。Hibernate 从3.2开始，就开始兼容JPA。Hibernate3.2获得了Sun TCK的JPA(Java Persistence API) 兼容认证。

### Spring
在Spring 2.0.1中，正式提供对JPA的支持，这也促成了JPA的发展，要知道JPA的好处在于可以分离于容器运行，变得更加的简洁。

### OpenJPA
OpenJPA 是 Apache 组织提供的开源项目，它实现了 EJB 3.0 中的 JPA 标准，为开发者提供功能强大、使用简单的持久化数据管理框架。OpenJPA 封装了和关系型数据库交互的操作，让开发者把注意力集中在编写业务逻辑上。OpenJPA 可以作为独立的持久层框架发挥作用，也可以轻松的与其它 Java EE 应用框架或者符合 EJB 3.0 标准的容器集成。

## 核心概念
* 实体（pojo）表示关系数据库中的一个表
* 每个实体实例对应着该表中的一行
* 类必须用javax.persistence.Entity注解
* 类必须含有一个public或者protected的无参构造函数
* 当实体实例被当做值以分离对象的方式进行传递（例如通过会话bean的远程业务接口）则该类必须实现Serializable（序列化）接口
* 唯一的对象标志符，简单主键（javax.persistence.Id），复合主键（javax.persistence.EmbeddledId和javax.persistence.IdClass）

## 关系
* 一对一：@OneToOne
* 一对多：@OneToMany
* 多对一：@ManyToOne
* 多对多：@ManyToMany

## EntityManager
* 管理实体的一个类，接口
* 定义与持久性上下文进行交互的方法
* 创建和删除持久实体类，通过实体的主键查找实体
* 允许在实体类上进行查询

## 实体生命周期
* New，新创建的实体对象，没有主键(identity)值
* Managed，对象处于Persistence Context(持久化上下文）中，被EntityManager管理
* Detached，对象已经游离到Persistence Context之外，进入Application Domain
* Removed, 实体对象被删除
EntityManager提供一系列的方法管理实体对象的生命周期，包括：
* persist, 将新创建的或已删除的实体转变为Managed状态，数据存入数据库。
* remove，删除受控实体
* merge，将游离实体转变为Managed状态，数据存入数据库。

## ID生成策略
* GeneratorType.AUTO ，由JPA自动生成
* GenerationType.IDENTITY，使用数据库的自增长字段，需要数据库的支持（如SQL Server、MySQL、DB2、Derby等）
* GenerationType.SEQUENCE，使用数据库的序列号，需要数据库的支持（如Oracle）
* GenerationType.TABLE，使用指定的数据库表记录ID的增长 需要定义一个TableGenerator，在@GeneratedValue中引用。

## 查询方式
* 对于简单的静态查询 - 可能优选基于字符串的JPQL查询（例如Named Queries）非查询类型安全
* 对于在运行时构建的动态查询 - 可能首选Criteria API查询类型安全

## 什么是spring data JPA
对基于JPA的数据访问层的增强支持，即对数据访问层就行了更好的规范；
更容易构建基于使用spring数据访问技术站的应用程序；

## JPA常用注解
* @Entity 指定当前类是实体类。
* @Table 指定实体类和表之间的对应关系。
* @Id 指定当前字段是主键。
* @GeneratedValue 指定主键的生成方式
* @Column 指定实体类属性和数据库表之间的对应关系

## 参考
* [JPA百度百科](https://baike.baidu.com/item/JPA/5660672)
* [什么是JPA](https://www.jianshu.com/p/c71526c24ec0)
* [浅谈JPA一：JPA是什么](https://blog.csdn.net/localhost01/article/details/83422893)
* [JPA与ORM以及Hibernate](https://www.cnblogs.com/tongx123/p/5261778.html)
