# 示例代码
```php
namespace App\Test;

use Yii;
use helpers\Helper;

/**
 * 一些说明
 */
class HelloWorldTest
{
    const KIND_ = 'red';
    const COLOR_BLUE = 'blue';
 
    public $user_name;
    protected $age;

    /**
     * 方法注释
     */
    public function getUserAge()
    {
        $test_var = $this->age;
        if (!$test_var) {
            $test_var = 10;
        }
        return $test_var;
    }
 
    /**
     * 方法注释
     */
    protected function testSomething(array $test_arr)
    {
        $result = [];
        foreach ($test_arr as $k => $item) {
            if ($k > 2) {
                $result[] = $item;
            }
        }
        return $result;
    }
}
 
 
/**
 * 函数说明
 */
function check_number_valid($call)
{
    $number = $call();
    return ($number > 0);
}
 
 
/**
 * 匿名函数调用
 */
check_number_valid(function(){
    return 10;
});
 
 
// 常量声明
define('MY_TEST_NAME', 'aaa');
 
// 变量使用
$hello_test = 'hello';
$hello_str = 'say '. $hello_test .' world';
$test_arr = [1, 2, 3];
$test_long_arr = array(
    'kk_aa' => 11,
    'kk_bb' => 22,
    'kk_cc' => 33
);
```


# 文字说明
### 基础：
* 只允许<?php或<?=，不允许<?短标记；
* 如果是纯PHP代码，则结尾不加?>标记（官方推荐，防止意外输出）；
* 行尾不要有空格；
* 文件使用UTF-8编码，去除BOM；
* 使用4个空格代替Tab缩进（在IDE里设置缩进选项）；
* 所有类、方法或变量等的命名都以英文意义命名，名称要直观有意义；

### 命名空间：

* 命名空间要跟目录结构保持一致；
* 命名空间声明在第一行；

### 类：

* 文件名跟类名一致；
* 每个单词首字母大写；
* 大括号新起一行；
* 类注释在class上面，非必需；

### 类常量和属性：

* 类常量全大写，用下划线分隔；
* 类属性全小写，下划线分隔；
* 如果是protected或private则以下划线开头；

### 方法：

* 第一个单词小写，之后每个单词首字母大写；
* protected或private方法名以下划线开头；
* 大括号新起一行；
* 方法跟方法之间至少有一行的分隔空间；
* 方法说明注释；

### 函数和匿名函数：

* 函数命名全小写，下划线分隔；
* 函数的大括号新起一行；
* 匿名函数大括号在本行；

### 变量和常量：

* 变量命名全小写，下划线分隔；
* 常量命名全大写，下划线分隔；
* 字符串使用单引号，除非包含变量或其它特殊情况；
* 字符串连接的点，两边加空格；

### 数组：

* 短数据写在一行；
* 长数据写多行，一行一个元素，箭头两边加上空格；

### 控制：

* 大括号在同一行开始，结束大括号在新一行；
* 都要加上大括号，哪怕只有一行语句；
* 条件声明，括号两边要加空格，比如 if ($a == 1) {
* 等号赋值或双等号判断等两边要有空格；

### 其它注意事项：

* 一般包含文件不需要直接暴露给用户，所以应该放在 Web Server访问不到的目录，避免因为配置问题而泄露设置信息；
* 应当使用define或者CONST去表示某数值一个真正的名字，避免硬编码；

