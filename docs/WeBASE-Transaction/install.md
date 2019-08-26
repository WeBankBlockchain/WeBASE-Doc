# 部署说明

## 1. 前提条件

| 环境      | 版本                |
| --------- | ------------------- |
| Java      | jdk1.8或以上版本    |
| 数据库    | MySQL-5.6或以上版本 |
| ZooKeeper | ZooKeeper-3.4.10    |

备注：安装说明请参看 [附录-1](./appendix.html#id2)，不使用分布式任务可以不部署ZooKeeper。

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

使用以下方式编译构建，如果出现问题可以查看 [附录-2](./appendix.html#id9)</br>
方式一：如果服务器已安装Gradle，且版本为gradle-4.10或以上

```shell
gradle build -x test
```

方式二：如果服务器未安装Gradle，或者版本不是gradle-4.10或以上，使用gradlew编译

```shell
chmod +x ./gradlew
./gradlew build -x test
```

构建完成后，会在根目录WeBASE-Transaction下生成已编译的代码目录dist。

## 4. 修改配置

（1）进入dist目录

```
cd dist
```

dist目录提供了一份配置模板conf_template：

```
根据配置模板生成一份实际配置conf。初次部署可直接拷贝。
例如：cp conf_template conf -r
```

（2）进入conf目录：

```shell
cd conf
```

**注意：** 需要将节点所在目录`nodes/${ip}/sdk`下的`ca.crt`、`node.crt`和`node.key`文件拷贝到当前conf目录，供SDK与节点建立连接时使用。

（3）修改配置（有注释的地方根据实际情况修改）：

```shell
vi application.yml
```

```
server: 
  # 本工程服务端口，端口被占用则修改
  port: 5003
  context-path: /WeBASE-Transaction

spring: 
  datasource: 
    # 数据库连接信息
    url: jdbc:mysql://127.0.0.1:3306/webasetransaction?serverTimezone=GMT%2B8&useUnicode=true&characterEncoding=utf8
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
  # WeBASE-Sign签名服务ip端口，使用本签名方式则对应修改，使用本地签名的话可以不修改
  signServer: 127.0.0.1:5004
  # 本地配置私钥进行签名，使用本签名方式则对应修改
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

返回到dist目录执行：

```shell
启动：bash start.sh
停止：bash stop.sh
检查：bash status.sh
```

**备注**：如果脚本执行错误，尝试以下命令:

```
赋权限：chmod + *.sh
转格式：dos2unix *.sh
```

## 6. 查看日志

在dist目录查看：

```shell
交易服务日志：tail -f log/transaction.log
web3连接日志：tail -f log/web3sdk.log
```
