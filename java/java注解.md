## @SuppressWarnings
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

