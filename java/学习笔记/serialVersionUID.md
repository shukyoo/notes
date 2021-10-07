## 什么是serialVersionUID
serialVersionUID适用于java序列化机制。简单来说，JAVA序列化的机制是通过 判断类的serialVersionUID来验证的版本一致的。在进行反序列化时，JVM会把传来的字节流中的serialVersionUID于本地相应实体类的serialVersionUID进行比较。如果相同说明是一致的，可以进行反序列化，否则会出现反序列化版本一致的异常，即是InvalidCastException。

## 什么时候应该更新你的serialVersionUID？
如果使用对可序列化类的某些不兼容的Java类型更改更新序列化类，则必须更新serialVersionUID。

## 默认的serialVersionUID有什么问题？
默认的serialVersionUID计算对类详细信息非常敏感，可能因不同的JVM实现而异，并且在反序列化过程中会导致意外的InvalidClassExceptions。

## 如何生成serialVersionUID
可以使用JDK“ serialver”或Eclipse IDE自动生成serialVersionUID

## 参考
* [java类中serialVersionUID的作用](https://blog.csdn.net/u014750606/article/details/80040130)
* [java类中serialversionuid 作用 是什么?举个例子说明](https://www.cnblogs.com/duanxz/p/3511695.html)
* [理解serialVersionUID是什么？有什么用？如何生成？](https://www.cnblogs.com/xuxinstyle/p/11394358.html)
