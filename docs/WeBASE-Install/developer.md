# 快速入门搭建

我们推荐的快速入门，只需要搭建节点和节点前置服务(WeBASE-Front)，就可通过WeBASE-Front的合约编辑器进行合约的编辑，编译，部署，调试。

### 1.1 节点搭建

节点搭建的方法建议使用[build_chain](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/installation.html)。

### 1.2 节点前置服务(WeBASE-Front)搭建
**前提条件** 

| 依赖软件 | 支持版本 |
| :-: | :-: |
| Java | [JDK8或以上版本](../WeBASE-Front/appendix.html#java) |

备注：部署出现问题请查看[问题记录](../WeBASE-Front/appendix.html#id6)。

1. 下载安装包
    ```shell
    wget https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/WeBASE/releases/download/v1.4.0/webase-front.zip
    ```


2. 解压
    ```shell
    unzip webase-front.zip
    cd webase-front
    ```

3. 拷贝sdk证书文件（build_chain的时候生成的） 

    将节点所在目录nodes/${ip}/sdk下的ca.crt、node.crt和node.key文件拷贝到conf下

4. 服务起停
    ```shell
    启动： bash start.sh
    停止： bash stop.sh
    检查： bash status.sh 
    ```

5. 访问 http://{deployIP}:{frontPort}/WeBASE-Front，示例：  

    ```
    http://localhost:5002/WeBASE-Front 
    ```

    ![](../../images/WeBASE/front-overview.png)

    
