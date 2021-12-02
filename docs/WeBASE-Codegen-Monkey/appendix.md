## 附录

### 1. 配置参数说明

WeBASE-Codegen-Monkey用于生成[WeBASE-Collect-Bee](https://github.com/WeBankBlockchain/WeBASE-Collect-Bee/tree/master)组件实例，在WeBASE-Codegen-Monkey组件中配置文件只有一个：application.properties。该配置文件覆盖了数据导出组件所需的所有配置，并提供了详细的说明和样例，开发者可根据需求进行灵活配置。

#### 1.1 Springboot服务配置

| 配置项 | 是否必输 | 说明 | 举例 | 默认值 |
| --- | --- | --- | --- | --- |
| server.port | N | 启动WeBASE-Collect-Bee组件实例的服务端口 | 8082 | 5200 |

#### 1.2 FISCO-BCOS节点配置

FISCO-BCOS节点配置用于配置[WeBASE-Collect-Bee](https://github.com/WeBankBlockchain/WeBASE-Collect-Bee/tree/master)服务连接的区块链节点，使得WeBASE-Collect-Bee服务能够访问连接节点，并通过该节点获取区块链网络上的数据。

| 配置项 | 是否必输 | 说明 | 举例 | 默认值 |
| --- | --- | --- | --- | --- |
| system.nodeStr | Y | 连接区块链节点的nodeStr，nodeName@[IP]:[PORT], 其中prot为channel port | node1@ip:8822 | - |
| system.encryptType | N | 加密类型： 0-RSA, 1-gm | 0 | 0 |


#### 1.3 数据库配置

数据导出组件最终会把区块链网络上的数据导出到数据存储介质中，目前版本仅支持MySQL，所以需要进行数据库配置。

| 配置项 | 是否必输 | 说明 | 举例 | 默认值 |
| --- | --- | --- | --- | --- |
| system.dbUrl | Y | 访问数据的URL | jdbc:mysql://[IP]:[PORT]/[DB]?useSSL=false&serverTimezone=Asia/Shanghai&useUnicode=true&characterEncoding=UTF-8 | - |
| system.dbUser | Y | 数据库用户名 | admin | - |
| system.dbPassword | Y | 数据库密码 | 123456 | - |
| system.contractName.[methodName or eventName].shardingNO | N | 合约数据分片数：数据库指定数据表的个数 | system.Rule.NewruleEvent.shardingNO = 3 | 1 |
| system.sys.[sysTableName].shardingNO | N | 系统数据分片数 | system.sys.BlockTxDetailInfo.shardingNO=5 | 1 |
| system.nameStyle | N | 数据库表名和字段命名规则，支持下划线命名和原始数据命名 | system.nameStyle=rawCase | underScoreCase |
| system.namePrefix | N | 数据库表字段命名前缀，默认为_ | system.namePrefix=_ | _ |
| system.namePostfix | N | 数据库表字段命名后缀，默认为空 | system.namePostfix=_ | 空 |
| system.tablePrefix | N | 数据库表名命名前缀，默认为空 | system.tablePrefix=_ | 空 |
| system.tablePostfix | N | 数据库表名命名后缀，默认为空 | system.tablePostfix=_ | 空 |
| system.dbIdentifierSplit | N | 是否开启自动裁剪过长的数据库表名，默认为false | system.dbIdentifierSplit=true | false |


其中**sysTableName**对应区块数据表和账户数据表，详情见 **数据存储模型** 章节。

#### 1.4 FISCO-WeBASE-Collect-Bee工程配置

| 配置项 | 是否必输 | 说明 | 举例 | 默认值 |
| --- | --- | --- | --- | --- |
| system.group | Y | 同spring项目的group | com.example | - |
| system.contractPackName | Y | 编译智能合约所输入的包名 | com.webank.blockchain.wecredit.contracts | - |
| system.frequency | N | 所有method和event的抓取频率，默认几秒轮询一次 | 10 | 5 |

#### 1.5 线程池配置

在单机部署下，必须配置线程池参数。数据导出配置用于配置数据导出的频率、线程数及启动多线程条件等。当system.multiLiving=true时，配置文件不会生成线程池相关配置。

| 配置项 | 是否必输 | 说明 | 举例 | 默认值 |
| --- | --- | --- | --- | --- |
| system.multiLiving | Y | 关闭多活开关 | false | false |
| system.crawlBatchUnit | N | 线程处理单元：多线程任务模式下单个线程一次任务执行完成的区块数 | 100 | 100 |

#### 1.6 集群多活配置

在集群多活部署的方案中，必须设置集群多活的配置。集群必须通过zookeeper进行服务注册和任务分发。当system.multiLiving=false时，配置文件不会生成zookeeper相关配置。

| 配置项 | 是否必输 | 说明 | 举例 | 默认值 |
| --- | --- | --- | --- | --- |
| system.multiLiving | Y | 启动多活开关 | true | false |
| regcenter.serverList | N | 注册中心服务器列表 | [ip1:2181;ip2:2181] | - |
| regcenter.namespace | N | 注册中心命名空间 | wecredit_bee | - |


#### 1.7 其他高级配置

| 配置项 | 是否必输 | 说明 | 举例 | 默认值 |
| --- | --- | --- | --- | --- |
| monitor.[contractName].[methodName/eventName].generated=false | N | 是否抓取特定合约中特定method或event的数据 | on/off | on |
| monitor.[contractName].[eventName].ignoreParam=XXX,XXX | N | 忽略特定合约特定event的特定字段不进行抓取 | xxx,xxx |  |
| length.[contractName].[methodName or eventName].paraName | N | 指定特定字段在数据库表中的长度 |  | 512 |
| button.swagger | N | 是否打开swagger功能，请务必在生成环境关闭此开关 | on/off | on |

### 2. Java安装

#### Ubuntu环境安装Java

```
# 安装默认Java版本(Java 8或以上)
sudo apt install -y default-jdk
# 查询Java版本
java -version 
```

#### CentOS环境安装Java

```
# 查询centos原有的Java版本
$ rpm -qa|grep java
# 删除查询到的Java版本
$ rpm -e --nodeps java版本
# 查询Java版本，没有出现版本号则删除完毕
$ java -version
# 创建新的文件夹，安装Java 8或以上的版本，将下载的jdk放在software目录
# 从openJDK官网(https://jdk.java.net/java-se-ri/8)或Oracle官网(https://www.oracle.com/technetwork/java/javase/downloads/index.html)选择Java 8或以上的版本下载，例如下载jdk-8u201-linux-x64.tar.gz
$ mkdir /software
# 解压jdk 
$ tar -zxvf jdk-8u201-linux-x64.tar.gz
# 配置Java环境，编辑/etc/profile文件 
$ vim /etc/profile 
# 打开以后将下面三句输入到文件里面并退出
export JAVA_HOME=/software/jdk-8u201-linux-x64.tar.gz
export PATH=$JAVA_HOME/bin:$PATH 
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
# 生效profile
$ source /etc/profile 
# 查询Java版本，出现的版本是自己下载的版本，则安装成功。
java -version 
```

### 3. Git安装

git：用于拉取最新代码

**centos**:
```
sudo yum -y install git
```

**ubuntu**:
```
sudo apt install git
```

### 4. Mysql安装

此处以Centos安装MariaDB为例。MariaDB数据库是 MySQL 的一个分支，主要由开源社区在维护，采用 GPL 授权许可。MariaDB完全兼容 MySQL，包括API和命令行。其他安装方式请参考[MySQL官网](https://dev.mysql.com/downloads/mysql/)。

（1）安装MariaDB

- 安装命令

```shell
sudo yum install -y mariadb*
```

（2）启停

```shell
启动：sudo systemctl start mariadb.service
停止：sudo systemctl stop  mariadb.service
```

（3）设置开机启动

```
sudo systemctl enable mariadb.service
```

（4）初始化root用户

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

- 使用root用户登录，密码为初始化设置的密码

```
mysql -uroot -p -h localhost -P 3306
```

- 授权root用户远程访问

  **注意，以下语句仅适用于开发环境，不能直接在实际生产中使用！！！ 以下操作仅供参考，请勿直接拷贝，请自定义设置复杂密码。**

```sql
mysql > GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;
mysql > flush PRIVILEGES;
```

  **安全温馨提示：**

- 例子中给出的数据库密码（123456）仅为样例，强烈建议设置成复杂密码
- 例子中root用户的远程授权设置会使数据库在所有网络上都可以访问，请按具体的网络拓扑和权限控制情况，设置网络和权限帐号

（5）创建test用户并授权本地访问

```sql
mysql > GRANT ALL PRIVILEGES ON *.* TO 'test'@localhost IDENTIFIED BY '123456' WITH GRANT OPTION;
mysql > flush PRIVILEGES;
```

（6）测试是否成功

- 登录数据库

```shell
mysql -utest -p123456 -h localhost -P 3306
```

- 创建数据库

```sql
mysql > create database webasebee;
mysql > use webasebee;

```

  **以上语句仅适用于开发环境，不能直接在实际生产中使用！！！以上设置会使数据库在所有网络上都可以访问，请按具体的网络拓扑和权限控制情况，设置网络和权限帐号**
  
### 5. zookeeper 安装
zookeeper 支持单机和集群部署，推荐使用集群部署的方式，请参考zookeeper官网的说明：

[集群部署](https://zookeeper.apache.org/doc/r3.4.13/zookeeperAdmin.html#sc_zkMulitServerSetup)

[单机部署](https://zookeeper.apache.org/doc/r3.4.13/zookeeperAdmin.html#sc_singleAndDevSetup)

### 6. supervisor安装与部署

##### 安装脚本
> sudo yum -y install supervisor

会生成默认配置/etc/supervisord.conf和目录/etc/supervisord.d，如果没有则自行创建。

##### 配置脚本
cd /etc/supervisord.d
修改/etc/supervisord.conf的[include]部分：

```shell
[include]
files = supervisord.d/*.ini
[supervisord]
```

在/etc/supervisord.d目录下配置以下启动配置文件webasebee_config1.ini（请注意配置文件里需要包含webasebee，否则会导致关闭任务命令失效），注意修改相关的路径。
```shell
[program:supervisor_webasebee]
directory =【你的程序路径】/WeBASE-Collect-Bee/dist ; 程序的启动目录
command = nohup java -jar 【你的安装包名，如WeBASE-Collect-Bee0.3.0-SNAPSHOT.jar】 & ; 启动命令，与命令行启动的命令是一样的
autostart = true     ; 在 supervisord 启动的时候也自动启动
startsecs = 15        ; 启动 15 秒后没有异常退出，就当作已经正常启动了
autorestart = true   ; 程序异常退出后自动重启
startretries = 3     ; 启动失败自动重试次数，默认是 3
user = app          ; 用哪个用户启动
redirect_stderr = true  ; 把 stderr 重定向到 stdout，默认 false
stdout_logfile_maxbytes = 150MB  ; stdout 日志文件大小，默认 50MB
stdout_logfile_backups = 20     ; stdout 日志文件备份数
stderr_logfile=【你的日志路径】/WeBASE-Collect-Bee/dist/log/webase_bee_error.log
stdout_logfile = 【你的日志路径】/WeBASE-Collect-Bee/dist/log/webase_bee_out.log  ;日志统一放在log目录下
[supervisord]
```

##### 启动任务
supervisor支持supervisorctl和supervisord启动，可通过systemctl实现开机自启动。
我们建议采用supervisord的方式启动：

```shell
supervisord -c /etc/supervisord.d/webasebee_config1.ini
```

##### 关闭任务
```shell
ps -ef|grep supervisord|grep webasebee| awk '{print $2}'|xargs kill -9
ps -ef|grep WeBASE-Collect-Bee|grep -v grep| awk '{print $2}'|xargs kill -9
```

### 7. 常见问题

#### 7.1 脚本没权限

- 执行shell脚本报错误"permission denied"或格式错误

```
赋权限：chmod + *.sh
转格式：dos2unix *.sh
```
