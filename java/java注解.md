## 四种类型的元注解
1. @Documented —— 指明拥有这个注解的元素可以被javadoc此类的工具文档化。这种类型应该用于注解那些影响客户使用带注释的元素声明的类型。如果一种声明使用Documented进行注解，这种类型的注解被作为被标注的程序成员的公共API。
2. @Target ——指明该类型的注解可以注解的程序元素的范围。该元注解的取值可以为TYPE,METHOD,CONSTRUCTOR,FIELD等。如果Target元注解没有出现，那么定义的注解可以应用于程序的任何元素。
3. @Inherited ——指明该注解类型被自动继承。如果用户在当前类中查询这个元注解类型并且当前类的声明中不包含这个元注解类型，那么也将自动查询当前类的父类是否存在Inherited元注解，这个动作将被重复执行知道这个标注类型被找到，或者是查询到顶层的父类。
4. @Retention ——指明了该Annotation被保留的时间长短。RetentionPolicy取值为SOURCE,CLASS,RUNTIME。


## 三种内建注解

1. @Override ——当我们想要复写父类中的方法时，我们需要使用该注解去告知编译器我们想要复写这个方法。这样一来当父类中的方法移除或者发生更改时编译器将提示错误信息。
2. @Deprecated ——当我们希望编译器知道某一方法不建议使用时，我们应该使用这个注解。Java在javadoc 中推荐使用该注解，我们应该提供为什么该方法不推荐使用以及替代的方法。
3. @SuppressWarnings ——这个仅仅是告诉编译器忽略特定的警告信息，例如在泛型中使用原生数据类型。它的保留策略是SOURCE（译者注：在源文件中有效）并且被编译器丢弃。

#### @SuppressWarnings
@SuppressWarnings() 是J2SE5.0中标准的Annotation之一。可以标注在类、字段、方法、参数、构造方法，以及局部变量上，它的作用是告诉编译器对被注解的作用域内部警告保持静默。
* 全部：@SuppressWarnings("all")
* 废弃：@SuppressWarnings("deprecation")
* 多个：@SuppressWarnings({"unchecked","fallthrough"})
* 执行了未检查的转换时的警告：unchecked
* 未使用的变量：unused
* 有泛型未指定类型：resource
* Switch 程序块直接通往下一种情况而没有 break：fallthrough
* 某类实现Serializable(序列化)， 但没有定义 serialVersionUID 时的警告：serial
* 没有传递带有泛型的参数：rawtypes
* 任何 finally 子句不能正常完成时的警告：finally
* 没有catch时的警告：try

