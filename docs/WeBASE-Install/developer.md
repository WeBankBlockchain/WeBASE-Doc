# 快速入门搭建

我们推荐的快速入门，只需要搭建节点和节点前置服务(WeBASE-Front)，就可通过WeBASE-Front的合约编辑器进行合约的编辑，编译，部署，调试。

### 1.1 节点搭建

节点搭建的方法建议使用[build_chain](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/installation.html)。

### 1.2 节点前置服务(WeBASE-Front)搭建
**前提条件** 

| 依赖软件 | 支持版本 |
| :-: | :-: |
| Java | [JDK 8 至JDK 14](../WeBASE-Front/appendix.html#java) |

备注：部署出现问题请查看[问题记录](../WeBASE-Front/appendix.html#id6)。

1. 下载安装包
    ```shell
    wget https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/WeBASE/releases/download/v1.4.2/webase-front.zip
    ```


2. 解压
    ```shell
    unzip webase-front.zip
    cd webase-front
    ```

3. 拷贝sdk证书文件（build_chain的时候生成的） 

    将节点所在目录`nodes/${ip}/sdk`下的ca.crt、node.crt和node.key文件拷贝到conf下

    *如果使用了国密版SSL* `nodes/${ip}/sdk/gm/`下的**所有证书**拷贝到conf目录下。
    - 注，国密版**默认使用非国密SSL**，只有在建链时手动指定了`-G`(大写)时才会使用国密SSL


4. 服务起停

    **国密版**则通过vi修改`application.yml`中将`sdk-encryptType`设置为`1`（默认为0），也可以直接通过以下命令进行快速修改，修改后即可执行启停命令进行服务启停。
    ```shell
    sed -i "s%encryptType: 0%encryptType: 1%g" ./conf/application.yml
    ```

    服务启停命令：
    ```shell
    启动： bash start.sh
    停止： bash stop.sh
    检查： bash status.sh 
    ```

启动成功将出现如下日志：
```
...
	Application() - main run success...
```

* 状态检查：

成功部署后，可以根据以下步骤**确认服务是否启动成功**：
- **检查进程端口已启用**：使用`netstat`检查webase-front端口(默认为5002)是否已启用，若已启用，控制台输出如下：
```shell
$ netstat -anlp | grep 5002
netstat -anlp | grep 5002
tcp6       0      0 :::5002                 :::*                    LISTEN      31805/java  
```
- **网络策略**：检查webase-front的端口(默认为5002)是否在服务器的网络安全组中设置为**开放**。如，云服务厂商如腾讯云，查看安全组设置，为webase-front开放5002端口。**若端口未开放，将导致浏览器无法访问webase-front页面**
- **检查进程是否存在**：执行`ps -ef | grep webase.front`，确认webase-front进程已启动
```shell
$ ps -ef | grep webase.front
root     31805     1  0 17:24 pts/2    00:01:33 /usr/local/jdk/bin/java -Djdk.tls.namedGroups=secp256k1 -Dfile.encoding=UTF-8 -Xmx256m -Xms256m -Xmn128m -Xss512k -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=256m -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/root/fisco/webase/webase-deploy/webase-front/log/heap_error.log -Djava.library.path=/root/fisco/webase/webase-deploy/webase-front/conf -cp conf/:apps/*:lib/* com.webank.webase.front.Application
```
- **检查服务日志**：
  - 如果上述webase-front的**进程未启动**，则到需要进入`webase-front/log`日志目录，检查front的日志是否有报错信息。
  - 可根据[WeBASE-Front常见问题](../WeBASE-Front/appendix.html)进行错误排查。

5. 访问 http://{deployIP}:{frontPort}/WeBASE-Front，示例：  

    ```
    http://localhost:5002/WeBASE-Front 
    ```

    ![](../../images/WeBASE/front-overview.png)

    
