## 生产环境composer install
```
composer.phar install --no-dev --optimize-autoloader

// Or when automated deployment is done:
composer.phar install --no-ansi --no-dev --no-interaction --no-plugins --no-progress --no-scripts --no-suggest --optimize-autoloader

// If your codebase supports it, you could swap out --optimize-autoloader for --classmap-authoritative. 
```

## 自动加载性能优化
* level-1
composer dump-autoload -o （-o 等同于 --optimize）    
> 这个命令的本质是将 PSR-4/PSR-0 的规则转化为了 classmap 的规则， 因为 classmap 中包含了所有类名与类文件路径的对应关系，所以加载器不再需要到文件系统中查找文件了。可以从 classmap 中直接找到类文件的路径。

* level-2/A
composer dump-autoload -a （-a 等同于 --classmap-authoritative）    
> 执行这个命令隐含的也执行了 Level-1 的命令， 即同样也是生成了 classmap，区别在于当加载器在 classmap 中找不到目标类时，不会再去文件系统中查找（即隐含的认为 classmap 中就是所有合法的类，不会有其他的类了，除非法调用）

* leve-2/B
composer dump-autoload --apcu
> 这种策略是为了在 Level-1 中 classmap 中找不到目标类时，将在文件系统中找到的结果存储到共享内存中， 当下次再查找时就可以从内存中直接返回，不用再去文件系统中再次查找。  
> 在生产环境下，这个策略一般也会与 Level-1 一起使用， 执行composer dump-autoload -o --apcu, 这样，即使生产环境下生成了新的类，只需要文件系统中查找一次即可被缓存 ， 弥补了Level-2/A 的缺陷。

## 参考
[How to deploy correctly when using Composer's develop / production switch?](https://stackoverflow.com/questions/21721495/how-to-deploy-correctly-when-using-composers-develop-production-switch)
[composer autoload 自动加载性能优化指南](https://blog.csdn.net/zhouyuqi1/article/details/81098650)
