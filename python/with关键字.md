## 简述
with表达式其实是try-finally的简写形式。但是又不是全相同。

## 示例
```python
with open('1.txt') as f:
    print(f.read())
```
表达式open('1.txt')返回是一个_io.TextIOWrapper 类型的变量用f接受到。在with语句块中就可以使用这个变量操作文件。执行with这个结构之后。f会自动关闭。相当于自带了一个finally。

## 原理
with 语句实质是上下文管理。
1. 上下文管理协议。包含方法__enter__() 和 __exit__()，支持该协议对象要实现这两个方法。
2. 上下文管理器，定义执行with语句时要建立的运行时上下文，负责执行with语句块上下文中的进入与退出操作。
3. 进入上下文的时候执行__enter__方法，如果设置as var语句，var变量接受__enter__()方法返回值。
4. 如果运行时发生了异常，就退出上下文管理器。调用管理器__exit__方法。

## 自定义类
自定义类必须包含上述几个方法才能正确使用with关键字。
```python
class Mycontex(object):
    def __init__(self,name):
        self.name=name
    def __enter__(self):
        print("进入enter")
        return self
    def do_self(self):
        print(self.name)
    def __exit__(self,exc_type,exc_value,traceback):
        print("退出exit")
        print(exc_type,exc_value)
if __name__ == '__main__':
    with Mycontex('test') as mc:
        mc.do_self()
```

## 应用场景
1、文件操作。2、进程线程之间互斥对象。3、支持上下文其他对象

