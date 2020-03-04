## 说明
| 参数 | 说明 |
| --- | --- |
| table_open_cache | 所有线程打开表的数目。它的作用就是缓存表文件描述符，降低打开关闭表的频率， 如果这个参数设置得过小，就不得不关闭一些已打开的表以便为缓存新表，从而出现频繁的打开关闭MyISAM表文件的情况，而INNODB表的打开不受这个参数控制，而是放到其数据字典当中，即在ibd文件中。当Opened_tables状态值较大，且不经常使用FLUSH TABLES 关闭并重新打开表，就需要增加该值。 |
| table_open_cache_instances | 表缓存实例数，为通过减小会话间争用提高扩展性，表缓存会分区为table_open_cache/table_open_cache_instances大小的较小的缓存实例。DML语句会话只需要锁定所在缓存实例，这样多个会话访问表缓存时就可提升性能（DDL语句仍会锁定整个缓存）。默认该值为1，当16核以上可设置为8或16。 |

## 参考
[Optimize MySQL table_open_cache](https://techinfobest.com/optimize-mysql-table_open_cache/)
[MySQL打开文件限制](https://www.jianshu.com/p/926169bbd544)
