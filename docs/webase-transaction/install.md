# 部署说明

## 1. 前提条件

| 环境      | 版本                       |
| --------- | -------------------------- |
| Java      | jdk1.8.0_121或以上版本     |
| 数据库    | mysql-5.6或以上版本        |
| zookeeper | zookeeper-3.4.10或以上版本 |

备注：安装说明请参看 [附录-1](./appendix.html#id2)，不使用分布式任务可以不部署zookeeper。

## 2. 拉取代码

执行命令：

```
git clone https://github.com/WeBankFinTech/WeBASE-Transaction.git
```

进入目录：

```
cd WeBASE-Transaction
```

## 3. 编译代码

使用以下方式编译构建，如果出现问题可以查看 [附录-2](./appendix.html#id4)</br>
方式一：如果服务器已安装gradle，且版本为gradle-4.10或以上

```shell
gradle build -x test
```

方式二：如果服务器未安装gradle，或者版本不是gradle-4.10或以上，使用gradlew编译

```shell
./gradlew build -x test
```

构建完成后，会在根目录WeBASE-Transaction下生成已编译的代码目录dist。

## 4. 修改配置

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
    url: jdbc:mysql://127.0.0.1:3306/db_transaction?useUnicode=true&characterEncoding=utf8
    # 数据库用户名
    username: dbUsername
    # 数据库密码
    password: dbPassword
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

## 5. 服务启停

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

## 6. 查看日志

在已编译的代码根目录dist查看：

```shell
交易服务日志：tail -f log/transcation.log
web3连接日志：tail -f log/web3sdk.log
```
