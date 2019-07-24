# 部署说明

## 1. 前提条件

| 依赖软件 | 支持版本 |
| :-: | :-: |
| Gradle | Gradle4.9或更高版本 |
| Java | jdk1.8+ |
| FISCO-BCOS | V2.0.x版本 |

备注：安装说明请参看 [附录-1](./appendix.html#id2)。

## 2. 安装部署
### 2.1 拉取代码

执行命令：
```
git clone https://github.com/WeBankFinTech/WeBASE-Front.git
```

### 2.2 拷贝证书

 拷贝节点sdk目录下的ca.crt、node.crt、node.key证书到项目的src/main/resources目录。
 ```
 cp ~/nodes/127.0.0.1/sdk/*  ~/WeBASE-Front/src/main/resources
 ```

### 2.3 修改配置文件
根据需要修改application.yml配置文件：
``` 
spring:
  datasource:
    url: jdbc:h2:file:~/.h2/webasefront;DB_CLOSE_ON_EXIT=FALSE // 默认H2库为~/.h2/webasefront，可按需更改
    
constant:  
  transMaxWait: 30            // 交易等待时间
  monitorDisk: /data          // 要监控的硬盘目录 
  keyServer: 127.0.0.1:5001   // 密钥服务的IP和端口(WeBASE-Node-Manager服务或者WeBASE-Sign服务，不同服务支持的接口不同)，如果作为独立控制台使用可以不配置
```
 application.yml配置文件中sdk的配置采用默认配置，无需修改。如果想修改连接的节点和端口，设置如下：
``` 
 sdk: 
   ip: 127.0.0.1      // 连接节点的监听ip
   channelPort: 20200 // 连接节点的链上链下端口
```

### 2.4 编译
在代码的根目录WeBASE-Front执行构建命令，如果出现问题可以查看 [附录-2](./appendix.html#id3) ：
```
 chmod +x ./gradlew
 ./gradlew build -x test
```
构建完成后，会在根目录WeBASE-Front下生成已编译的代码目录dist。


### 2.5 服务启停

进入到已编译的代码根目录：
```shell
cd dist
```
```shell
启动: sh start.sh
停止: sh stop.sh
检查: sh status.sh
```
<font color="#dd0000">备注：如果脚本执行错误，尝试以下命令: </font>

```
赋权限：chmod + *.sh
转格式：dos2unix *.sh
```

### 2.6 访问控制台

```
http://{deployIP}:{frontPort}/WeBASE-Front
示例：http://localhost:5002/WeBASE-Front
```

- 部署服务器IP和服务端口需对应修改，网络策略需开通
- 基于可视化控制台，可以开发智能合约，部署合约和发送交易，并查看交易和区块详情。还可以管理私钥，对节点健康度进行监控和统计

### 2.7 查看日志

如果需要查看日志，进入到已编译的代码根目录：

```shell
cd dist
```

```
前置服务日志：tail -f log/WeBASE-Front.log
web3连接日志：tail -f log/web3sdk.log
```