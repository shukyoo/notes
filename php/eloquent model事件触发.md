## 简述
如果单独使用eloquent ORM组件的情况下，需要使用它的created, updated等事件

## 第一步 引入events组件
```
composer require illuminate/events
```

## 第二步 初始化设置
```
// Init Eloquent
use Illuminate\Database\Capsule\Manager as Capsule;

$capsule = new Capsule;
$capsule->addConnection(Config::get('db'));

// Set the event dispatcher used by Eloquent models... (optional)
// 这里配置事件初始化
use Illuminate\Events\Dispatcher;
use Illuminate\Container\Container;
$capsule->setEventDispatcher(new Dispatcher(new Container));

// Make this Capsule instance available globally via static methods... (optional)
$capsule->setAsGlobal();

// Setup the Eloquent ORM... (optional; unless you've used setEventDispatcher())
$capsule->bootEloquent();
```

## 第三步 模型事件编辑
```php
    // 需要重写boot方法
    public static function boot()
    {
        parent::boot();
        
        // 创建后事件
        self::created(function ($model {
            // ......
        });
        
        // 更新后事件
        self::updated(function ($model) {
            // .......
        });
    }
```
