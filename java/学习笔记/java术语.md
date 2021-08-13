## 程序术语
* POJO（Plain Ordinary Java Object）即普通Java类，具有一部分getter/setter方法的那种类就可以称作POJO
* Bo(business object) 代表业务对象的意思，Bo就是把业务逻辑封装为一个对象（注意是逻辑，业务逻辑）
* Vo(value object) 代表值对象的意思，通常用于业务层之间的数据传递，由new创建，由GC回收
* Po(persistant object) 代表持久层对象的意思，对应数据库中表的字段，数据库表中的记录在java对象中的显示状态，最形象的理解就是一个PO就是数据库中的一条记录
* Dto(data transfer object) 代表数据传输对象的意思 是一种设计模式之间传输数据的软件应用系统，数据传输目标往往是数据访问对象从数据库中检索数据
* Dao(data access object) 代表数据访问对象的意思，是sun的一个标准j2ee设计模式的接口之一，负责持久层的操作
* 什么是java bean？参考：https://www.zhihu.com/question/19773379
