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


# 通过trait实现复用
```php
trait DataLogTrait
{
    public static function bootDataLogTrait()
    {
        static::observe(DataLogObserver::class);
    }
}
```

```php
use Illuminate\Database\Eloquent\Model;

class DataLogObserver
{
    protected static $old_data = [];

    /**
     * 获取更新前原数据
     */
    public function updating(Model $model)
    {
        self::$old_data = [];
        $changes = $model->getDirty();
        foreach ($changes as $k => $v) {
            self::$old_data[$k] = $model->getOriginal($k);
        }
    }

    /**
     * 更新日志
     */
    public function updated(Model $model)
    {
        // ......
    }

    /**
     * 删除日志
     */
    public function deleted(Model $model)
    {
        // ......
    }
}
```

模型里使用trait就可以
```php
class MyModel extends Model
{
    use DataLogTrait;
}
```


## 参考
* [laravel Eloquent 模型中通过 Trait 来添加监听器](https://learnku.com/articles/16656/trait-listeners-are-added-to-the-laravel-eloquent-model)
