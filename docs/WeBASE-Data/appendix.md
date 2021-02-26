# 附录

## 1. 安装示例

<span id="instal"></span>

### 1.1 Java部署

<span id="jdk"></span>

##### CentOS环境安装Java

<span id="centosjava"></span>

**注意：CentOS下OpenJDK无法正常工作，需要安装OracleJDK[下载链接](https://www.oracle.com/technetwork/java/javase/downloads/index.html)。**

```
# 创建新的文件夹，安装Java 8或以上的版本，将下载的jdk放在software目录
# 从Oracle官网(https://www.oracle.com/technetwork/java/javase/downloads/index.html)选择Java 8或以上的版本下载，例如下载jdk-8u201-linux-x64.tar.gz
$ mkdir /software

# 解压jdk
$ tar -zxvf jdk-8u201-linux-x64.tar.gz

# 配置Java环境，编辑/etc/profile文件
$ vim /etc/profile

# 打开以后将下面三句输入到文件里面并保存退出
export JAVA_HOME=/software/jdk-8u201  #这是一个文件目录，非文件
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

# 生效profile
$ source /etc/profile

# 查询Java版本，出现的版本是自己下载的版本，则安装成功。
java -version
```

##### Ubuntu环境安装Java

<span id="ubuntujava"></span>

```
  # 安装默认Java版本(Java 8或以上)
  sudo apt install -y default-jdk
  # 查询Java版本
  java -version
```

### 1.2. 数据库部署

<span id="mysql"></span>

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
mysql > create database webasedata;
```

### 1.3. Elasticsearch部署

<span id="elasticsearch"></span>

此处以Centos安装为例。详情请查看[Elasticsearch官网](<https://www.elastic.co/cn/downloads/elasticsearch>)。

#### ① 安装包下载

下载[elasticsearch](<https://www.elastic.co/cn/downloads/elasticsearch>)和[elasticsearch-analysis-ik](<https://github.com/medcl/elasticsearch-analysis-ik/releases>)，注意版本要对应。

```shell
# 上传elasticsearch安装包并解压
tar -zxvf elasticsearch-7.8.0-linux-x86_64.tar.gz /software/
# 在elasticsearch的plugins目录创建子目录ik，并将ik分词插件上传解压到该目录
mkdir /software/elasticsearch-7.8.0/plugins/ik
# 进入目录
cd /software/elasticsearch-7.8.0/plugins/ik
# 上传ik分词插件安装包并解压
unzip elasticsearch-analysis-ik-7.8.0.zip
```

#### ② 启动

在 ES 根目录下面，执行启动脚本文件：

```
cd /software/elasticsearch-7.8.0
bin/elasticsearch -d
```

如果需要**设置用户名密码访问**，则进行以下操作：

1. 在配置文件中开启x-pack验证, 修改config目录下面的elasticsearch.yml文件，在里面添加如下内容，并**重启**

   ```
   xpack.security.enabled: true
   xpack.license.self_generated.type: basic
   xpack.security.transport.ssl.enabled: true
   ```

2. 设置用户名和密码，需要为4个用户分别设置密码（elastic，kibana，logstash_system，beats_system）

   ```
   bin/elasticsearch-setup-passwords interactive
   ```

3. 如果需要修改密码，命令如下：

   ```
   curl -H "Content-Type:application/json" -XPOST -u elastic 'http://127.0.0.1:9200/_xpack/security/user/elastic/_password' -d '{ "password" : "123456" }'
   ```

#### ③ 验证

打开浏览器，输入 <http://localhost:9200/> 地址，然后可以得到下面的信息：

```shell
{
  "name" : "node-1",
  "cluster_name" : "my-application",
  "cluster_uuid" : "K194HmUgRW2uwE9Zv0IDDQ",
  "version" : {
    "number" : "7.8.0",
    "build_flavor" : "default",
    "build_type" : "tar",
    "build_hash" : "757314695644ea9a1dc2fecd26d1a43856725e65",
    "build_date" : "2020-06-14T19:35:50.234439Z",
    "build_snapshot" : false,
    "lucene_version" : "8.5.1",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
```

#### ④ 停止

查询进程并kill：

```
ps -ef|grep elasticsearch
kill -9 pid
```

### 1.4. Zookeeper部署

<span id="zookeeper"></span>

此处给出简单步骤，供快速查阅。详情请参考[官网](https://zookeeper.apache.org/)。

#### ① 安装包下载

从[官网](https://zookeeper.apache.org/releases.html)下载对应版本的安装包，并解压到相应目录

```shell
mkdir /software
tar -zxvf zookeeper-XXX.tar.gz /software/
```

#### ② 配置和启动

ZooKeeper的安装包括单机模式安装，以及集群模式安装。具体步骤请参考官网说明：

- [集群部署](https://zookeeper.apache.org/doc/r3.4.13/zookeeperAdmin.html#sc_zkMulitServerSetup) 
- [单机部署](https://zookeeper.apache.org/doc/r3.4.13/zookeeperAdmin.html#sc_singleAndDevSetup)

### 1.5 nginx部署

<span id="nginx"></span>

#### ① 安装依赖

在安装nginx前首先要确认系统中安装了gcc、pcre-devel、zlib-devel、openssl-devel。如果没有，请执行命令

```
yum -y install gcc pcre-devel zlib-devel openssl openssl-devel
```

执行命令时注意权限问题，如遇到，请加上sudo

#### ② 安装包下载

nginx下载地址：https://nginx.org/download/（下载最新稳定版本即可），或者使用命令：

```
wget http://nginx.org/download/nginx-1.9.9.tar.gz  (版本号可换)
```

将下载的包移动到/usr/local/下

#### ③ 安装

- 解压后进入目录

```
tar -zxvf nginx-1.9.9.tar.gz
cd nginx-1.9.9
```

- 配置


```
./configure --prefix=/usr/local/nginx
```

- make

```
make
make install
```

- 测试是否安装成功

使用命令：

```
/usr/local/nginx/sbin/nginx –t
```

正常情况的信息输出：

```
nginx: the configuration file /usr/local/nginx/conf/nginx.conf syntax is ok
nginx: configuration file /usr/local/nginx/conf/nginx.conf test is successful
```

- nginx几个常见命令

```shell
/usr/local/nginx/sbin/nginx -s reload            # 重新载入配置文件
/usr/local/nginx/sbin/nginx -s reopen            # 重启 Nginx
/usr/local/nginx/sbin/nginx -s stop              # 停止 Nginx
ps -ef | grep nginx                              # 查看nginx进程
```

## 2. 常见问题

<span id="q&a"></span>

### 2.1 脚本没权限

- 执行shell脚本报错误"permission denied"或格式错误

```
赋权限：chmod + *.sh
转格式：dos2unix *.sh
```

### 2.2 构建失败

- 执行构建命令`gradle build -x test`抛出异常：

```
A problem occurred evaluating root project 'WeBASE-Data-Collect'.
Could not find method compileOnly() for arguments [[org.projectlombok:lombok:1.18.8]] on root project 'WeBASE-Data-Collect'.
```

  答：

方法1、已安装的Gradle版本过低，升级Gradle版本到4.10以上即可
方法2、直接使用命令：`./gradlew build -x test`

### 2.3 数据库问题

- 服务访问数据库抛出异常：

```
The last packet sent successfully to the server was 0 milliseconds ago. The driver has not received any packets from the server.
```

答：检查数据库的网络策略是否开通

```
下面以centos7为例：
查看防火墙是否开放3306端口： firewall-cmd --query-port=3306/tcp
防火墙永久开放3306端口：firewall-cmd --zone=public --add-port=3306/tcp --permanent
重新启动防火墙：firewall-cmd --reload
```

- 执行数据库初始化脚本抛出异常：

```
ERROR 2003 (HY000): Can't connect to MySQL server on '127.0.0.1' (110)
```

答：MySQL没有开通该帐号的远程访问权限，登录MySQL，执行如下命令，其中TestUser改为你的帐号

```
GRANT ALL PRIVILEGES ON *.* TO 'TestUser'@'%' IDENTIFIED BY '此处为TestUser的密码’' WITH GRANT OPTION;
```

- 数据存储时抛出异常：

```
Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.PacketTooBigException: Packet for query is too large (1,048,871 > 1,048,576). You can change this value on the server by setting the 'max_allowed_packet' variable.
```

答：插入数据量过大。MySQL根据配置文件会限制Server接受的数据包大小，有时候插入、更新或查询时数据包的大小，会受 max_allowed_packet 参数限制，导致操作失败。

客户端执行命令查看大小：

```
show VARIABLES like '%max_allowed_packet%';
```

修改mysql的配置文件my.ini的配置，修改后重启mysql：

```
max_allowed_packet=20M
```

### 2.3  Elasticsearch问题

- root账户启动失败

```
org.elasticsearch.bootstrap.StartupException: java.lang.RuntimeException: can not run elasticsearch as root
```

这个错误是因为使用了root账户启动Elasticsearch，换个非root账户启动就可以了。

- 启动没权限

```
-bash: bin/elasticsearch: Permission denied
```

使用`chmod`命令给文件夹赋权限。

- 虚拟内存太小

```
max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]
```

这是因为设置的最大虚拟内存太小，elasticsearch需要较大内存，切换到root用户下，修改配置文件sysctl.conf

```
vi /etc/sysctl.conf
```

添加下面配置：

```
vm.max_map_count=262144
```

并执行命令：

```
sysctl -p
```

- 文件数太小

```
max file descriptors [4096] for elasticsearch process is too low, increase to at least [65536]
```

这是用户最大可创建的文件数太小，只有4096，无法创建本地文件，需要增加到65536。切换到root用户，编辑limits.conf配置文件

```
vi /etc/security/limits.conf
```

添加如下两行，然后保存

```
{启动Elasticsearch的用户} soft nofile 65536
{启动Elasticsearch的用户} hard nofile 65536
```

- 验证时报错

```
{"error":{"root_cause":[{"type":"security_exception","reason":"missing authentication credentials for REST request [/]","header":{"WWW-Authenticate":"Basic realm=\"security\" charset=\"UTF-8\""}}],"type":"security_exception","reason":"missing authentication credentials for REST request [/]","header":{"WWW-Authenticate":"Basic realm=\"security\" charset=\"UTF-8\""}},"status":401}
```

确认是否设置了用户名密码，如果已设置，确认是否正确。

## 3. application.yml配置项说明

### 3.1 WeBASE-Data-Collect

<span id="application-yml-collect"></span>

| 参数                                      | 默认值                                 | 描述                                                 |
| ----------------------------------------- | -------------------------------------- | ---------------------------------------------------- |
| server.port                               | 5009                                   | 当前服务端口                                         |
| server.servlet.context-path               | /WeBASE-Data-Collect                   | 当前服务访问目录                                     |
| mybatis.typeAliasesPackage                | com.webank.webase.data.collect         | mapper类扫描路径                                     |
| mybatis.mapperLocations                   | classpath:mapper/*.xml                 | mybatis的xml路径                                     |
| spring.datasource.driver-class-name       | com.mysql.cj.jdbc.Driver               | mysql驱动                                            |
| spring.datasource.url                     | jdbc:mysql://127.0.0.1:3306/webasedata | mysql连接地址                                        |
| spring.datasource.username                | defaultAccount                         | mysql账号                                            |
| spring.datasource.password                | defaultPassword                        | mysql密码                                            |
| spring.elasticsearch.rest.uris            | 127.0.0.1:9200                         | elasticsearch服务的ip地址                            |
| spring.elasticsearch.rest.username        | elasticAccount                         | elasticsearch用户名，可以为空                        |
| spring.elasticsearch.rest.password        | elasticPassword                        | elasticsearch密码，可以为空                          |
| spring.servlet.multipart.max-request-size | 30MB                                   | 请求资源最大值                                       |
| spring.servlet.multipart.max-file-size    | 20MB                                   | 单个文件最大值                                       |
| constant.ifEsEnable                       | false                                  | 是否使用elasticsearch                                |
| constant.httpTimeOut                      | 5000                                   | 请求前置超时时间                                     |
| constant.maxRequestFail                   | 3                                      | 失败次数                                             |
| constant.sleepWhenHttpMaxFail             | 30000                                  | 失败后睡眠时间（毫秒）                               |
| constant.resetGroupListCycle              | 300000                                 | 更新群组时间间隔（毫秒）                             |
| constant.groupInvalidGrayscaleValue       | 1M                                     | 群组失效后保留时间                                   |
| constant.nodeStatusTaskFixedDelay         | 30000                                  | 更新节点状态任务时间间隔（毫秒）                     |
| constant.statTxnDailyTaskFixedDelay       | 60000                                  | 统计每日交易任务时间间隔（毫秒）                     |
| constant.ifPullData                       | true                                   | 是否拉取区块（可通过接口修改）                       |
| constant.startBlockNumber                 | 0                                      | 开始块                                               |
| constant.crawlBatchUnit                   | 50                                     | 异步处理条数                                         |
| constant.dataPullCron                     | 0/10 * * * * ?                         | 数据拉取任务时间间隔（10秒）                         |
| constant.dataParserCron                   | 5/10 * * * * ?                         | 数据解析任务时间间隔（10秒）                         |
| constant.eventExportCron                  | 7/10 * * * * ?                         | 事件导出任务时间间隔（10秒）                         |
| constant.partitionType                    | 0                                      | 表分区类型（0-按天，1-按月），部署后修改需重建数据库 |
| constant.createPartitionCron              | 0 0 1 * * ?                            | 创建表分区任务时间（每天凌晨1点）                    |
| constant.multiLiving                      | false                                  | 是否使用分布式任务部署多活                           |
| job.regCenter.serverLists                 | 127.0.0.1:2181                         | 部署多活的话需配置zookeeper，支持集群                |
| job.regCenter.namespace                   | elasticjob-collect                     | zookeeper命名空间                                    |
| job.dataflow.shardingTotalCount           | 2                                      | 多活分片数                                           |
| executor.corePoolSize                     | 50                                     | 线程池大小                                           |
| executor.maxPoolSize                      | 100                                    | 线程池最大线程数                                     |
| executor.queueSize                        | 50                                     | 线程池队列大小                                       |
| executor.threadNamePrefix                 | "custom-async-"                        | 线程名前缀                                           |
| logging.config                            | classpath:log/log4j2.xml               | 日志配置文件目                                       |
| logging.level                             | com.webank.webase.data.collect: info   | 日志级别                                             |

### 3.2 WeBASE-Data-Fetcher

<span id="application-yml-fetcher"></span>

| 参数                                | 默认值                                 | 描述                                       |
| ----------------------------------- | -------------------------------------- | ------------------------------------------ |
| server.port                         | 5010                                   | 当前服务端口                               |
| server.servlet.context-path         | /WeBASE-Data-Fetcher                   | 当前服务访问目录                           |
| mybatis.typeAliasesPackage          | com.webank.webase.data.fetcher         | mapper类扫描路径                           |
| mybatis.mapperLocations             | classpath:mapper/*.xml                 | mybatis的xml路径                           |
| spring.datasource.driver-class-name | com.mysql.cj.jdbc.Driver               | mysql驱动                                  |
| spring.datasource.url               | jdbc:mysql://127.0.0.1:3306/webasedata | mysql连接地址                              |
| spring.datasource.username          | defaultAccount                         | mysql账号                                  |
| spring.datasource.password          | defaultPassword                        | mysql密码                                  |
| spring.elasticsearch.rest.uris      | 127.0.0.1:9200                         | elasticsearch服务的ip地址                  |
| spring.elasticsearch.rest.username  | elasticAccount                         | elasticsearch用户名，可以为空              |
| spring.elasticsearch.rest.password  | elasticPassword                        | elasticsearch密码，可以为空                |
| constant.ifEsEnable                 | false                                  | 是否使用elasticsearch                      |
| constant.keywordAuditCron           | 0 0 0/1 * * ?                          | 关键字审计任务执行时间，默认每小时执行一次 |
| executor.corePoolSize               | 50                                     | 线程池大小                                 |
| executor.maxPoolSize                | 100                                    | 线程池最大线程数                           |
| executor.queueSize                  | 50                                     | 线程池队列大小                             |
| executor.threadNamePrefix           | custom-async-                          | 线程名前缀                                 |
| logging.config                      | classpath:log/log4j2.xml               | 日志配置文件目录                           |
| logging.level                       | com.webank.webase.data.fetcher: info   | 日志扫描目录和级别                         |

