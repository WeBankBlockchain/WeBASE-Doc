# 开发者模式搭建

## 1、开发者模式搭建

我们推荐的开发者模式，只需要搭建节点和节点前置服务(WeBASE-Front)。

### 1.1、节点搭建

节点搭建的方法建议使用[build_chain](https://fisco-bcos-documentation.readthedocs.io/zh_CN/release-2.0/docs/installation.html)。


### 1.2、节点前置服务(WeBASE-Front)搭建
## 1. 前提条件

| 依赖软件 | 支持版本 |
| :-: | :-: |
| Java | jdk1.8或以上版本 |

备注：安装说明请参看 [附录-1](../WeBASE-Front/appendix.html#id2)。

1. 下载安装包
    ```shell
    wget https://www.fisco.com.cn/cdn/WeBASE/release/download/v1.0.2/webase-front.zip
    ```

2. 解压
    ```shell
    unzip webase-front.zip
    cd webase-front
    ```

3. 拷贝sdk证书文件（build_chain的时候生成的）
    将节点所在目录nodes/${ip}/sdk下的ca.crt、node.crt和node.key文件拷贝到conf下

4. 启动服务
    ```shell
    bash start.sh 
    ```
    其他命令：
    停止: bash stop.sh 
    检查服务状态: bash status.sh 

5. 访问
    http://{deployIP}:{frontPort}/WeBASE-Front 
    示例：http://localhost:5002/WeBASE-Front 

    
