# 部署说明

## 1. 前提条件

| 依赖软件 | 支持版本 |
| :-: | :-: |
| Java | JDK8或以上版本 |
| FISCO-BCOS | V2.0.x版本 |

**备注：** Java推荐使用[OpenJDK](./appendix.html#java )，建议从[OpenJDK网站](https://jdk.java.net/java-se-ri/11) 自行下载（CentOS的yum仓库的OpenJDK缺少JCE(Java Cryptography Extension)，导致Web3SDK无法正常连接区块链节点）

### 国密支持

WeBASE-Front v1.2.2+已支持 [国密版FISCO-BCOS](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/manual/guomi_crypto.html)

```eval_rst
.. important::
    使用国密版WeBASE-Front需要开启web3sdk的国密开关和使用国密版solcJ Jar包编译合约
```

开启web3sdk的国密开关:
- web3sdk的国密切换将在启动时自动配置`encryptType`，无需手动设置

使用国密版solcJ jar包进行合约编译：需要编译项目前替换webs3sdk默认使用ethereum的solcJ-0.4.25.jar，具体方法：
1. 下载国密版solcJ的jar包后，放置在项目根目录的`/lib`文件夹中
2. 在`build.gradle`引入web3sdk处通过`exclude`去除ethereum的solcJ jar包
3. 通过`fileTree`引入`/lib`的国密版solcJ的jar包

```
compile ('org.fisco-bcos:web3sdk:2.2.0')
    {
        exclude group:"org.ethereum"
    }
compile fileTree(dir:'lib',includes:['solcJ-all-0.4.25-gm.jar'])
```

下载其他版本或国密版合约编译包则到[下载合约编译jar包](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/manual/console.html#jar)下载


## 2. 拉取代码
执行命令：
```
git clone https://github.com/WeBankFinTech/WeBASE-Front.git
```

进入目录：

```
cd WeBASE-Front
```

## 3. 编译代码

使用以下方式编译构建，如果出现问题可以查看 [常见问题解答](./appendix.html#id6) ：

方式一：如果服务器已安装Gradle，且版本为Gradle-4.10或以上

```shell
gradle build -x test
```

方式二：如果服务器未安装Gradle，或者版本不是Gradle-4.10或以上，使用gradlew编译

```shell
chmod +x ./gradlew && ./gradlew build -x test
```

构建完成后，会在根目录WeBASE-Front下生成已编译的代码目录dist。

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

（3）修改配置（根据实际情况修改）：

```
vi application.yml
```

``` 
spring:
  datasource:
    url: jdbc:h2:file:./h2/webasefront;DB_CLOSE_ON_EXIT=FALSE // 默认H2库为webasefront，建议修改数据库存放路径
...
server: 
  port: 5003                    // 服务端口
  context-path: /WeBASE-Front
sdk: 
  ...
  ip: 127.0.0.1                 // 连接节点的监听ip
  channelPort: 20200            // 连接节点的链上链下端口
constant: 
  keyServer: 127.0.0.1:5001     // 密钥服务的IP和端口(WeBASE-Node-Manager服务或者WeBASE-Sign服务，不同服务支持的接口不同)，如果作为独立控制台使用可以不配置
  transMaxWait: 30              // 交易最大等待时间
  monitorDisk: /                // 要监控的磁盘目录，配置节点所在目录（如：/data）
  monitorEnabled: true          // 是否监控数据，默认true
  aesKey: EfdsW23D23d3df43          // aes加密key(16位) 如启用，各互联的子系统的加密key需保持一致
  nodePath: /fisco/nodes/127.0.0.1/node0      //配置连接节点的绝对路径
...
```

## 5. 服务启停

返回到dist目录执行：
```shell
启动: bash start.sh
停止: bash stop.sh
检查: bash status.sh
```
**备注**：服务进程起来后，需通过日志确认是否正常启动，出现以下内容表示正常；如果服务出现异常，确认修改配置后，重启提示服务进程在运行，则先执行stop.sh，再执行start.sh。

```
...
	Application() - main run success...
```

## 6. 访问控制台

```
http://{deployIP}:{frontPort}/WeBASE-Front
示例：http://localhost:5002/WeBASE-Front
```

- 部署服务器IP和服务端口需对应修改，网络策略需开通
- 基于可视化控制台，可以开发智能合约，部署合约和发送交易，并查看交易和区块详情。还可以管理私钥，对节点健康度进行监控和统计

## 7. 查看日志

在dist目录查看：

```
前置服务日志：tail -f log/WeBASE-Front.log
web3连接日志：tail -f log/web3sdk.log
```