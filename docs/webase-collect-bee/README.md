# WeBASE-Collect-Bee
[![License](https://img.shields.io/badge/license-Apache%202-4EB1BA.svg)](https://www.apache.org/licenses/LICENSE-2.0.html)
[![Gitter](https://badges.gitter.im/WeBASE-Collect-Bee/WeBASE-Collect-Bee.svg)](https://gitter.im/WeBASE-Collect-Bee/community)


> 穿花度柳飞如箭，
> 粘絮寻香似落星。
> 小小微躯能负重，
> 器器薄翅会乘风。
> -- 吴承恩

## 1. 组件介绍

### 1.1 组件介绍
WeBASE-Collect-Bee 是一个基于[FISCO-BCOS](https://github.com/FISCO-BCOS/FISCO-BCOS)平台的数据导出工具。

数据导出组件WeBASE-Collect-Bee的目的在于降低获取区块链数据的开发门槛，提升研发效率。研发人员几乎不需要编写任何代码，只需要进行简单配置，就可以把数据导出到Mysql数据库。

WeBASE-Collect-Bee可以导出区块链上的基础数据，如当前块高、交易总量等。如果正确配置了FISCO-BCOS上运行的所有合约，WeBASE-Collect-Bee可以导出区块链上这些合约的业务数据，包括event、构造函数、合约地址、执行函数的信息等。

数据导出组件支持多数据源、分库分表、读写分离、分布式部署。

WeBASE-Collect-Bee提供了基于Restful的API，支持通过http的方式调用这些接口。

WeBASE-Collect-Bee还集成了Swagger组件，提供了可视化的文档和测试控制台。

你可以通过[WeBASE-Codegen-Monkey](https://github.com/WeBankFinTech/WeBASE-Codegen-Monkey/tree/dev_v0.7.0.2019.06)来自动生成本工程，只需要在一个配置文件中进行少量简单的配置，同时按照要求提供相关的智能合约信息；我们推荐这种方式。

### 1.2 使用场景和解决方案
区块链的数据存储在区块链上，需要使用智能合约暴露的接口来进行调用。由于智能合约暴露的接口的限制，区块链上不适合进行复杂的数据查询、大数据分析和数据可视化等工作。因此，我们致力于提供一种智能化、自动化的数据导出和备份的解决方案。

#### 案例 数据可视化后台系统
- 背景

某互联网小贷公司基于FISCO-BCOS开发了区块链借条业务系统，客户之间的借贷合同信息和证明材料都会在脱敏后保存到区块链上。该公司的运营人员需要获得当前业务进展的实时信息和摘要信息。

- 解决方案

该公司使用[WeBASE-Codegen-Monkey](https://github.com/WeBankFinTech/WeBASE-Codegen-Monkey/tree/dev_v0.7.0.2019.06)迅速生成了WeBASE-Collect-Bee的代码，并根据实际需求进行了定制化开发，在一天之内投入到线上使用。

导出到db的数据接入到了该公司的统一监控平台，该公司PM可以在业务后台系统上获得该业务的实时进展，该公司运维人员可以在公司运维监控室的大屏幕实时监控业务系统的状态。

#### 案例 区块链业务数据对账系统
- 背景

某公司基于FISCO-BCOS开发了区块链的业务系统，需要将本地数据与链上的数据进行对账。

- 解决方案
该公司使用[WeBASE-Codegen-Monkey](https://github.com/WeBankFinTech/WeBASE-Codegen-Monkey/tree/dev_v0.7.0.2019.06)迅速生成了WeBASE-Collect-Bee的代码，并根据实际需求进行了定制化开发。通过在智能合约中设计的各类event，相关的业务数据都被导出到数据库中；从而实现轻松对账的需求。

#### 案例 区块链业务数据查询系统
- 背景

某互联网公司基于FISCO-BCOS开发了区块链的业务系统，但是发现智能合约对业务报表的支持不佳。但是，公司的一线业务部门要求实时查看各类复杂的业务报表。

- 解决方案

该公司使用[WeBASE-Codegen-Monkey](https://github.com/WeBankFinTech/WeBASE-Codegen-Monkey/tree/dev_v0.7.0.2019.06)迅速生成了WeBASE-Collect-Bee的代码，并根据实际需求进行了定制化开发，区块链上的数据可以实时导出到数据库中。利用WeBASE-Collect-Bee自带的Restful API，该公司的报表系统实现了和区块链数据的对接，可以获得准实时的各类业务报表。

### 1.3 特性介绍

#### 可自动生成代码
可使用[WeBASE-Codegen-Monkey](https://github.com/WeBankFinTech/WeBASE-Codegen-Monkey/tree/dev_v0.7.0.2019.06)生成的代码和配置文件，自动组装成数据导出工程实例

#### 支持灵活的数据库策略
集成sharding-jdbc组件，支持多数据源、分库分表、读写分离

#### 支持集群部署和分布式任务调度
集成elstic-job开源组件，支持灵活的分布式部署和任务调度

#### 可定制化的数据导出策略
提供灵活的可配置的区块、交易、事件、账户等数据导出功能，过滤不需要的数据

#### 提供丰富的Restful API查询接口
支持丰富的Restful API数据查询接口

#### 提供可视化的互动API控制台
集成swagger插件，提供可视化互动API控制台

### 支持可视化的监控页面
WeBASE-Collect-Bee可与grafana深度集成，支持自动生成dashboard实例，让您的链上数据了如指掌。

## 2. 快速开始

### 2.1 前置依赖
在使用本组件前，请确认系统环境已安装相关依赖软件，清单如下：

| 依赖软件 | 说明 |备注|
| --- | --- | --- |
| FISCO-BCOS | >= 2.0， 1.x版本请参考V0.5版本 |
| Bash | 需支持Bash（理论上来说支持所有ksh、zsh等其他unix shell，但未测试）|
| Java | >= JDK[1.8] | |
| Git | 下载的安装包使用Git | |
| MySQL | >= mysql-community-server[5.7] | |
| zookeeper | >= zookeeper[3.4] | 只有在进行集群部署的时候需要安装|


### 2.2 部署步骤

#### 2.2.1 获取工程代码

请按照[WeBASE-Codegen-Monkey](https://github.com/WeBankFinTech/WeBASE-Codegen-Monkey/tree/dev_v0.7.0.2019.06)的操作手册进行操作。

如果你已经按照[WeBASE-Codegen-Monkey](https://github.com/WeBankFinTech/WeBASE-Codegen-Monkey/tree/dev_v0.7.0.2019.06)的操作手册进行操作，那么恭喜，你将获得一个完整WeBASE-Collect-Bee工程目录。

WeBASE-Collect-Bee的工程使用gradle进行构建，是一个SpringBoot工程。

```
-build.gradle
-config/contract
-src/main
         -resources
         		application-sharding-tables.properties
         		application.properties
         		ca.crt
         		node.crt
         		node.key
         -java

```

其中build.gradle为gradle的构建文件，config/contract目录存放了合约编译为Java的文件，src/main/resources下面存放了配置文件。

自动生成的Java代码一般位于src/main/java/com/webank/webasebee/generated；而合约编译后的文件除了会被存放到config/contract文件夹下以外，还会按照原有的package名称放入到src/main/java的路径下。


#### 2.2.2 配置工程(更多高级配置)

当完整地按照[WeBASE-Codegen-Monkey](https://github.com/WeBankFinTech/WeBASE-Codegen-Monkey/tree/dev_v0.7.0.2019.06)的操作手册进行操作获得WeBASE-Collect-Bee工程后，会得到WeBASE-Collect-Bee工程，主要的基础配置都将会在配置中自动生成，无需额外配置。但是，基于已生成的配置文件，你可以继续按照需求进行深入的个性化高级配置，例如配置集群部署、分库分表、读写分离等等。


在得到WeBASE-Collect-Bee工程后，进入WeBASE-Collect-Bee的目录：

```
cd WeBASE-Collect-Bee

```

主要的配置文件位于src/main/resources目录下。其中，application.properties包含了除部分数据库配置外的全部配置。 application-sharding-tables.properties包含了数据库部分的配置。

注意： 当修改完配置文件后，需要重新编译代码，然后再执行，编译的命令如下：

```
sh gradlew clean bootJar

```

##### 导出数据范围的配置

配置文件位于 src/main/resources/application.properties

| 配置项 | 是否必输 | 说明 | 举例 | 默认值 |
| --- | --- | --- | --- | --- |
| system.startBlockHeight | N | 设置导出数据的起始区块号，优先以此配置为准 | 1000 | 0 |
| system.startDate | N | 设置导出数据的起始时间，例如设置导出2019年元旦开始上链的数据；如已配置startBlockHeight，以导出数据起始区块号为准。支持的数据格式包括：yyyy-MM-dd HH:mm:ss 或 yyyy-MM-dd 或 HH:mm:ss 或 yyyy-MM-dd HH:mm  或 yyyy-MM-dd  HH:mm:ss.SSS | 2019-01-01 | - |

##### 单节点部署的配置
在选择单节点配置后，以下配置会自动生成。
单节点任务调度的配置，分布式任务调度的配置默认位于 src/main/resources/application.properties

```
#### 当此参数为false时，进入单节点任务模式
system.multiLiving=false

#### 开启多线程下载的区块阈值，如果当前已完成导出的区块高度小于当前区块总高度减去该阈值，则启动多线程下载
system.maxBlockHeightThreshold=50
#### 多线程下载的分片数量，当完成该分片所有的下载任务后，才会统一更新下载进度。
system.crawlBatchUnit=100
```

##### 集群部署的配置
多节点任务调度的配置，分布式任务调度的配置默认位于 src/main/resources/application.properties

```
#### 当此参数为true时，进入多节点任务模式
system.multiLiving=true

#### zookeeper配置信息，ip和端口
regcenter.serverList=ip:port
#### zookeeper的命名空间
regcenter.namespace=namespace

#### prepareTaskJob任务：主要用于读取当前区块链块高，将未抓取过的块高存储到数据库中。
#### cron表达式，用于控制作业触发时间
prepareTaskJob.cron=0/5 * * * * ?
### 分片总数量
prepareTaskJob.shardingTotalCount=1
#### 分片序列号和参数用等号分隔，多个键值对用逗号分隔,分片序列号从0开始，不可大于或等于作业分片总数
prepareTaskJob.shardingItemParameters=0=A

#### dataflowJob任务： 主要用于执行区块下载任务
dataflowJob.cron=0/5 * * * * ?
### 分片总数量
dataflowJob.shardingTotalCount=3
#### 分片序列号和参数用等号分隔，多个键值对用逗号分隔,分片序列号从0开始，不可大于或等于作业分片总数
dataflowJob.shardingItemParameters=0=A,1=B,2=C
```

数据库配置解析，数据库的配置默认位于 src/main/resources/application-sharding-tables.properties

##### 分库分表的配置
实践表明，当区块链上存在海量的数据时，导出到单个数据库或单个业务表会对运维造成巨大的压力，造成数据库性能的衰减。
一般来讲，单一数据库实例的数据的阈值在1TB之内，单一数据库表的数据的阈值在10G以内，是比较合理的范围。

如果数据量超过此阈值，建议对数据进行分片。将同一张表内的数据拆分到多个或同个数据库的多张表。

```

#### 定义多个数据源
sharding.jdbc.datasource.names=ds0,ds1

#### 数据源ds0的默认配置
sharding.jdbc.datasource.ds0.type=com.zaxxer.hikari.HikariDataSource
sharding.jdbc.datasource.ds0.driver-class-name=com.mysql.cj.jdbc.Driver
sharding.jdbc.datasource.ds0.url=jdbc:mysql://localhost:3306/ds0
sharding.jdbc.datasource.ds0.username=
sharding.jdbc.datasource.ds0.password=

#### 数据源ds1的默认配置
sharding.jdbc.datasource.ds1.type=com.zaxxer.hikari.HikariDataSource
sharding.jdbc.datasource.ds1.driver-class-name=com.mysql.cj.jdbc.Driver
sharding.jdbc.datasource.ds1.url=jdbc:mysql://localhost:3306/ds1
sharding.jdbc.datasource.ds1.username=
sharding.jdbc.datasource.ds1.password=

#### 数据库默认分库分表的列字段
sharding.jdbc.config.sharding.default-database-strategy.inline.sharding-column=user_id
#### 数据库默认分库分表的算法
sharding.jdbc.config.sharding.default-database-strategy.inline.algorithm-expression=ds$->{user_id % 2}

#### 数据库表block_tx_detail_info的配置，以下配置即为数据自动分为5个分片，以block_height%5来进行路由，pk-id为自增值
sharding.jdbc.config.sharding.tables.block_tx_detail_info.actual-data-nodes=ds.block_tx_detail_info_$->{0..4}
sharding.jdbc.config.sharding.tables.block_tx_detail_info.table-strategy.inline.sharding-column=block_height
sharding.jdbc.config.sharding.tables.block_tx_detail_info.table-strategy.inline.algorithm-expression=block_tx_detail_info_$->{block_height % 5}
sharding.jdbc.config.sharding.tables.block_tx_detail_info.key-generator-column-name=pk_id

#### 如果需要对更多的数据库表进行分片，请按上面的例子进行修改、配置

```

##### 数据库读写分离的配置：

数据库读写分离的主要设计目标是让用户无痛地使用主从数据库集群，就好像使用一个数据库一样。读写分离的特性支持往主库写入数据，往从库查询数据，从而减轻数据库的压力，提升服务的性能。

**注意**，本组件不会实现主库和从库的数据同步、主库和从库的数据同步延迟导致的数据不一致、主库双写或多写。

```
#### 配置一主两从的数据库
sharding.jdbc.datasource.names=master,slave0,slave1

sharding.jdbc.datasource.master.type=org.apache.commons.dbcp.BasicDataSource
sharding.jdbc.datasource.master.driver-class-name=com.mysql.jdbc.Driver
sharding.jdbc.datasource.master.url=jdbc:mysql://localhost:3306/master
sharding.jdbc.datasource.master.username=
sharding.jdbc.datasource.master.password=

sharding.jdbc.datasource.slave0.type=org.apache.commons.dbcp.BasicDataSource
sharding.jdbc.datasource.slave0.driver-class-name=com.mysql.jdbc.Driver
sharding.jdbc.datasource.slave0.url=jdbc:mysql://localhost:3306/slave0
sharding.jdbc.datasource.slave0.username=
sharding.jdbc.datasource.slave0.password=

sharding.jdbc.datasource.slave1.type=org.apache.commons.dbcp.BasicDataSource
sharding.jdbc.datasource.slave1.driver-class-name=com.mysql.jdbc.Driver
sharding.jdbc.datasource.slave1.url=jdbc:mysql://localhost:3306/slave1
sharding.jdbc.datasource.slave1.username=
sharding.jdbc.datasource.slave1.password=

sharding.jdbc.config.masterslave.name=ms
sharding.jdbc.config.masterslave.master-data-source-name=master
sharding.jdbc.config.masterslave.slave-data-source-names=slave0,slave1

sharding.jdbc.config.props.sql.show=true

```

##### 数据库读写分离+分库分表的配置：


```

sharding.jdbc.datasource.names=master,slave0
        
sharding.jdbc.datasource.master.type=com.zaxxer.hikari.HikariDataSource
sharding.jdbc.datasource.master.driver-class-name=com.mysql.cj.jdbc.Driver
sharding.jdbc.datasource.master.jdbc-url=jdbc:mysql://106.12.31.94:3306/test0?useSSL=false&serverTimezone=GMT%2b8&useUnicode=true&characterEncoding=UTF-8
sharding.jdbc.datasource.master.username=
sharding.jdbc.datasource.master.password=

sharding.jdbc.datasource.slave0.type=com.zaxxer.hikari.HikariDataSource
sharding.jdbc.datasource.slave0.driver-class-name=com.mysql.cj.jdbc.Driver
sharding.jdbc.datasource.slave0.jdbc-url=jdbc:mysql://106.12.31.94:3306/test1?useSSL=false&serverTimezone=GMT%2b8&useUnicode=true&characterEncoding=UTF-8
sharding.jdbc.datasource.slave0.username=
sharding.jdbc.datasource.slave0.password=

sharding.jdbc.config.sharding.master-slave-rules.ds0.master-data-source-name=master
sharding.jdbc.config.sharding.master-slave-rules.ds0.slave-data-source-names=slave0

sharding.jdbc.config.sharding.tables.activity_activity.actual-data-nodes=ds0.block_tx_detail_info$->{0..1}
sharding.jdbc.config.sharding.tables.activity_activity.table-strategy.inline.sharding-column=block_height
sharding.jdbc.config.sharding.tables.activity_activity.table-strategy.inline.algorithm-expression=block_tx_detail_info$->{block_height % 2}

sharding.jdbc.config.props.sql.show=true

```


#### 2.2.3 编译代码并运行程序

如果你已经按照[WeBASE-Codegen-Monkey](https://github.com/WeBankFinTech/WeBASE-Codegen-Monkey/tree/dev_v0.7.0.2019.06)的操作手册进行操作，那么可跳过此章节。

但是如果你对配置或代码进行了深度定制，可参考以下步骤：

```
sh gradlew clean bootJar
sh generate_bee.sh build 
cd dist
chmod +x *.jar
nohup java -jar *.jar >/dev/null 2>&1 &
tail -f *.log
```

当然，你也可以使用supervisor来守护和管理进程，supervisor能将一个普通的命令行进程变为后台daemon，并监控进程状态，异常退出时能自动重启。
它是通过fork/exec的方式把这些被管理的进程当作supervisor的子进程来启动，这样只要在supervisor的配置文件中，把要管理的进程的可执行文件的路径写进去即可。
也实现当子进程挂掉的时候，父进程可以准确获取子进程挂掉的信息的，可以选择是否自己启动和报警。
supervisor还提供了一个功能，可以为supervisord或者每个子进程，设置一个非root的user，这个user就可以管理它对应的进程。

supervisor的安装与部署可以参考 [WeBASE-Codegen-Monkey](https://github.com/WeBankFinTech/WeBASE-Codegen-Monkey/tree/dev_v0.7.0.2019.06) 附录6的说明文档。


#### 2.2.4 检查运行状态及退出

##### 2.2.4.1 检查程序进程是否正常运行
```
ps -ef |grep WeBASE-Collect-Bee
```
如果看到如下信息，则代表进程执行正常：
```
app   21980 24843  0 15:23 pts/3    00:00:44 java -jar WeBASE-Collect-Bee0.3.0-SNAPSHOT.jar
```

##### 2.2.4.2 检查程序是否已经正常执行

当你看到程序运行，并在最后出现以下字样时，则代表运行成功：
    
```
Hibernate: select blockheigh0_.pk_id as pk_id1_2_, blockheigh0_.block_height as block_he2_2_, blockheigh0_.event_name as event_na3_2_, blockheigh0_.depot_updatetime as depot_up4_2_ from block_height_info blockheigh0_ where blockheigh0_.event_name=?
Hibernate: select blockheigh0_.pk_id as pk_id1_2_, blockheigh0_.block_height as block_he2_2_, blockheigh0_.event_name as event_na3_2_, blockheigh0_.depot_updatetime as depot_up4_2_ from block_height_info blockheigh0_ where blockheigh0_.event_name=?
Hibernate: select blockheigh0_.pk_id as pk_id1_2_, blockheigh0_.block_height as block_he2_2_, blockheigh0_.event_name as event_na3_2_, blockheigh0_.depot_updatetime as depot_up4_2_ from block_height_info blockheigh0_ where blockheigh0_.event_name=?
```

##### 2.2.4.3 检查数据是否已经正常产生

你也可以通过DB来检查，登录你之前配置的数据库，看到自动创建完表的信息，以及表内开始出现数据内容，则代表一切进展顺利。如你可以执行以下命令：
```
# 请用你的配置信息替换掉[]里的配置，并记得删除[]
mysql -u[用户名] -p[密码] -e "use [数据库名]; select count(*) from block_detail_info"
```
如果查询结果非空，出现类似的如下记录，则代表导出数据已经开始运行：
```
+----------+
| count(*) |
+----------+
|      633 |
+----------+
```

##### 2.2.4.4 停止导入程序

```
ps -ef |grep WeBASE-Collect-Bee |grep -v grep|awk '{print $2}' |xargs kill -9

```

#### 2.2.5 监控数据导出
在WeBASE-Collect-Bee工程最终编译后，生成的dist目录会有个monitor.sh脚本.  执行该脚本可以用来监控数据导出服务是否正常启动或者数据导出是否正常工作。

 ##### 2.2.5.0 个性化配置

 打开monitor.sh，可以修改相关的个性化配置：

 ```
# WeBASE-Collect-Bee服务启动的IP地址
ip=127.0.0.1
# WeBASE-Collect-Bee服务启动的端口
port=8082
# 数据导出的进度落后于链高度的报警阈值；如当前进度落后当前链高度达到20个以上，输出报警日志。
threshold=20
# 当链高度增长，数据导出完成块高的报警阈值；如当前块高增长，但完成导出的区块数量增长小于等于1.
warn_number=1
```

 ##### 2.2.5.1  使用
monitor.sh脚本可以直接执行. 
```
./monitor.sh 
block height now is 47
download number is 48
Now have 0 blocks to depot
OK! to do blocks is lesss than 20
OK! done blocks from 48 to 48, and height is from 48 to 48
```

 ##### 2.2.5.2 提示
```OK! to do blocks is lesss than $threshold```  区块导出总体进度正常.
 ```OK! done blocks from $prev_done to $b, and height is from $prev_height to $a```  上个时间周期区块导出进度正常.
 ```ERROR! $todo_blocks:the block height is far behind.```    区块总体下载进度异常.
 ```ERROR! Depot task stuck in trouble, done block is $prev_done to $b , but block height is from $prev_height to $a ```  上个时间周期数据导出进度异常.
 ```ERROR! Get block height error.```    获取块高失败.
 ```ERROR! Get done block count error.```    获取区块下载数量失败。
 ##### 2.2.5.3  配置crontab
 建议将monitor.sh添加到crontab中，设置为每分钟执行一次，并将输出重定向到日志文件。可以日常扫描日志中的```ERROR!```字段就能找出节点服务异常的时段, 也可以在节点挂掉情况下及时将节点重启。  
 在crontab的配置可以参考如下：
 ```
 */1  * * * * /data/app/fisco-bcos/WeBASE-Collect-Bee/dist/monitor.sh >> /data/app/fisco-bcos/WeBASE-Collect-Bee/dist/monitor.log 2>&1
 ```
 用户在实际中使用时将monitor.sh、monitor.log的路径修改即可。


### 2.3 可视化监控程序安装和部署

#### 2.3.1 安装软件

首先，请安装docker，docker的安装可参考[docker安装手册](https://docker_practice.gitee.io/install/centos.html)

等docker安装成功后，请下载grafana：

```
docker pull grafana/grafana

```

如果你是使用sudo用户安装了docker，可能会提示『permission denied』的错误，建议执行:
```
sudo docker pull grafana/grafana

```

#### 2.3.2 启动grafana
```
docker run   -d   -p 3000:3000   --name=grafana   -e "GF_INSTALL_PLUGINS=grafana-clock-panel,grafana-simple-json-datasource"   grafana/grafana
```
grafana将自动绑定3000端口并自动安装时钟和Json的插件。


#### 2.3.3 登录grafana界面

直接使用浏览器访问： http://your_ip:3000/ 

请注意使用你机器的IP替换掉your_ip

默认的用户名和密码为admin/admin


#### 2.3.4 添加MySQL数据源
在正常登录成功后，如图所示，选择左边栏设置按钮，点击『Data Sources』， 选择『MySQL』数据源

![添加步骤：](https://github.com/WeBankFinTech/WeBASE-Codegen-Monkey/blob/dev_v0.7.0.2019.06/photos/add_datasource.png)

随后按照提示的页面，配置 Host， Database， User 和 Password等。

#### 2.3.5 导入Dashboard模板
[WeBASE-Codegen-Monkey](https://github.com/WeBankFinTech/WeBASE-Codegen-Monkey/tree/dev_v0.7.0.2019.06)会自动生成数据的dashboard模板，数据的路径位于：WeBASE-Collect-Bee/src/main/scripts/grafana/default_dashboard.json

请点击左边栏『+』，选择『import』，点击绿色按钮『Upload .json File』,选择刚才的WeBASE-Collect-Bee/src/main/scripts/grafana/default_dashboard.json文件

![导入步骤：](https://github.com/WeBankFinTech/WeBASE-Codegen-Monkey/blob/dev_v0.7.0.2019.06/photos/import_json.png)

最后，点击『import』按钮。

如果导入成功，dashboards下面会出现『FISCO-BCOS区块链监控视图』

您可以选择右上方的时间按钮来选择和设置时间范围及刷新时间等。

您也可以选中具体的页面组件进行编辑，自由地移除或挪动组件的位置，达到更好的使用体验。

更多关于Grafana的自定义配置和开发文档，可参考 [Grafana官方文档](http://docs.grafana.org/guides/getting_started/)


### 2.4 开启可视化的功能性测试
WeBASE-Collect-Bee默认集成了swagger的插件，支持通过可视化的控制台来发送交易、生成报文、查看结果、调试交易等。

![swagger控制台：](https://github.com/WeBankFinTech/WeBASE-Codegen-Monkey/blob/dev_v0.7.0.2019.06/photos/swagger.png)


**请注意， swagger插件仅推荐在开发或测试环境调试使用，在正式上生产环境时，请关闭此插件**

#### 2.4.1 打开swagger页面：

请在你的浏览器打开此地址：

> http://your_ip:port/swagger-ui.html

例如，当你在本机运行了WeBASE-Collect-Bee，且未修改默认的8080端口，则可以访问此地址：

> http://localhost:8080/swagger-ui.html

此时，你可以看到上述页面，可以看到页面主要包括了http请求页面和数据模型两部分。


#### 2.4.2 使用swagger发送具体的交易：

选择点击对应的http请求集，可以点开相关的http请求。此时，你可以选择点击“try it out”，手动修改发送的Json报文，点击“Excute”按钮，即可发送并查收结果。

我们以查询区块信息为例，如下列图所示：

![选择请求：](https://github.com/WeBankFinTech/WeBASE-Codegen-Monkey/blob/dev_v0.7.0.2019.06/photos/swag_test1.png)

![编辑报文：](https://github.com/WeBankFinTech/WeBASE-Codegen-Monkey/blob/dev_v0.7.0.2019.06/photos/swag_test2.png)

![查收结果：](https://github.com/WeBankFinTech/WeBASE-Codegen-Monkey/blob/dev_v0.7.0.2019.06/photos/swag_test3.png)

## 3. 存储模型

数据导出中间件会自动将数据导出到存储介质中，每一类数据都有特定的存储格式和模型，以MySQL为例。包括四类数据：区块数据、账户数据、事件数据和交易数据。

### 3.1 区块数据存储模型

区块数据存储模型包括三个数据存储模型，分别为区块基本数据存储模型、区块详细数据存储模型及区块交易数据存储模型。

#### 3.1.1 区块下载任务明细表

存储了所有区块的状态信息和下载情况，对应数据库表名称为**block_task_pool**,如下所示:

| 字段 | 类型 | 字段设置 | 默认值 | 说明 |
| --- | --- | --- | --- | --- |
| pk_id | bigint(20) | Primary key & NOT NULL | 自增 | 主键Id |
| block_height | bigint(20) |  |  | 块高 |
| certainty   |  int(11)		| 是否可能分叉 | 0- 是； 1-否 |
| handle_item | int(11) |  |  | 处理分片序号，默认为0 |
| sync_status | int |  | 2 | 0-待处理；1-处理中；2-已成功；3-处理失败；4-超时 |
| depot_updatetime | datetime |  | 系统时间 | 记录插入/更新时间 |


#### 3.1.2	区块详细数据存储模型

区块详细数据存储模型用于存储每个区块的详细数据，包括区块哈希、块高、出块时间、块上交易量，对应的数据库表名为**block_detail_info**。如下表所示。

| 字段 | 类型 | 字段设置 | 默认值 | 说明 |
| --- | --- | --- | --- | --- |
| pk_id | bigint(20) | Primary key & NOT NULL | 自增 | 主键Id |
| block_hash | varchar(225) | Unique key & Index |  | 区块哈希 |
| block_height | bigint(20) |  |  | 区块高度 |
| block_tiemstamp | datetime | index |  | 出块时间 |
| tx_count | int(11) |  |  | 当前区块交易量 |
| depot_updatetime | datetime |  | 系统时间 | 记录插入/更新时间 |

#### 3.1.3区块交易数据存储模型

区块交易数据存储模型用于存储每个区块中每个交易的基本信息，包括区块哈希、块高、出块时间、合约名称、方法名称、交易哈希、交易发起方地址、交易接收方地址，对应的数据库表名为**block_tx_detail_info**。如下表所示。

| 字段 | 类型 | 字段设置 | 默认值 | 说明 |
| --- | --- | --- | --- | --- |
| pk_id | bigint(20) | Primary key & NOT NULL | 自增 | 主键Id |
| block_hash | varchar(225) | Unique key & Index |  | 区块哈希 |
| block_height | bigint(20) |  |  | 区块高度 |
| block_tiemstamp | datetime | index |  | 出块时间 |
| contract_name | varchar(225) |  |  | 该笔交易的合约名称 |
| method_name | varchar(225) |  |  | 该笔交易调用的function名称 |
| tx_hash | varchar(225) |  |  | 交易哈希 |
| tx_from | varchar(225) |  |  | 交易发起方地址 |
| tx_to | varchar(225) |  |  | 交易接收方地址 |
| depot_updatetime | datetime |  | 系统时间 | 记录插入/更新时间 |

### 3.2 账户数据存储模型

账户数据存储模型用于存储区块链网络中所有账户信息，包括账户创建时所在块高、账户所在块的出块时间、账户地址（合约地址）、合约名称。对应的数据库表名为**account_info**。如下表所示。需要注意的是，如果通过嵌套合约隐式调用构造方法，则不会导出。比如A合约中通过关键字new一个B合约，则B合约不会导出。

| 字段 | 类型 | 字段设置 | 默认值 | 说明 |
| --- | --- | --- | --- | --- |
| pk_id | bigint(20) | Primary key & NOT NULL | 自增 | 主键Id |
| block_height | bigint(20) | index |  | 区块高度 |
| block_tiemstamp | datetime | index |  | 出块时间 |
| contract_address | varchar(225) | index |  | 合约/账户地址 |
| contract_name | varchar(225) |  |  | 合约名称 |
| depot_updatetime | datetime |  | 系统时间 | 记录插入/更新时间 |

### 3.3 事件数据存储模型

事件数据存储模型是根据合约中的事件（Event）自动生成的。一个合约中有多少个事件就会生成多少个对应的事件数据存储表。

#### 3.3.1 事件数据存储命名规则

由于事件数据存储模型是自动生成的，所以事件数据存储表名和表结构及字段命名采用统一的规则。以如下合约作为示例。

```
pragma solidity ^0.4.7;
contract UserInfo {
    bytes32 _userName;
    uint8 _sex;
    
    function UserInfo(bytes32 userName, uint8 sex) public {
        _userName = userName;
        _sex = sex;
    }
    
    event modifyUserNameEvent(bytes32 userName，uint8 sex);
    
    function modifyUserName(bytes32 userName) public returns(bytes32){
        _userName = userName;
        modifyUserNameEvent(_userName，_sex);
        return _userName;
    }
}
```
##### 3.3.1.1	事件表命名规则

事件表命名规则为：合约名称_事件名称，并将合约名称和事件名称中的驼峰命名转化为小写加下划线方式。比如上述合约中合约名称为UserInfo，事件名称为modifyUserNameEvent，则表名称为user_info_modify_user_name_event。

##### 3.3.1.2	事件字段命名规则

事件字段命名规则：事件字段驼峰命名转化为小写加下划线方式。仍以上述合约中modifyUserNameEvent为例，包含字段userName，则在user_info_modify_user_name_event表中对应的字段为user_name。

#### 3.3.2 事件数据存储模型

事件数据存储模型除过存储该事件的相关信息外，还会存储和该事件相关的块和交易信息，如下表所示。

| 字段 | 类型 | 字段设置 | 默认值 | 说明 |
| --- | --- | --- | --- | --- |
| pk_id | bigint(20) | Primary key & NOT NULL | 自增 | 主键Id |
| block_height | bigint(20) | index |  | 区块高度 |
| block_tiemstamp | datetime | index |  | 出块时间 |
| **event-paralist** |  |  |  | 事件字段列表 |
| tx_hash | varchar(225) | index |  | 交易哈希 |
| depot_updatetime | datetime |  | 系统时间 | 记录插入/更新时间 |

以上述智能合约为例，对应的 **<event-paralist>** 如下：

| 字段 | 类型 | 字段设置 | 默认值 | 说明 |
| --- | --- | --- | --- | --- |
| user_name | varchar(255) |  |  | 用户名 |
| sex | int |  |  | 性别 |

### 3.4	交易数据存储模型

交易数据存储模型同事件数据存储模型类似，是根据合约中的方法（Function）自动生成的。一个合约中有多少个方法就会生成多少个对应的方法数据存储表。该方法指的是实际产生交易的方法（含构造方法），不包含事件（Event）方法和查询方法（constant关键字标注）。

#### 3.4.1	交易数据存储命名规则

交易数据存储表名、表结构及字段命名规则同事件数据存储模型类似，以3.3.1中的合约为例进行说明。

##### 3.4.1.1	交易表命名规则

交易表命名规则为：合约名称_方法名称，并将合约名称和方法名称中的驼峰命名转化为小写加下划线方式。比如上述合约中合约名称为UserInfo，方法名称为modifyUserName，则表名称为user_info_modify_user_name；构造方法名称为UserInfo，那么对应的表名为user_info_user_info。

##### 3.4.1.2	交易字段命名规则

交易字段命名规则也是将交易参数字段驼峰命名转化为小写加下划线，不再赘述。需要指出的是，对于一些没有参数的方法，交易数据存储模型没有办法存储，即通过无参方法产生的交易明细将无法通过数据导出工具获取到。

#### 3.4.2	交易数据存储模型

交易数据存储模型除过存储该方法的相关信息外，还会存储和该方法相关的块和交易信息，如下表所示。

| 字段 | 类型 | 字段设置 | 默认值 | 说明 |
| --- | --- | --- | --- | --- |
| pk_id | bigint(20) | Primary key & NOT NULL | 自增 | 主键Id |
| block_height | bigint(20) | index |  | 区块高度 |
| block_tiemstamp | datetime | index |  | 出块时间 |
| **function-paralist** |  |  |  | 方法字段列表 |
| tx_hash | varchar(225) | index |  | 交易哈希 |
| depot_updatetime | datetime |  | 系统时间 | 记录插入/更新时间 |

以**3.3.1**中的合约为例，对应的 **<function-paralist>** 如下：

| 字段 | 类型 | 字段设置 | 默认值 | 说明 |
| --- | --- | --- | --- | --- |
| user_name | varchar(255) |  |  | 用户名 |
| sex | int |  |  | 性别 |

