# 部署说明

## 1. 前提条件

| 依赖软件 | 支持版本 |
| :-: | :-: |
| Java | JDK8或以上版本 |
| FISCO-BCOS | V2.0.x版本 |

**备注：** Java推荐使用[OracleJDK](https://www.oracle.com/technetwork/java/javase/downloads/index.html)，可参考[JDK配置指引](./appendix.html#jdk)（CentOS的yum仓库的OpenJDK缺少JCE(Java Cryptography Extension)，导致Web3SDK无法正常连接区块链节点）

### 国密支持

WeBASE-Front v1.2.2+已支持 [国密版FISCO-BCOS](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/manual/guomi_crypto.html)

```eval_rst
.. important::
    使用国密版WeBASE-Front需要开启web3sdk的国密开关
```

开启web3sdk的国密开关:

- 开启web3sdk的国密开关：将配置文件`application.yml`中`sdk`的`encryptType`从`0`修改为`1`；
- 编译国密版智能合约在v1.3.1版本后，通过引入solcJ:0.4.25-rc1.jar，自动切换支持国密版智能合约的编译/部署/调用；（可自行切换jar包版本为solcJ-0.5.2）

<span id="solc6"></span>
### solidity v0.6.10支持

WeBASE-Front v1.4.2已支持solidity `v0.5.1`和`v0.6.10`:

若需要使用**solidity v0.6.10**，则需要手动下载CDN中solidity的v0.6.10.js（国密v0.6.10-gm.js），并在WeBASE-Front编译后得到的conf文件夹(conf_template复制得到conf)中创建`solcjs`文件夹，并将js文件复制到该文件夹，无需重启后台服务，刷新合约IDE页面即可加载。（v0.4.25及v0.5.1已自动配置）

*注：使用webase-front.zip安装包直接部署或使用WeBASE一键部署则不需要手动放置solidity的js文件；*

```
// 可直接在conf目录中创建solcjs目录，并进入solcjs目录直接下载下面其中一个.js文件。
// ecdsa
wget https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/WeBASE/download/solidity/v0.6.10.js
// 国密
wget https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/WeBASE/download/solidity/v0.6.10-gm.js
```


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

*如果使用了国密版SSL* `nodes/${ip}/sdk/gm/`下的**所有证书**拷贝到conf目录下。
- 注，国密版**默认使用非国密SSL**，只有在建链时手动指定了`-G`(大写)时才会使用国密SSL

*如果需要使用solidity v0.6.10，可参考[v0.6.10配置](#solc6)*

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
  encryptType: 0                // 0: ECDSA, 1: 国密
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