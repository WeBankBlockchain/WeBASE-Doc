# 部署说明

## 1. 前提条件

| 依赖软件 | 支持版本 |
| :-: | :-: |
| Gradle | Gradle4.10或以上版本 |
| Java | jdk1.8或以上版本 |
| FISCO-BCOS | V2.0.x版本 |

备注：安装说明请参看 [附录-1](./appendix.html#id2)。

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

执行构建命令，如果出现问题可以查看 [附录-2](./appendix.html#id3) ：

```
chmod +x ./gradlew
./gradlew build -x test
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

**将节点sdk目录下的以下文件复制到当前目录：**
ca.crt、node.crt、node.key

（3）修改配置（根据实际情况修改）：

```
vi application.yml
```

``` 
spring:
  datasource:
    url: jdbc:h2:file:~/.h2/webasefront;DB_CLOSE_ON_EXIT=FALSE // 默认H2库为webasefront
...
server: 
  port: 5003				  // 服务端口
  context-path: /WeBASE-Front
sdk: 
  ...
  ip: 127.0.0.1      		  // 连接节点的监听ip
  channelPort: 20200 		  // 连接节点的链上链下端口
constant:  
  transMaxWait: 30            // 交易等待时间
  monitorDisk: /data          // 要监控的硬盘目录 
  keyServer: 127.0.0.1:5001   // 密钥服务的IP和端口(WeBASE-Node-Manager服务或者WeBASE-Sign服务，不同服务支持的接口不同)，如果作为独立控制台使用可以不配置
...
```

## 5. 服务启停

返回到dist目录执行：
```shell
启动: bash start.sh
停止: bash stop.sh
检查: bash status.sh
```
**备注**：如果脚本执行错误，尝试以下命令:

```
赋权限：chmod + *.sh
转格式：dos2unix *.sh
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