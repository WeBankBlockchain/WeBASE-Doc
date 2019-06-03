# 交易服务子系统说明

# 目录
> * [功能说明](#chapter-1)
> * [前提条件](#chapter-2)
> * [部署说明](#chapter-3)
> * [接口说明](#chapter-4)
> * [附录](#chapter-5)

# 1. <a id="chapter-1"></a>功能说明

本工程为交易服务子系统。功能：合约编译；交易请求处理，交易分为合约部署和普通的合约调用请求。<br>

合约编译：上传合约文件zip压缩包（压缩包里的每个合约的文件名要和合约名一致，合约引用需使用“./xxx.sol”），返回合约编译信息。<br>

合约部署：交易服务子系统会将合约部署请求信息缓存到数据库，通过轮询服务向节点发送交易请求，确保合约成功部署。<br>

合约调用：分为无状态交易上链（非constant方法）和交易结果查询（constant方法）。<br>
无状态交易上链是交易服务子系统会将交易请求信息缓存到数据库，通过轮询服务向节点发送交易请求，确保交易成功上链。<br>
交易结果查询是交易服务子系统会同步向节点发送交易请求，返回结果。<br>

无状态交易上链数据签名支持以下模式：<br>
1、本地配置私钥签名<br>
2、本地随机私钥签名<br>
3、调用签名服务签名<br>

本工程支持单机部署，也支持分布式任务多活部署（使用分布式任务的话需部署zookeeper）。<br>

# 2. <a id="chapter-2"></a>前提条件

| 环境     | 版本              |
| ------ | --------------- |
| Java   | jdk1.8.0_121或以上版本    |
| 数据库    | mysql-5.6或以上版本  |
| zookeeper | zookeeper-3.4.10或以上版本 |
备注：安装说明请参看附录，不使用分布式任务可以不部署zookeeper。

# 3. <a id="chapter-3"></a>部署说明

## 3.1 拉取代码
执行命令：
```
git clone https://github.com/WeBankFinTech/webase-transaction.git
```

## 3.2 编译代码

在代码的根目录webase-transcation编译，如果出现问题可以查看[常见问题解答](install_FAQ.md)</br>
方式一：如果服务器已安装gradle，且版本为gradle-4.10或以上
```shell
gradle build -x test
```
方式二：如果服务器未安装gradle，或者版本不是gradle-4.10或以上，使用gradlew编译
```shell
./gradlew build -x test
```
构建完成后，会在根目录webase-transcation下生成已编译的代码目录dist。

## 3.3 修改配置

（1）进入目录：
```shell
cd dist/conf
```
**将节点sdk目录下的以下文件复制到当前目录：**
ca.crt、node.crt、node.key


（2）以下有注释的地方根据实际情况修改：
```shell
vi application.yml
```

```
server: 
  # 本工程服务端口，端口被占用则修改
  port: 8082
  context-path: /webase-transaction

spring: 
  datasource: 
    # 数据库连接信息
    url: jdbc:mysql://127.0.0.1:3306/testdb?useUnicode=true&characterEncoding=utf8
    # 数据库用户名
    username: root
    # 数据库密码
    password: 123456
    driver-class-name: com.mysql.jdbc.Driver

sdk:
  # 机构名
  orgName: webank
  timeout: 10000
  # 群组信息，可配置多群组和多节点
  groupConfig:
    allChannelConnections:
    - groupId: 1
      connectionsStr:
      - 127.0.0.1:20200
      - 127.0.0.1:20201
    - groupId: 2
      connectionsStr:
      - 127.0.0.1:20200
      - 127.0.0.1:20201

constant: 
  # 签名服务url，需要调用签名服务进行签名的话则对应修改，使用本地签名的话可以不修改
  signServiceUrl: http://127.0.0.1:8085/webase-sign/sign
  # 本地配置私钥进行签名，使用这种模式则对应修改
  privateKey: edf02a4a69b14ee6b1650a95de71d5f50496ef62ae4213026bd8d6651d030995
  cronTrans: 0/1 * * * * ?
  requestCountMax: 6
  selectCount: 10
  intervalTime: 600
  sleepTime: 50
  # 使用分布式任务部署多活（true-是，false-否）
  ifDistributedTask: false

job:
  regCenter:  
    # 部署多活的话需配置zookeeper，支持集群
    serverLists: 127.0.0.1:2181
    namespace: elasticjob-trans
  dataflow:  
    # 分片数（如多活3个的话可分成3片）
    shardingTotalCount: 3
```

## 3.4 服务启停
进入到已编译的代码根目录：
```shell
cd dist
```
```shell
启动：sh start.sh
停止：sh stop.sh
检查：sh status.sh
```
**备注**：如果脚本执行错误，尝试以下命令:
```
赋权限：chmod + *.sh
转格式：dos2unix *.sh
```

## 3.5 查看日志

进入到已编译的代码根目录：
```shell
cd dist
```

查看
```shell
tail -f log/webase-transcation.log
```
# 4. <a id="chapter-4"></a>接口说明

- [接口说明请点击](interface.md)


# 5. <a id="chapter-5"></a>附录

## 5.1 Java环境部署

此处给出简单步骤，供快速查阅。详情请参考[官网](http://www.oracle.com/technetwork/java/javase/downloads/index.html)。

（1）从[官网](http://www.oracle.com/technetwork/java/javase/downloads/index.html)下载对应版本的java安装包，并解压到相应目录

```shell
mkdir /software
tar -zxvf jdkXXX.tar.gz /software/
```

（2）配置环境变量

```shell
export JAVA_HOME=/software/jdk1.8.0_121
export PATH=$JAVA_HOME/bin:$PATH 
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
```

## 5.2 数据库部署

此处以Centos/Fedora为例。

（1）切换到root

```shell
sudo -s
```

（2）安装mysql

```shell
yum install mysql*
#某些版本的linux，需要安装mariadb，mariadb是mysql的一个分支
yum install mariadb*
```

（3）启动mysql

```shell
service mysqld start
#若安装了mariadb，则使用下面的命令启动
systemctl start mariadb.service
```

（4）初始化数据库用户

初次登录
```shell
mysql -u root
```

给root设置密码和授权远程访问
```sql
mysql > SET PASSWORD FOR 'root'@'localhost' = PASSWORD('123456');
mysql > GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;
```

**安全温馨提示：**

1. 例子中给出的数据库密码（123456）仅为样例，强烈建议设置成复杂密码
2. 例子中的远程授权设置会使数据库在所有网络上都可以访问，请按具体的网络拓扑和权限控制情况，设置网络和权限帐号

授权test用户本地访问数据库
```sql
mysql > create user 'test'@'localhost' identified by 'test1234';
```

（5）测试连接

另开一个ssh测试本地用户test是否可以登录数据库

```shell
mysql -utest -ptest1234 -h 127.0.0.1 -P 3306
```

登陆成功后，执行以下sql语句，若出现错误，则用户授权不成功

```sql
mysql > show databases;
mysql > use test;
```
（6）创建数据库

登录数据库

```shell
mysql -utest -ptest1234 -h 127.0.0.1 -P 3306
```

创建数据库

```sql
mysql > create database testdb;
```

## 5.3 Zookeeper环境部署

此处给出简单步骤，供快速查阅。详情请参考[官网](https://zookeeper.apache.org/)。

（1）从[官网](https://zookeeper.apache.org/releases.html)下载对应版本的安装包，并解压到相应目录

```shell
mkdir /software
tar -zxvf zookeeper-XXX.tar.gz /software/
```

（2）配置和启动

ZooKeeper的安装包括单机模式安装，以及集群模式安装。具体步骤请上网查询。
