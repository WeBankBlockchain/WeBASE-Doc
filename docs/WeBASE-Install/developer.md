# 快速入门搭建

我们推荐的快速入门，只需要搭建节点和节点前置服务(WeBASE-Front)，就可通过WeBASE-Front的合约编辑器进行合约的编辑，编译，部署，调试。

### 1.1 节点搭建

节点搭建的方法建议使用[build_chain](https://fisco-bcos-documentation.readthedocs.io/zh_CN/release-2.0/docs/installation.html)。


### 1.2 节点前置服务(WeBASE-Front)搭建
**前提条件**

| 依赖软件 | 支持版本 |
| :-: | :-: |
| Java | jdk1.8 |



备注：安装说明请参看 [附录-1](../WeBASE-Front/appendix.html#id2)。

1. 下载安装包
    ```shell
    wget https://www.fisco.com.cn/cdn/webase/releases/download/v1.0.2/webase-front.zip
    ```


2. 解压
    ```shell
    unzip webase-front.zip
    cd webase-front
    ```

3. 拷贝sdk证书文件（build_chain的时候生成的）
    将节点所在目录nodes/${ip}/sdk下的ca.crt、node.crt和node.key文件拷贝到conf下

4. 修改conf/application.yml中节点的端口（build_chain使用默认配置时无需修改）

    `sdk:
      ......
      channelPort: 21200`

    端口可以在节点所在目录nodes/${ip}/node${number}/config.ini中看到。

5. 启动服务
    ```shell
    bash start.sh 
    ```
    其他命令：

    停止: bash stop.sh 

    检查服务状态: bash status.sh 

6. 访问
    http://{deployIP}:{frontPort}/WeBASE-Front 

    示例：http://localhost:5002/WeBASE-Front 

### 1.3 附录

#### 1.3.1 Java部署

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

#### 1.3.2 日志查看

如果服务出现异常，可以在webase-front/log目录查看日志。

| 常见错误类型                 | 解决方法                                                     |
| :--------------------------- | ------------------------------------------------------------ |
| Java没有配置对，启动脚本报错 | 按照附录正常按照Java，并配置好JAVA_HOME                      |
| 节点端口没有配置对           | 前置需要和节点同机部署，请确保正确配置了节点的channel_listen_port |

### 1.4 使用说明
以合约Asset为例：

```
pragma solidity ^0.4.21;

contract Asset {
    address public issuer;
    mapping (address => uint) public balances;

    event Sent(address from, address to, uint amount);

    constructor() {
        issuer = msg.sender;
    }

    function issue(address receiver, uint amount) public {
        if (msg.sender != issuer) return;
        balances[receiver] += amount;
    }

    function send(address receiver, uint amount) public {
        if (balances[msg.sender] < amount) return;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
    
}
```

1. 在**合约管理**中新建合约Asset，并**保存**
2. 在**私钥管理**里新建三个演示账号：Issuer， Alice ，Bob
3. 在**合约管理**的IDE中**编译**Asset合约
4. 使用Issuer账号**部署**Asset
5. 使用Issuer账号调用issue接口（**合约调用**）给Alice发放100资产
6. 查询（**合约调用**）Alice的余额，此时应该是100
7. 使用Alice的账号，调用send接口（**合约调用**），给bob转账10
8. 查询（**合约调用**）Alice的余额，此时应该是90
9. 查询（**合约调用**）Bob的余额，此时应该是10