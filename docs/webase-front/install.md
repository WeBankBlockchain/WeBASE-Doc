# 节点前置服务(webase-front)

## 1. 部署说明

### 1.1 拉取代码

执行命令：
```
git clone -b dev-0.7 https://github.com/WeBankFinTech/webase-front.git
```

### 1.2 拷贝证书

 拷贝节点sdk目录下的ca.crt、node.crt、node.key证书到项目的src/main/resources目录。
 ```
 cp ~/nodes/127.0.0.1/sdk/*  ~/webase-front/src/main/resources
 ```

### 1.3 修改配置文件
 然后修改application.yml配置文件。
```
constant:  
  transMaxWait: 30            //交易等待时间
  monitorDisk: /home          //要监控的硬盘目录 
  keyServer: 10.0.0.1:8080   // 配置密钥服务(可以是node-mgr服务)的IP和端口（front独立使用可不配） 
```
 application.yml配置文件中sdk的配置采用默认配置，无需修改。如果想修改连接的节点和端口，设置如下：
``` 
 sdk: 
   ip: 127.0.0.1   //连接节点的ip，是本机ip，建议写成内网ip
   channelPort: 20200 // 连接节点的端口
```

### 1.4 编译
在代码的根目录webase-front执行构建命令：
```
  chmod +x ./gradlew
 ./gradlew build -x test
```
构建完成后，会在根目录webase-front下生成已编译的代码目录dist。 安装碰到问题，请参考 [安装问题帮助](install_FAQ.md)


### 1.5 服务启停

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

### 1.6 查看日志

进入到已编译的代码根目录：
```shell
cd dist
```
```
前置服务日志：tail -f log/webase-front.log
web3连接日志：tail -f log/web3sdk.log
```

### 1.7 打开控制台

http://{nodeIP}:8081/webase-front

基于可视化控制台，可以查看节点数据概览，查看链上节点的运行情况，开发智能合约，管理私钥等。

## 5. 附录

### 5.1 Java部署

此处给出简单步骤，供快速查阅。更详细的步骤，请参考[官网](http://www.oracle.com/technetwork/java/javase/downloads/index.html)。

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

### 5.2 gradle部署

此处给出简单步骤，供快速查阅。更详细的步骤，请参考[官网](http://www.gradle.org/downloads)。

（1）从[官网](http://www.gradle.org/downloads)下载对应版本的gradle安装包，并解压到相应目录

```shell
mkdir /software/
unzip -d /software/ gradleXXX.zip
```

（2）配置环境变量

```shell
export GRADLE_HOME=/software/gradle-2.1
export PATH=$GRADLE_HOME/bin:$PATH
```

```eval_rst
.. toctree::
   :maxdepth: 1

   interface.md
   install_FAQ.md
```
