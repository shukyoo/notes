## optional的作用
>>> Optional is intended to provide a limited mechanism for library method return types where there needed to be a clear way to represent “no result," and using null for such was overwhelmingly likely to cause errors.

1. Optional 是用来作为方法返回值的
2. Optional 是为了清晰地表达返回值中没有结果的可能性
3. 且如果直接返回 null 很可能导致调用端产生错误（尤其是NullPointerException）


## 参考
* [Java 8 Optional 最佳实践](https://zhuanlan.zhihu.com/p/128481434)
* [Java Optional使用的最佳实践](https://www.jdon.com/52008)
* [Java Optional 最佳实践七条法则](https://blog.csdn.net/weixin_43864838/article/details/108133087)
