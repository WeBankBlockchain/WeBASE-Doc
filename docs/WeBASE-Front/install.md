# 部署说明

## 1. 前提条件

| 依赖软件 | 支持版本 |
| :-: | :-: |
| gradle | gradle4.9或更高版本（构建工具） |
| java | 1.8.0_181或更高版本|
| fisco-bcos | v2.0.x版本 |

备注：安装说明请参看附录。

## 2. 安装部署
### 2.1 拉取代码

执行命令：
```
git clone https://github.com/WeBankFinTech/webase-front.git
```

### 2.2 拷贝证书

 拷贝节点sdk目录下的ca.crt、node.crt、node.key证书到项目的src/main/resources目录。
 ```
 cp ~/nodes/127.0.0.1/sdk/*  ~/webase-front/src/main/resources
 ```

### 2.3 修改配置文件
 然后修改application.yml配置文件。
``` 
spring:
  datasource:
    url: jdbc:h2:file:~/.h2/front_db;DB_CLOSE_ON_EXIT=FALSE   //默认H2库为~/.h2/front_db,可按需更改
    
constant:  
  transMaxWait: 30            //交易等待时间
  monitorDisk: /home          //要监控的硬盘目录 
  keyServer: 127.0.0.1:8082   // 配置密钥服务(可以是node-mgr服务)的IP和端口（front独立使用可不配） 
```
 application.yml配置文件中sdk的配置采用默认配置，无需修改。如果想修改连接的节点和端口，设置如下：
``` 
 sdk: 
   ip: 127.0.0.1   //连接节点的ip，是本机ip，建议写成内网ip
   channelPort: 20200 // 连接节点的端口
```

### 2.4 编译
在代码的根目录webase-front执行构建命令：
```
  chmod +x ./gradlew
 ./gradlew build -x test
```
构建完成后，会在根目录webase-front下生成已编译的代码目录dist。 安装碰到问题，请参考 [安装问题帮助](install_FAQ.md)


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

### 2.6 查看日志

进入到已编译的代码根目录：
```shell
cd dist
```
```
前置服务日志：tail -f log/webase-front.log
web3连接日志：tail -f log/web3sdk.log
```

### 2.7 打开控制台

http://{nodeIP}:8081/webase-front

基于可视化控制台，可以查看节点数据概览，查看链上节点的运行情况，开发智能合约，管理私钥等。
