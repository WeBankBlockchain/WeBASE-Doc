# 部署说明

## 1. 前提条件

| 环境      | 版本                      |
| --------- | ------------------------- |
| Java      | Oracle JDK 8至14            |
| 数据库    | MySQL-5.6或以上版本       |
| ZooKeeper | ZooKeeper-3.6.0或以上版本 |

**备注：**

```eval_rst
.. important::
    FISCO-BCOS 2.0与3.0对比、JDK版本、WeBASE及其他子系统的兼容版本说明！`请查看 <https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/compatibility.html>`_
```

-  Java推荐使用[OpenJDK](./appendix.html#java )，建议从[OpenJDK网站](https://jdk.java.net/java-se-ri/11) 自行下载（CentOS的yum仓库的OpenJDK缺少JCE(Java Cryptography Extension)，导致Web3SDK无法正常连接区块链节点）

- 安装说明请参看 [安装示例](./appendix.html#id2)，不使用分布式任务可以不部署ZooKeeper。

**国密支持：**

WeBASE-Transaction v1.2.2+已支持 [国密版FISCO-BCOS](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/manual/guomi_crypto.html)

```eval_rst
.. important:
    使用国密版WeBASE-Transaction需要开启web3sdk的国密开关
```

开启web3sdk的国密开关:

- 开启web3sdk的国密开关：将配置文件`application.properties`中sdk配置的`encryptType`从`0`修改为`1`；
- 编译国密版智能合约在v1.3.1版本后，通过引入solcJ:0.4.25-rc1.jar，自动切换支持国密版智能合约的编译/部署/调用；（可自行切换solcJ-0.5.2）



## 2. 拉取代码

执行命令：

```shell
git clone https://github.com/WeBankBlockchain/WeBASE-Transaction.git

# 若因网络问题导致长时间下载失败，可尝试以下命令
git clone https://gitee.com/WeBank/WeBASE-Transaction.git
```

进入目录：

```
cd WeBASE-Transaction
```

## 3. 编译代码

使用以下方式编译构建，如果出现问题可以查看 [常见问题解答](./appendix.html#id9)</br>

方式一：如果服务器已安装Gradle，且版本为gradle-4.10至gradle-6.x版本

```shell
gradle build -x test
```

方式二：如果服务器未安装Gradle，或者版本不是gradle-4.10至gradle-6.x版本，使用gradlew编译

```shell
chmod +x ./gradlew && ./gradlew build -x test
```

构建完成后，会在根目录WeBASE-Transaction下生成已编译的代码目录dist。

## 4. 修改配置

### 4.1 复制模板

进入编译目录dist：

```
cd dist
```

dist目录提供了一份配置模板conf_template：

```
根据配置模板生成一份实际配置conf。初次部署可直接拷贝。
例如：cp conf_template conf -r
```

### 4.2 复制证书

进入配置目录conf：

```shell
cd conf
```

将节点所在目录`nodes/${ip}/sdk`下的所有文件拷贝到当前conf目录（包括ca.crt, sdk.crt, sdk.key, node.crt, node.key），供SDK与节点建立连接时使用。（若没有node.crt, node.key，可通过`cp`复制sdk.crt为node.crt, 复制sdk.key为node.key）
- 若使用的是**国密SSL模式**，则将`nodes/${ip}/sdk/gm`下的所有文件（包括gmca.crt, gmensdk.crt, gmensdk.key, gmsdk.crt, gmensdk.key）拷贝到当前conf目录（无需拷贝sdk目录下的sdk.crt等证书）。

### 4.3 修改配置

**说明：** 有注释的地方根据实际情况修改，完整配置项说明请查看 [配置说明](./appendix.html#application-properties)

```shell
vi application.properties
```

```
###################################  Basic Configuration  ###################################
# 工程服务端口，端口被占用则修改
server.port=5003
server.context-path=/WeBASE-Transaction
mybatis.mapper-locations=classpath:mapper/*.xml
logging.config=classpath:log4j2.xml

################################### web3sdk Configuration ###################################
# 机构名
sdk.orgName=webank
sdk.timeoutsdk=10000
# 线程池配置
sdk.corePoolSize=100
sdk.maxPoolSize=500
sdk.queueCapacity=500
sdk.keepAlive=60
# 群组信息，可配置多群组和多节点
# 群组id（下同）
sdk.groupConfig.allChannelConnections[0].groupId=1
# 连接节点的ip和channelPort（下同）
sdk.groupConfig.allChannelConnections[0].connectionsStr[0]=127.0.0.1:20200
sdk.groupConfig.allChannelConnections[0].connectionsStr[1]=127.0.0.1:20201
sdk.groupConfig.allChannelConnections[1].groupId=2
sdk.groupConfig.allChannelConnections[1].connectionsStr[0]=127.0.0.1:20200
sdk.groupConfig.allChannelConnections[1].connectionsStr[1]=127.0.0.1:20201
# 切换国密与非国密 0: standard, 1: guomi
sdk.encryptType=0
################################### constant Configuration ###################################
# WeBASE-Sign签名服务ip端口，使用本签名方式则对应修改
constant.signServer=127.0.0.1:5004
# 本地配置私钥进行签名，使用本签名方式则对应修改
constant.privateKey=edf02a4a69b14ee6b1650a95de71d5f50496ef62ae4213026bd8d6651d030995
constant.cronTrans=0/1 * * * * ?
constant.requestCountMax=6
constant.selectCount=10
constant.intervalTime=600
constant.sleepTime=50
# 是否删除数据
constant.ifDeleteData=false
constant.cronDeleteData=0 0 1 * * ?
constant.keepDays=360
# 使用分布式任务部署多活（true-是，false-否）
constant.ifDistributedTask=false

################################### elastic-job 分布式任务 ###################################
# 部署多活的话需配置zookeeper，支持集群
job.regCenter.serverLists=127.0.0.1:2181
# zookeeper命名空间
job.regCenter.namespace=elasticjob-transaction
# 分片数（如多活3个的话可分成3片）
job.dataflow.shardingTotalCount=3

###################################       数据源配置       ###################################
# * 说明：本工程使用Sharding-JDBC分库分表，支持单一数据源，也支持多库多表。
# *      单库单表：配置单个数据源，将分库策略和分表策略注释或删除
# *      多库多表：配置多数据源，以群组分库，以年份分表，用户自定义每年分成几个表（注：分表策略的路由字段不可修改[id,gmt_create]）
# * 样例：以两个数据源为例（数据库需事先创建），每张表根据年分表，每年再分成两个子表，以2020和2021年的表为例

# 配置所有的数据源，如此处定义了ds0,ds1两个数据源，对应两个库
sharding.jdbc.datasource.names=ds0,ds1

# 定义数据源ds0，配置数据库连接信息
sharding.jdbc.datasource.ds0.type=com.alibaba.druid.pool.DruidDataSource
sharding.jdbc.datasource.ds0.driver-class-name=com.mysql.cj.jdbc.Driver
sharding.jdbc.datasource.ds0.url=jdbc:mysql://127.0.0.1:3306/webasetransaction0?autoReconnect=true&useSSL=false&serverTimezone=GMT%2b8&useUnicode=true&characterEncoding=UTF-8
sharding.jdbc.datasource.ds0.username=dbUsername
sharding.jdbc.datasource.ds0.password=dbPassword

# 定义数据源ds1，配置数据库连接信息
sharding.jdbc.datasource.ds1.type=com.alibaba.druid.pool.DruidDataSource
sharding.jdbc.datasource.ds1.driver-class-name=com.mysql.cj.jdbc.Driver
sharding.jdbc.datasource.ds1.url=jdbc:mysql://127.0.0.1:3306/webasetransaction1?autoReconnect=true&useSSL=false&serverTimezone=GMT%2b8&useUnicode=true&characterEncoding=UTF-8
sharding.jdbc.datasource.ds1.username=dbUsername
sharding.jdbc.datasource.ds1.password=dbPassword

# 定义数据库分片策略，如此处以群组id取模2来路由到ds0或ds1
sharding.jdbc.config.sharding.default-database-strategy.inline.sharding-column=group_id
sharding.jdbc.config.sharding.default-database-strategy.inline.algorithm-expression=ds$->{group_id % 2}

# 定义tb_deploy_transaction的分表策略，如此处以创建时间的年份和自增id取模2来路由到子表
sharding.jdbc.config.sharding.tables.tb_deploy_transaction.actual-data-nodes=ds$->{0..1}.tb_deploy_transaction_$->{2020..2021}_$->{0..1}
sharding.jdbc.config.sharding.tables.tb_deploy_transaction.table-strategy.complex.sharding-columns=id,gmt_create
sharding.jdbc.config.sharding.tables.tb_deploy_transaction.table-strategy.complex.algorithm-class-name=com.webank.webase.transaction.config.MyComplexShardingAlgorithm
sharding.jdbc.config.sharding.tables.tb_deploy_transaction.key-generator-column-name=id

# 定义tb_stateless_transaction的分表策略，如此处以创建时间的年份和自增id取模2来路由到子表
sharding.jdbc.config.sharding.tables.tb_stateless_transaction.actual-data-nodes=ds$->{0..1}.tb_stateless_transaction_$->{2020..2021}_$->{0..1}
sharding.jdbc.config.sharding.tables.tb_stateless_transaction.table-strategy.complex.sharding-columns=id,gmt_create
sharding.jdbc.config.sharding.tables.tb_stateless_transaction.table-strategy.complex.algorithm-class-name=com.webank.webase.transaction.config.MyComplexShardingAlgorithm
sharding.jdbc.config.sharding.tables.tb_stateless_transaction.key-generator-column-name=id

sharding.jdbc.config.props.sql.show=false
```

## 5. 服务启停

返回到dist目录执行：

```shell
启动：bash start.sh
停止：bash stop.sh
检查：bash status.sh
```

**备注**：服务进程起来后，需通过日志确认是否正常启动，出现以下内容表示正常；如果服务出现异常，确认修改配置后，重启提示服务进程在运行，则先执行stop.sh，再执行start.sh。

```
...
	Application() - main run success...
```

## 6. 查看日志

在dist目录查看：

```shell
交易服务日志：tail -f log/transaction.log
web3连接日志：tail -f log/web3sdk.log
```
