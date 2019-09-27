1. 创建空字典
```python
dic = {}
```

2.直接赋值创建
```python
dic = {'spam':1, 'egg':2, 'bar':3}
```

3.通过关键字dict和关键字参数创建
```python
dic = dict(spam = 1, egg = 2, bar =3)
```

4.通过二元组列表创建
```python
list = [('spam', 1), ('egg', 2), ('bar', 3)]
dic = dict(list)
```

5.dict和zip结合创建
```python
dic = dict(zip('abc', [1, 2, 3]))
>>> dic
{'a': 1, 'c': 3, 'b': 2}
```

6.通过字典推导式创建
```python
dic = {i:2*i for i in range(3)}
>>> dic
{0: 0, 1: 2, 2: 4}
```

7.通过dict.fromkeys()创建
通常用来初始化字典, 设置value的默认值
```python
>>> dic = dict.fromkeys(range(3), 'x')
>>> dic
{0: 'x', 1: 'x', 2: 'x'}
```
