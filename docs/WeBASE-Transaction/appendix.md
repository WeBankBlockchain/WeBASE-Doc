# 附录

## 1. 安装问题

### 1.1 Java部署

此处给出OpenJDK安装简单步骤，供快速查阅。更详细的步骤，请参考[官网](https://openjdk.java.net/install/index.html)。

#### ① 安装包下载

从[官网](https://jdk.java.net/java-se-ri/11)下载对应版本的java安装包，并解压到服务器相关目录

```shell
mkdir /software
tar -zxvf openjdkXXX.tar.gz /software/
```

#### ② 配置环境变量

- 修改/etc/profile

```
sudo vi /etc/profile
```

- 在/etc/profile末尾添加以下信息

```shell
JAVA_HOME=/software/jdk-11
PATH=$PATH:$JAVA_HOME/bin
CLASSPATH==.:$JAVA_HOME/lib
export JAVA_HOME CLASSPATH PATH
```

- 重载/etc/profile

```
source /etc/profile
```

#### ③ 查看版本

```
java -version
```

### 1.2. 数据库部署

此处以Centos安装*MariaDB*为例。*MariaDB*数据库是 MySQL 的一个分支，主要由开源社区在维护，采用 GPL 授权许可。*MariaDB*完全兼容 MySQL，包括API和命令行。其他安装方式请参考[MySQL官网](https://dev.mysql.com/downloads/mysql/)。

#### ① 安装MariaDB

- 安装命令

```shell
sudo yum install -y mariadb*
```

- 启停

```shell
启动：sudo systemctl start mariadb.service
停止：sudo systemctl stop  mariadb.service
```

- 设置开机启动

```
sudo systemctl enable mariadb.service
```

- 初始化

```shell
执行以下命令：
sudo mysql_secure_installation
以下根据提示输入：
Enter current password for root (enter for none):<–初次运行直接回车
Set root password? [Y/n] <– 是否设置root用户密码，输入y并回车或直接回车
New password: <– 设置root用户的密码
Re-enter new password: <– 再输入一次你设置的密码
Remove anonymous users? [Y/n] <– 是否删除匿名用户，回车
Disallow root login remotely? [Y/n] <–是否禁止root远程登录，回车
Remove test database and access to it? [Y/n] <– 是否删除test数据库，回车
Reload privilege tables now? [Y/n] <– 是否重新加载权限表，回车
```

#### ② 授权访问和添加用户

- 使用root用户登录，密码为初始化设置的密码

```
mysql -uroot -p -h localhost -P 3306
```

- 授权root用户远程访问

```sql
mysql > GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;
mysql > flush PRIVILEGES;
```

- 创建test用户并授权本地访问

```sql
mysql > GRANT ALL PRIVILEGES ON *.* TO 'test'@localhost IDENTIFIED BY '123456' WITH GRANT OPTION;
mysql > flush PRIVILEGES;
```

**安全温馨提示：**

- 例子中给出的数据库密码（123456）仅为样例，强烈建议设置成复杂密码
- 例子中root用户的远程授权设置会使数据库在所有网络上都可以访问，请按具体的网络拓扑和权限控制情况，设置网络和权限帐号

#### ③ 测试连接和创建数据库

- 登录数据库

```shell
mysql -utest -p123456 -h localhost -P 3306
```

- 创建数据库

```sql
mysql > create database webasetransaction;
```

### 1.3. Zookeeper部署

此处给出简单步骤，供快速查阅。详情请参考[官网](https://zookeeper.apache.org/)。

（1）从[官网](https://zookeeper.apache.org/releases.html)下载对应版本的安装包，并解压到相应目录

```shell
mkdir /software
tar -zxvf zookeeper-XXX.tar.gz /software/
```

（2）配置和启动

ZooKeeper的安装包括单机模式安装，以及集群模式安装。具体步骤请参考官网说明：

- [集群部署](https://zookeeper.apache.org/doc/r3.4.13/zookeeperAdmin.html#sc_zkMulitServerSetup) 
- [单机部署](https://zookeeper.apache.org/doc/r3.4.13/zookeeperAdmin.html#sc_singleAndDevSetup)

## 2. 常见问题

### 2.1 脚本没权限

执行shell脚本报错误"permission denied"或格式错误

```
赋权限：chmod + *.sh
转格式：dos2unix *.sh
```

### 2.2 构建失败

“gradle build -x test”失败，不能编译Lombok注解：

```
...
/data/trans/webase-transcation/src/main/java/com/webank/webase/transaction/trans/TransService.java:175: error: cannot find symbol
                        log.warn("save fail. contract is not deploed", contractAddress);
                        ^
  symbol:   variable log
  location: class TransService
/data/trans/webase-transcation/src/main/java/com/webank/webase/transaction/trans/TransService.java:183: error: cannot find symbol
                                log.warn("call fail. contractAddress:{} abi is not exists", contractAddress);
                                ^
  symbol:   variable log
  location: class TransService
Note: /data/trans/webase-transcation/src/main/java/com/webank/webase/transaction/util/ContractAbiUtil.java uses unchecked or unsafe operations.
Note: Recompile with -Xlint:unchecked for details.
100 errors

FAILURE: Build failed with an exception.
...
```

  答： 修改 build.gradle文件，将以下代码的注释去掉

```
 //annotationProcessor 'org.projectlombok:lombok:1.18.2'
```

### 2.3 启动报错“nested exception is javax.net.ssl.SSLException”

```
...
nested exception is javax.net.ssl.SSLException: Failed to initialize the client-side SSLContext: Input stream not contain valid certificates.
```

答：CentOS的yum仓库的OpenJDK缺少JCE(Java Cryptography Extension)，导致Web3SDK无法正常连接区块链节点，因此在使用CentOS操作系统时，推荐从[OpenJDK网站](https://jdk.java.net/java-se-ri/11)自行下载。

### 2.4 启动报错“Processing bcos message timeout”

```
 [main] ERROR SpringApplication() - Application startup failed
org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'scheduleService': Unsatisfied dependency expressed through field 'transService'; nested exception is org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'transService': Unsatisfied dependency expressed through field 'web3jMap'; nested exception is org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'web3j' defined in class path resource [com/webank/webase/transaction/config/Web3Config.class]: Bean instantiation via factory method failed; nested exception is org.springframework.beans.BeanInstantiationException: Failed to instantiate [java.util.HashMap]: Factory method 'web3j' threw exception; nested exception is java.io.IOException: Processing bcos message timeout
```

答：一些Oracle JDK版本缺少相关包，导致节点连接异常。推荐使用OpenJDK，从[OpenJDK网站](https://jdk.java.net/java-se-ri/11)自行下载。

## 3. application.properties配置项说明

| 配置项                                                       | 说明                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| server.port                                                  | 工程服务端口                                                 |
| server.context-path                                          | 工程跟URI                                                    |
| mybatis.mapper-locations                                     | mapper路径                                                   |
| logging.config                                               | 日志文件路径                                                 |
| sdk.orgName                                                  | 机构名                                                       |
| sdk.timeout                                                  | sdk连接超时时间                                              |
| sdk.corePoolSize                                             | sdk线程池配置                                                |
| sdk.maxPoolSize                                              | sdk线程池配置                                                |
| sdk.queueCapacity                                            | sdk线程池配置                                                |
| sdk.keepAlive                                                | sdk线程池配置                                                |
| sdk.groupConfig.allChannelConnections[0].groupId             | sdk连接的群组id                                              |
| sdk.groupConfig.allChannelConnections[0].connectionsStr[0]   | sdk连接的节点的ip和channelPort                               |
| constant.signServer                                          | WeBASE-Sign签名服务ip端口                                    |
| constant.privateKey                                          | 本地配置私钥                                                 |
| constant.cronTrans                                           | 轮询上链时间间隔                                             |
| constant.requestCountMax                                     | 重复请求上链最大次数                                         |
| constant.selectCount                                         | 每次查询未上链数据条数                                       |
| constant.intervalTime                                        | 未上链数据查询时间间隔                                       |
| constant.sleepTime                                           | 多线程时间间隔                                               |
| constant.ifDeleteData                                        | 是否删除数据                                                 |
| constant.cronDeleteData                                      | 删除数据任务时间间隔                                         |
| constant.keepDays                                            | 数据保留天数                                                 |
| constant.ifDistributedTask                                   | 是否使用分布式任务部署多活                                   |
| job.regCenter.serverLists                                    | 部署多活的话需配置zookeeper，支持集群                        |
| job.regCenter.namespace                                      | zookeeper命名空间                                            |
| job.dataflow.shardingTotalCount                              | 分片数                                                       |
| sharding.jdbc.datasource.names                               | 配置所有的数据源，对应多个数据库                             |
| sharding.jdbc.datasource.ds0.type                            | 数据连接池类型                                               |
| sharding.jdbc.datasource.ds0.driver-class-name               | 数据驱动                                                     |
| sharding.jdbc.datasource.ds0.url                             | 数据库连接url                                                |
| sharding.jdbc.datasource.ds0.username                        | 数据库用户名                                                 |
| sharding.jdbc.datasource.ds0.password                        | 数据库密码                                                   |
| sharding.jdbc.config.sharding.default-database-strategy.inline.sharding-column | 数据库分片列                                                 |
| sharding.jdbc.config.sharding.default-database-strategy.inline.algorithm-expression | 分片算法行表达式，需符合groovy语法                           |
| sharding.jdbc.config.sharding.tables.tb_deploy_transaction.actual-data-nodes | 由数据源名 + 表名组成，以小数点分隔                          |
| sharding.jdbc.config.sharding.tables.tb_deploy_transaction.table-strategy.complex.sharding-columns | 复合分片场景的分片列名称，多个列以逗号分隔                   |
| sharding.jdbc.config.sharding.tables.tb_deploy_transaction.table-strategy.complex.algorithm-class-name | 复合分片算法类名称。该类需实现ComplexKeysShardingAlgorithm接口 |
| sharding.jdbc.config.sharding.tables.tb_deploy_transaction.key-generator-column-name | 自增列名称                                                   |
| sharding.jdbc.config.props.sql.show                          | 是否开启SQL显示                                              |

