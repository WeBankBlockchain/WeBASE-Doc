# 部署说明

## 1. 前提条件

| 依赖软件 | 支持版本 |
| :-: | :-: |
| Java | JDK 8 至 14 |
| FISCO-BCOS | v2.0.0及以上版本 |

**备注：** Java推荐使用[OracleJDK](https://www.oracle.com/technetwork/java/javase/downloads/index.html)，可参考[JDK配置指引](./appendix.html#jdk)（CentOS的yum仓库的OpenJDK缺少JCE(Java Cryptography Extension)，导致Web3SDK无法正常连接区块链节点）

```eval_rst
.. important::
    FISCO-BCOS 2.0与3.0对比、JDK版本、WeBASE及其他子系统的版本兼容说明！`请查看 <https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/compatibility.html>`_
```

#### 国密支持

WeBASE-Front v1.2.2+已支持 [国密版FISCO-BCOS](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/manual/guomi_crypto.html)
- 在v1.5.0后，sdk将自动根据链的加密类型切换国密或非国密，自动根据链的SSL类型切换国密SSL

<span id="solc6"></span>
#### solidity v0.6.10支持

WeBASE-Front v1.4.2已支持solidity `v0.5.1`和`v0.6.10`

#### solidity v0.8.11支持

WeBASE-Front v3.0.1已支持solidity `v0.8.11`

#### Liquid支持

如果使用的`liquid`合约的链并在WeBASE-Front的合约IDE中编译Liquid合约，要求**手动**在WeBASE-Front所在主机[配置Liquid环境](https://liquid-doc.readthedocs.io/zh_CN/latest/docs/quickstart/prerequisite.html)

配置好Liquid环境后，需要重启WeBASE-Front


## 2. 拉取代码
执行命令：
```shell
git clone -b master-3.0 https://github.com/WeBankBlockchain/WeBASE-Front.git

# 若因网络问题导致长时间下载失败，可尝试以下命令
git clone -b master-3.0 https://gitee.com/WeBank/WeBASE-Front.git
```

进入目录：

```
cd WeBASE-Front
```

## 3. 编译代码

使用以下方式编译构建，如果出现问题可以查看 [常见问题解答](./appendix.html#id6) ：

方式一：如果服务器已安装Gradle，且版本为gradle-4.10至gradle-6.x版本

```shell
gradle build -x test
```

方式二：如果服务器未安装Gradle，或者版本不是gradle-4.10至gradle-6.x版本，使用gradlew编译

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
例如：cp -r conf_template conf
```

（2）进入conf目录：

```shell
cd conf
```

**注意：** 将节点所在目录`nodes/${ip}/sdk`下的所有文件拷贝到当前`conf`目录，供SDK与节点建立连接时使用（SDK根据application.yml中的`useSmSsl`判断是否使用国密SSL）
- 链的`sdk`目录在非国密时，包含`ca.crt, sdk.crt, sdk.key`，在国密时，包含`sm_ca.crt`,`sm_sdk.crt`,`sm_sdk.key`,`sm_ensdk.crt`,`sm_ensdk.key`
- 拷贝命令可使用`cp nodes/${ip}/sdk/* ./conf/`

（3）修改配置（根据实际情况修改）：

如果在企业部署中使用WeBASE-Front，必须配置下文中的`keyServer`，用于连接WeBASE-Sign服务

```
vi application.yml
```

``` 
spring:
  datasource:
    url: jdbc:h2:file:./h2/webasefront;DB_CLOSE_ON_EXIT=FALSE // 默认H2库为webasefront，建议修改数据库存放路径
...
server: 
  port: 5002                    // 服务端口
  context-path: /WeBASE-Front
sdk:
  useSmSsl: false  // 是否启用了国密SSL
  peers: ['127.0.0.1:20200','127.0.0.1:20201'] // 连接的节点（rpc节点）ip与端口，建议连接所有rpc节点
  certPath: conf    // sdk证书的目录，默认为conf
  ...
constant: 
  keyServer: 127.0.0.1:5004     // 密钥服务的IP和端口(WeBASE-Node-Manager服务或者WeBASE-Sign服务，不同服务支持的接口不同)，如果作为独立控制台以下配置可选
  aesKey: EfdsW23D23d3df43          // aes加密key(16位) 如启用，各互联的子系统的加密key需保持一致
  transMaxWait: 30              // 交易最大等待时间
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

启动成功将出现如下日志：
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
前置服务全量日志：tail -f log/WeBASE-Front.log
前置服务错误日志：tail -f log/WeBASE-Front.log
web3连接日志：tail -f log/web3sdk.log
```