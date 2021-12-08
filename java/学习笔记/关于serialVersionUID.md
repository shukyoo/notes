## 什么是serialVersionUID
JAVA序列化的机制是通过 判断类的serialVersionUID来验证的版本一致的。    
如果反序列化发现版本不一致，则会抛出InvalidCastException。

## serialVersionUID=1L和IDE自动生成的区别
* 手工创建：private static final long serialVersionUID = 1L; 
人为控制，保持兼容，或1 > 2 > 3递增控制兼容性

* 自动创建：private static final long serialVersionUID = 4359709211352400087L;
如果每次修改都不能兼容，都需要生成一个新的版本，则可以使用自动生成

