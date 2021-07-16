## 一、ElasticSearch使用场景
#### 存储
ElasticSearch天然支持分布式，具备存储海量数据的能力，其搜索和数据分析的功能都建立在ElasticSearch存储的海量的数据之上；ElasticSearch很方便的作为海量数据的存储工具，特别是在数据量急剧增长的当下，ElasticSearch结合爬虫等数据收集工具可以发挥很大用处

#### 搜索
ElasticSearch使用倒排索引，每个字段都被索引且可用于搜索，更是提供了丰富的搜索api，在海量数据下近实时实现近秒级的响应,基于Lucene的开源搜索引擎，为搜索引擎（全文检索，高亮，搜索推荐等）提供了检索的能力。 具体场景:
1. Stack Overflow（国外的程序异常讨论论坛），IT问题，程序的报错，提交上去，有人会跟你讨论和回答，全文检索，搜索相关问题和答案，程序报错了，就会将报错信息粘贴到里面去，搜索有没有对应的答案；
2. GitHub（开源代码管理），搜索上千亿行代码；
3. 电商网站，检索商品；
4. 日志数据分析，logstash采集日志，ElasticSearch进行复杂的数据分析（ELK技术，elasticsearch+logstash+kibana）；

#### 数据分析
ElasticSearch也提供了大量数据分析的api和丰富的聚合能力，支持在海量数据的基础上进行数据的分析和处理。具体场景：
爬虫爬取不同电商平台的某个商品的数据，通过ElasticSearch进行数据分析（各个平台的历史价格、购买力等等）；


## 二、ElasticSearch核心概念
| 概念  | 说明 |
| ------------- | ------------- |
| Near Realtime (NRT)近实时  | 数据提交索引后，立马就可以搜索到  |
| Cluster集群  | 一个集群由一个唯一的名字标识，默认为“elasticsearch”。集群名称非常重要，具体相同集群名的节点才会组成一个集群。集群名称可以在配置文件中指定。集群中有多个节点，其中有一个为主节点，这个主节点是可以通过选举产生的，主从节点是对于集群内部来说的。ElasticSearch的一个概念就是去中心化，字面上理解就是无中心节点，这是对于集群外部来说的，因为从外部来看ElasticSearch集群，在逻辑上是个整体，你与任何一个节点的通信和与整个ElasticSearch集群通信是等价的。  |
| Node 节点  | 存储集群的数据，参与集群的索引和搜索功能。像集群有名字，节点也有自己的名称，默认在启动时会以一个随机的UUID的前七个字符作为节点的名字，你可以为其指定任意的名字。通过集群名在网络中发现同伴组成集群。一个节点也可是集群。每一个运行实例称为一个节点,每一个运行实例既可以在同一机器上,也可以在不同的机器上。所谓运行实例,就是一个服务器进程，在测试环境中可以在一台服务器上运行多个服务器进程，在生产环境中建议每台服务器运行一个服务器进程。  |
| Index 索引  | 一个索引是一个文档的集合（等同于solr中的集合）。每个索引有唯一的名字，通过这个名字来操作它。一个集群中可以有任意多个索引。索引作动词时，指索引数据、或对数据进行索引。Type 类型：指在一个索引中，可以索引不同类型的文档，如用户数据、博客数据。从6.0.0 版本起已废弃，一个索引中只存放一类数据。Elasticsearch里的索引概念是名词而不是动词，在elasticsearch里它支持多个索引。 一个索引就是一个拥有相似特征的文档的集合。比如说，你可以有一个客户数据的索引，另一个产品目录的索引，还有一个订单数据的索引。一个索引由一个名字来 标识（必须全部是小写字母的），并且当我们要对这个索引中的文档进行索引、搜索、更新和删除的时候，都要使用到这个名字。在一个集群中，你能够创建任意多个索引。  |
| Document 文档  | 被索引的一条数据，索引的基本信息单元，以JSON格式来表示。一个文档是一个可被索引的基础信息单元。比如，你可以拥有某一个客户的文档、某一个产品的一个文档、某个订单的一个文档。文档以JSON格式来表示，而JSON是一个到处存在的互联网数据交互格式。在一个index/type里面，你可以存储任意多的文档。注意，一个文档物理上存在于一个索引之中，但文档必须被索引/赋予一个索引的type。  |
| Shard 分片  | 在创建一个索引时可以指定分成多少个分片来存储。每个分片本身也是一个功能完善且独立的“索引”，可以被放置在集群的任意节点上（分片数创建索引时指定，创建后不可改了。备份数可以随时改）。索引分片，ElasticSearch可以把一个完整的索引分成多个分片，这样的好处是可以把一个大的索引拆分成多个，分布到不同的节点上。构成分布式搜索。分片的数量只能在索引创建前指定，并且索引创建后不能更改。分片的好处：-  允许我们水平切分/扩展容量 -  可在多个分片上进行分布式的、并行的操作，提高系统的性能和吞吐量。  |
| Replication 备份  | 一个分片可以有多个备份（副本）。备份的好处： -  高可用扩展搜索的并发能力、吞吐量。 -  搜索可以在所有的副本上并行运行。  |
| primary shard  | 主分片，每个文档都存储在一个分片中，当你存储一个文档的时候，系统会首先存储在主分片中，然后会复制到不同的副本中。默认情况下，一个索引有5个主分片。你可以在事先制定分片的数量，当分片一旦建立，分片的数量则不能修改。  |
| replica shard  | 副本分片，每一个分片有零个或多个副本。副本主要是主分片的复制，其中有两个目的： -  增加高可用性：当主分片失败的时候，可以从副本分片中选择一个作为主分片。 -  提高性能：当查询的时候可以到主分片或者副本分片中进行查询。默认情况下，一个主分配有一个副本，但副本的数量可以在后面动态的配置增加。副本必须部署在不同的节点上，不能部署在和主分片相同的节点上。  |
| term索引词  | 在elasticsearch中索引词(term)是一个能够被索引的精确值。foo，Foo几个单词是不相同的索引词。索引词(term)是可以通过term查询进行准确搜索。  |
| text文本  | 是一段普通的非结构化文字，通常，文本会被分析称一个个的索引词，存储在elasticsearch的索引库中，为了让文本能够进行搜索，文本字段需要事先进行分析；当对文本中的关键词进行查询的时候，搜索引擎应该根据搜索条件搜索出原文本。  |
| analysis  | 分析是将文本转换为索引词的过程，分析的结果依赖于分词器，比如： FOO BAR, Foo-Bar, foo bar这几个单词有可能会被分析成相同的索引词foo和bar，这些索引词存储在elasticsearch的索引库中。当用 FoO:bAR进行全文搜索的时候，搜索引擎根据匹配计算也能在索引库中搜索出之前的内容。这就是elasticsearch的搜索分析。  |
| routing路由  | 当存储一个文档的时候，他会存储在一个唯一的主分片中，具体哪个分片是通过散列值的进行选择。默认情况下，这个值是由文档的id生成。如果文档有一个指定的父文档，从父文档ID中生成，该值可以在存储文档的时候进行修改。  |
| type类型  | 在一个索引中，你可以定义一种或多种类型。一个类型是你的索引的一个逻辑上的分类/分区，其语义完全由你来定。通常，会为具有一组相同字段的文档定义一个类型。比如说，我们假设你运营一个博客平台 并且将你所有的数据存储到一个索引中。在这个索引中，你可以为用户数据定义一个类型，为博客数据定义另一个类型，当然，也可以为评论数据定义另一个类型。  |
| template  | 索引可使用预定义的模板进行创建,这个模板称作Index templatElasticSearch。模板设置包括settings和mappings。  |
| mapping  | 映射像关系数据库中的表结构，每一个索引都有一个映射，它定义了索引中的每一个字段类型，以及一个索引范围内的设置。一个映射可以事先被定义，或者在第一次存储文档的时候自动识别。  |
| field  | 一个文档中包含零个或者多个字段，字段可以是一个简单的值（例如字符串、整数、日期），也可以是一个数组或对象的嵌套结构。字段类似于关系数据库中的表中的列。每个字段都对应一个字段类型，例如整数、字符串、对象等。字段还可以指定如何分析该字段的值。  |
| source field  | 默认情况下，你的原文档将被存储在_source这个字段中，当你查询的时候也是返回这个字段。这允许您可以从搜索结果中访问原始的对象，这个对象返回一个精确的json字符串，这个对象不显示索引分析后的其他任何数据。  |
| id  | 一个文件的唯一标识，如果在存库的时候没有提供id，系统会自动生成一个id，文档的index/type/id必须是唯一的。  |
| recovery  | 代表数据恢复或叫数据重新分布，ElasticSearch在有节点加入或退出时会根据机器的负载对索引分片进行重新分配，挂掉的节点重新启动时也会进行数据恢复。  |
| River  | 代表ElasticSearch的一个数据源，也是其它存储方式（如：数据库）同步数据到ElasticSearch的一个方法。它是以插件方式存在的一个ElasticSearch服务，通过读取river中的数据并把它索引到ElasticSearch中，官方的river有couchDB的，RabbitMQ的，Twitter的，Wikipedia的，river这个功能将会在后面的文件中重点说到。  |
| gateway  | 代表ElasticSearch索引的持久化存储方式，ElasticSearch默认是先把索引存放到内存中，当内存满了时再持久化到硬盘。当这个ElasticSearch集群关闭再重新启动时就会从gateway中读取索引数据。ElasticSearch支持多种类型的gateway，有本地文件系统(默认), 分布式文件系统，Hadoop的HDFS和amazon的s3云存储服务。  |
| discovery.zen  | 代表ElasticSearch的自动发现节点机制，ElasticSearch是一个基于p2p的系统，它先通过广播寻找存在的节点，再通过多播协议来进行节点之间的通信，同时也支持点对点的交互。  |
| Transport  | 代表ElasticSearch内部节点或集群与客户端的交互方式，默认内部是使用tcp协议进行交互，同时它支持http协议（json格式）、thrift、servlet、memcached、zeroMQ等的传输协议（通过插件方式集成）。  |


#### 对比关系型数据库
| RDBMS  | ES |
| --- | --- |
| 数据库(database)  | 索引(index)  |
| 表（table）  | 类型（type）(6.0废弃)  |
| 行（row）  | 文档（document）  |
| 列（column）  | 字段（field）  |
| 表结构（schema）  | 映射（mapping）  |
| 索引  | 反射索引  |
| SQL  | DSL  |
| SELECT * FROM table | GET http://  |
| UPDATE table SET  | PUT http://  |
| DELETE FROM tabl  | DELETE http://  |

## 三、ElasticSearch配置

1. 数据目录和日志目录，生产环境下应与软件分离

```
#注意：数据目录可以有多个，可以通过逗号分隔指定多个目录。一个索引数据只会放入一个目录中！！
path.data: /path/to/data1,/path/to/data2
   
# Path to log files:
path.logs: /path/to/logs
   
# Path to where plugins are installed:
path.plugins: /path/to/plugins
```

2. 所属的集群名，默认为 elasticsearch ，可自定义（最好给生产环境的ES集群改个名字，改名字的目的其实就是防止某台服务器加入了集群这种意外）

```
cluster.name: kevin_elasticsearch　
```

3. 节点名，默认为 UUID前7个字符，可自定义

```
node.name: kevin_elasticsearch_node01
```

4. network.host  IP绑定，默认绑定的是["127.0.0.1", "[::1]"]回环地址，集群下要服务间通信，需绑定一个ipv4或ipv6地址或0.0.0.0

```
network.host: 172.16.60.11
```

5. http.port: 9200-9300    
对外服务的http 端口， 默认 9200-9300 。可以为它指定一个值或一个区间，当为区间时会取用区间第一个可用的端口。

6. transport.tcp.port: 9300-9400    
节点间交互的端口， 默认 9300-9400 。可以为它指定一个值或一个区间，当为区间时会取用区间第一个可用的端口。

7. Discovery Config 节点发现配置    
ES中默认采用的节点发现方式是 zen（基于组播（多播）、单播）。在应用于生产前有两个重要参数需配置

8. discovery.zen.ping.unicast.hosts: ["host1","host2:port","host3[portX-portY]"]    
单播模式下，设置具有master资格的节点列表，新加入的节点向这个列表中的节点发送请求来加入集群。

9. discovery.zen.minimum_master_nodes: 1    
这个参数控制的是，一个节点需要看到具有master资格的节点的最小数量，然后才能在集群中做操作。官方的推荐值是(N/2)+1，其中N是具有master资格的节点的数量。

10. transport.tcp.compress: false    
是否压缩tcp传输的数据，默认false

11. http.cors.enabled: true    
是否使用http协议对外提供服务，默认true

12. http.max_content_length: 100mb    
http传输内容的最大容量，默认100mb

13. node.master: true    
指定该节点是否可以作为master节点，默认是true。ES集群默认是以第一个节点为master，如果该节点出故障就会重新选举master。

14. node.data: true    
该节点是否存索引数据，默认true。

15. discover.zen.ping.timeout: 3s    
设置集群中自动发现其他节点时ping连接超时时长，默认为3秒。在网络环境较差的情况下，增加这个值，会增加节点等待响应的时间，从一定程度上会减少误判。

16. discovery.zen.ping.multicast.enabled: false    
是否启用多播来发现节点。

17. Jvm heap 大小设置    
生产环境中一定要在jvm.options中调大它的jvm内存。

18. JVM heap dump path 设置    
生产环境中指定当发生OOM异常时，heap的dump path，好分析问题。在jvm.options中配置：
```
-XX:HeapDumpPath=/var/lib/elasticsearch
```

## 四、Elasticsearch 配置文件详解

elasticsearch的配置文件是在elasticsearch目录下的config文件下的elasticsearch.yml，同时它的日志文件在elasticsearch目录下的logs，由于elasticsearch的日志也是使用log4j来写日志的，所以其配置模式与log4j基本相同。

#### Cluster部分
cluster.name: kevin-elk （默认值：elasticsearch）    
cluster.name可以确定你的集群名称，当你的elasticsearch集群在同一个网段中elasticsearch会自动的找到具有相同cluster.name 的elasticsearch服务。所以当同一个网段具有多个elasticsearch集群时cluster.name就成为同一个集群的标识。

#### Node部分
* node.name: "elk-node01"　　节点名，可自动生成也可手动配置。
* node.master: true （默认值：true）　　允许一个节点是否可以成为一个master节点,es是默认集群中的第一台机器为master,如果这台机器停止就会重新选举master。
* node.client　　当该值设置为true时，node.master值自动设置为false，不参加master选举。
* node.data: true （默认值：true）　　允许该节点存储数据。
* node.rack　　无默认值，为节点添加自定义属性。
* node.max_local_storage_nodes: 1 （默认值：1） 设置能运行的节点数目，一般采用默认的1即可，因为我们一般也只在一台机子上部署一个节点。

配置文件中给出了三种配置高性能集群拓扑结构的模式,如下：    
workhorse：如果想让节点从不选举为主节点,只用来存储数据,可作为负载器    
node.master: false    
node.data: true    
coordinator：如果想让节点成为主节点,且不存储任何数据,并保有空闲资源,可作为协调器    
node.master: true   
node.data: false    
search load balancer：(fetching data from nodes, aggregating results, etc.理解为搜索的负载均衡节点，从其他的节点收集数据或聚集后的结果等），客户端节点可以直接将请求发到数据存在的节点，而不用查询所有的数据节点，另外可以在它的上面可以进行数据的汇总工作，可以减轻数据节点的压力。    
node.master: false    
node.data: false    
    
另外配置文件提到了几种监控es集群的API或方法：    
Cluster Health API：http://127.0.0.1:9200/_cluster/health    
Node Info API：http://127.0.0.1:9200/_nodes    

还有图形化工具：    
https://www.elastic.co/products/marvel    
https://github.com/karmi/elasticsearch-paramedic    
https://github.com/hlstudio/bigdesk    
https://github.com/mobz/elasticsearch-head    

#### Indices部分

```
index.number_of_shards: 5 (默认值为5)    设置默认索引分片个数。
index.number_of_replicas: 1（默认值为1）    设置索引的副本个数
```
服务器够多,可以将分片提高,尽量将数据平均分布到集群中，增加副本数量可以有效的提高搜索性能。
需要注意:  "number_of_shards" 是索引创建后一次生成的,后续不可更改设置 "number_of_replicas" 是可以通过update-index-settings API实时修改设置。


* Indices Circuit Breaker *
elasticsearch包含多个circuit breaker来避免操作的内存溢出。每个breaker都指定可以使用内存的限制。另外有一个父级breaker指定所有的breaker可以使用的总内存

```
indices.breaker.total.limit　　所有breaker使用的内存值，默认值为 JVM 堆内存的70%，当内存达到最高值时会触发内存回收。
```

Field data circuit breaker    允许elasticsearch预算待加载field的内存，防止field数据加载引发异常
```
indices.breaker.fielddata.limit　　   field数据使用内存限制，默认为JVM 堆的60%。
indices.breaker.fielddata.overhead　　elasticsearch使用这个常数乘以所有fielddata的实际值作field的估算值。默认为 1.03。
```
请求断路器（Request circuit breaker） 允许elasticsearch防止每个请求的数据结构超过了一定量的内存

```
indices.breaker.request.limit　　　  request数量使用内存限制，默认为JVM堆的40%。
indices.breaker.request.overhead　  elasticsearch使用这个常数乘以所有request占用内存的实际值作为最后的估算值。默认为 1。
```
Indices Fielddata cache
字段数据缓存主要用于排序字段和计算聚合。将所有的字段值加载到内存中，以便提供基于文档快速访问这些值

```
indices.fielddata.cache.size：unbounded
设置字段数据缓存的最大值，值可以设置为节点堆空间的百分比，例：30%，可以值绝对值，例：12g。默认为无限。
该设置是静态设置，必须配置到集群的每个节点。
```

Indices Node query cache
query cache负责缓存查询结果，每个节点都有一个查询缓存共享给所有的分片。缓存实现一个LRU驱逐策略：当缓存使用已满，最近最少使用的数据将被删除，来缓存新的数据。query cache只缓存过滤过的上下文


```
indices.queries.cache.size
查询请求缓存大小，默认为10%。也可以写为绝对值，例：512m。
该设置是静态设置，必须配置到集群的每个数据节点。
```

Indexing Buffer
索引缓冲区用于存储新索引的文档。缓冲区写满，缓冲区的文件才会写到硬盘。缓冲区划分给节点上的所有分片。
Indexing Buffer的配置是静态配置，必须配置都集群中的所有数据节点

```
indices.memory.index_buffer_size
允许配置百分比和字节大小的值。默认10%，节点总内存堆的10%用作索引缓冲区大小。
 
indices.memory.min_index_buffer_size
如果index_buffer_size被设置为一个百分比，这个设置可以指定一个最小值。默认为 48mb。
 
indices.memory.max_index_buffer_size
如果index_buffer_size被设置为一个百分比，这个设置可以指定一个最小值。默认为无限。
 
indices.memory.min_shard_index_buffer_size
设置每个分片的最小索引缓冲区大小。默认为4mb。
```

Indices Shard request cache
当一个搜索请求是对一个索引或者多个索引的时候，每一个分片都是进行它自己内容的搜索然后把结果返回到协调节点，然后把这些结果合并到一起统一对外提供。分片缓存模块缓存了这个分片的搜索结果。这使得搜索频率高的请求会立即返回。    
    
注意：请求缓存只缓存查询条件 size=0的搜索，缓存的内容有hits.total, aggregations, suggestions，不缓存原始的hits。通过now查询的结果将不缓存。    
缓存失效：只有在分片的数据实际上发生了变化的时候刷新分片缓存才会失效。刷新的时间间隔越长，缓存的数据越多，当缓存不够的时候，最少使用的数据将被删除。    
    
缓存过期可以手工设置，例如:    

```
curl -XPOST 'localhost:9200/kimchy,elasticsearch/_cache/clear?request_cache=true'
```
默认情况下缓存未启用，但在创建新的索引时可启用，例如:

```
curl -XPUT localhost:9200/my_index -d'
{
　　"settings": {
　　　　"index.requests.cache.enable": true
　　}
}
'
```

当然也可以通过动态参数配置来进行设置:

```
curl -XPUT localhost:9200/my_index/_settings -d'
{ "index.requests.cache.enable": true }
'
```

每请求启用缓存，查询字符串参数request_cache可用于启用或禁用每个请求的缓存。例如:

```
curl 'localhost:9200/my_index/_search?request_cache=true' -d'
{
　　"size": 0,
　　"aggs": {
　　　　"popular_colors": {
　　　　　　"terms": {
　　　　　　　　"field": "colors"
　　　　　　}
　　　　}
　　}
}
'
```

注意：如果你的查询使用了一个脚本，其结果是不确定的（例如，它使用一个随机函数或引用当前时间）应该设置 request_cache=false 禁用请求缓存。   

缓存key，数据的缓存是整个JSON，这意味着如果JSON发生了变化 ，例如如果输出的顺序顺序不同，缓存的内容江将会不同。不过大多数JSON库对JSON键的顺序是固定的。   

分片请求缓存是在节点级别进行管理的，并有一个默认的值是JVM堆内存大小的1%，可以通过配置文件进行修改。 例如： indices.requests.cache.size: 2%   

分片缓存大小的查看方式:   

```
curl 'localhost:9200/_stats/request_cache?pretty&human'
或者

curl 'localhost:9200/_nodes/stats/indices/request_cache?pretty&human'
```

* Indices Recovery *

```
indices.recovery.concurrent_streams　　限制从其它分片恢复数据时最大同时打开并发流的个数。默认为 3。
indices.recovery.concurrent_small_file_streams　　从其他的分片恢复时打开每个节点的小文件(小于5M)流的数目。默认为 2。
indices.recovery.file_chunk_size　　默认为 512kb。
indices.recovery.translog_ops　　默认为 1000。
indices.recovery.translog_size　　默认为 512kb。
indices.recovery.compress　　恢复分片时，是否启用压缩。默认为 true。
indices.recovery.max_bytes_per_sec　　限制从其它分片恢复数据时每秒的最大传输速度。默认为 40mb。
Indices TTL interval
```

```
indices.ttl.interval 允许设置多久过期的文件会被自动删除。默认值是60s。
indices.ttl.bulk_size 设置批量删除请求的数量。默认值为1000。
```

Paths部分

```
path.conf: /path/to/conf　　配置文件存储位置。
path.data: /path/to/data　　数据存储位置，索引数据可以有多个路径，使用逗号隔开。
path.work: /path/to/work　　临时文件的路径 。
path.logs: /path/to/logs　　日志文件的路径 。
path.plugins: /path/to/plugins　　插件安装路径 。
```

#### Memory部分
bootstrap.mlockall: true（默认为false）
锁住内存，当JVM进行内存转换的时候，es的性能会降低，所以可以使用这个属性锁住内存。同时也要允许elasticsearch的进程可以锁住内存，linux下可以通过`ulimit -l unlimited`命令，或者在/etc/sysconfig/elasticsearch文件中取消 MAX_LOCKED_MEMORY=unlimited 的注释即可。如果使用该配置则ES_HEAP_SIZE必须设置，设置为当前可用内存的50%，最大不能超过31G，默认配置最小为256M，最大为1G。

可以通过请求查看mlockall的值是否设定:
```
curl http://localhost:9200/_nodes/process?pretty
```
如果mlockall的值是false，则设置失败。可能是由于elasticsearch的临时目录（/tmp）挂载的时候没有可执行权限。
可以使用下面的命令来更改临时目录:

```
./bin/elasticsearch -Djna.tmpdir=/path/to/new/dir
```


#### Network 、Transport and HTTP 部分

network.bind_host    
设置绑定的ip地址,可以是ipv4或ipv6的。    
    
network.publish_host    
设置其它节点和该节点交互的ip地址,如果不设置它会自动设置,值必须是个真实的ip地址。    
    
network.host    
同时设置bind_host和publish_host两个参数，值可以为网卡接口、127.0.0.1、私有地址以及公有地址。    
    
http_port    
接收http请求的绑定端口。可以为一个值或端口范围，如果是一个端口范围，节点将绑定到第一个可用端口。默认为：9200-9300。    
    
transport.tcp.port    
节点通信的绑定端口。可以为一个值或端口范围，如果是一个端口范围，节点将绑定到第一个可用端口。默认为：9300-9400。    
    
transport.tcp.connect_timeout    
套接字连接超时设置，默认为 30s。    
    
transport.tcp.compress    
设置为true启用节点之间传输的压缩（LZF），默认为false。    
    
transport.ping_schedule    
定时发送ping消息保持连接，默认transport客户端为5s，其他为-1（禁用）。    
    
httpd.enabled    
是否使用http协议提供服务。默认为：true（开启）。    
    
http.max_content_length    
最大http请求内容。默认为100MB。如果设置超过100MB，将会被MAX_VALUE重置为100MB。    
    
http.max_initial_line_length    
http的url的最大长度。默认为：4kb。    
    
http.max_header_size    
http中header的最大值。默认为8kb。    
    
http.compression    
支持压缩（Accept-Encoding）。默认为：false。    
    
http.compression_level    
定义压缩等级。默认为：6。    
    
http.cors.enabled    
启用或禁用跨域资源共享。默认为：false。    
    
http.cors.allow-origin    
启用跨域资源共享后，默认没有源站被允许。在//中填写域名支持正则，例如 /https?:\/\/localhost(:[0-9]+)?/。 * 是有效的值，但是开放任何域名的跨域请求被认为是有安全风险的elasticsearch实例。    
    
http.cors.max-age    
浏览器发送‘preflight’OPTIONS-request 来确定CORS设置。max-age 定义缓存的时间。默认为：1728000 （20天）。    
    
http.cors.allow-methods    
允许的http方法。默认为OPTIONS、HEAD、GET、POST、PUT、DELETE。        
    
http.cors.allow-headers    
允许的header。默认 X-Requested-With, Content-Type, Content-Length。    
    
http.cors.allow-credentials    
是否允许返回Access-Control-Allow-Credentials头部。默认为：false。    
    
http.detailed_errors.enabled    
启用或禁用输出详细的错误信息和堆栈跟踪响应输出。默认为：true。    
    
http.pipelining    
启用或禁用http管线化。默认为：true。    
    
http.pipelining.max_events    
一个http连接关闭之前最大内存中的时间队列。默认为：10000。    
    

#### Discovery部分

discovery.zen.minimum_master_nodes: 3    
预防脑裂（split brain）通过配置大多数节点（总节点数/2+1）。默认为3。    
    
discovery.zen.ping.multicast.enabled: false    
设置是否打开组播发现节点。默认false。    
    
discovery.zen.ping.unicast.host    
单播发现所使用的主机列表，可以设置一个属组，或者以逗号分隔。每个值格式为 host:port 或 host（端口默认为：9300）。默认为 127.0.0.1，[::1]。    
    
discovery.zen.ping.timeout: 3s    
设置集群中自动发现其它节点时ping连接超时时间，默认为3秒，对于比较差的网络环境可以高点的值来防止自动发现时出错。    
    
discovery.zen.join_timeout    
节点加入到集群中后，发送请求到master的超时时间，默认值为ping.timeout的20倍。    
    
discovery.zen.master_election.filter_client：true    
当值为true时，所有客户端节点（node.client：true或node.date，node.master值都为false）将不参加master选举。默认值为：true。    
    
discovery.zen.master_election.filter_data：false    
当值为true时，不合格的master节点（node.data：true和node.master：false）将不参加选举。默认值为：false。    
    
discovery.zen.fd.ping_interval    
发送ping监测的时间间隔。默认为：1s。    
    
discovery.zen.fd.ping_timeout        
ping的响应超时时间。默认为30s。    
    
discovery.zen.fd.ping_retries    
ping监测失败、超时的次数后，节点连接失败。默认为3。    
    
discovery.zen.publish_timeout    
通过集群api动态更新设置的超时时间，默认为30s。    
    
discovery.zen.no_master_block    
设置无master时，哪些操作将被拒绝。all 所有节点的读、写操作都将被拒绝。write 写操作将被拒绝，可以读取最后已知的集群配置。默认为：write。    


#### Gateway部分
    
gateway.expected_nodes: 0    
设置这个集群中节点的数量，默认为0，一旦这N个节点启动，就会立即进行数据恢复。    
        
gateway.expected_master_nodes    
设置这个集群中主节点的数量，默认为0，一旦这N个节点启动，就会立即进行数据恢复。    
    
gateway.expected_data_nodes    
设置这个集群中数据节点的数量，默认为0，一旦这N个节点启动，就会立即进行数据恢复。    
    
gateway.recover_after_time: 5m    
设置初始化数据恢复进程的超时时间，默认是5分钟。    
    
gateway.recover_after_nodes    
设置集群中N个节点启动时进行数据恢复。    
    
gateway.recover_after_master_nodes    
设置集群中N个主节点启动时进行数据恢复。    
    
gateway.recover_after_data_nodes    
设置集群中N个数据节点启动时进行数据恢复。    
    
    
    

## Elasticsearch常用插件
* elasticsearch-head 插件
一个elasticsearch的集群管理工具，它是完全由html5编写的独立网页程序，你可以通过插件把它集成到es。

* bigdesk插件
elasticsearch的一个集群监控工具，可以通过它来查看es集群的各种状态，如：cpu、内存使用情况，索引数据、搜索情况，http连接数等。

* Kopf 插件
一个ElasticSearch的管理工具，它也提供了对ES集群操作的API。


## 参考
* [Elasticsearch 最佳运维实践 - 总结（二）](https://www.cnblogs.com/kevingrace/p/10682264.html)
