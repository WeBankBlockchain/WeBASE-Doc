# 附录

## 1. 安装问题

<span id="jdk"></span>
### 1.1 Java部署

#### CentOS环境安装Java
<span id="centosjava"></span>

**注意：CentOS下OpenJDK无法正常工作，需要安装OracleJDK[下载链接](https://www.oracle.com/technetwork/java/javase/downloads/index.html)。**

```
# 创建新的文件夹，安装Java 8或以上的版本，将下载的jdk放在software目录
# 从Oracle官网(https://www.oracle.com/technetwork/java/javase/downloads/index.html)选择Java 8或以上的版本下载，例如下载jdk-8u201-linux-x64.tar.gz
$ mkdir /software

# 解压jdk
$ tar -zxvf jdk-8u201-linux-x64.tar.gz

# 配置Java环境，编辑/etc/profile文件
$ vim /etc/profile

# 打开以后将下面三句输入到文件里面并保存退出
export JAVA_HOME=/software/jdk-8u201  #这是一个文件目录，非文件
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

# 生效profile
$ source /etc/profile

# 查询Java版本，出现的版本是自己下载的版本，则安装成功。
java -version
```

#### Ubuntu环境安装Java
<span id="ubuntujava"></span>

```
  # 安装默认Java版本(Java 8或以上)
  sudo apt install -y default-jdk
  # 查询Java版本
  java -version
```

### 1.2 Gradle部署

此处给出简单步骤，供快速查阅。更详细的步骤，请参考[官网](http://www.gradle.org/downloads)。

（1）从[官网](http://www.gradle.org/downloads)下载对应版本的Gradle安装包，并解压到相应目录

```shell
mkdir /software/
unzip -d /software/ gradleXXX.zip
```

（2）配置环境变量

```shell
export GRADLE_HOME=/software/gradle-4.9
export PATH=$GRADLE_HOME/bin:$PATH
```

（3）查看版本

```
gradle -version
```

## 2. 常见问题
<span id="q&a"></span>

* 1：执行shell脚本报错误"permission denied"或格式错误

   ```
   赋权限：chmod + *.sh
   转格式：dos2unix *.sh
   ```

 * 2：eclipse环境编译源码失败，错误提示如下：
```
...
/data/temp/WeBASE-Front/src/main/java/com/webank/webase/front/performance/PerformanceService.java:167: error: cannot find symbol
        log.info("begin sync performance");
        ^
  symbol:   variable log
  location: class PerformanceService
Note: /data/temp/WeBASE-Front/src/main/java/com/webank/webase/front/contract/CommonContract.java uses or overrides a deprecated API.
Note: Recompile with -Xlint:deprecation for details.
Note: Some input files use unchecked or unsafe operations.
Note: Recompile with -Xlint:unchecked for details.
100 errors

> Task :compileJava FAILED

FAILURE: Build failed with an exception.
...
```

  答：问题是不能编译Lombok注解 ，修改build.gradle文件，将以下代码的注释加上
```
 //annotationProcessor 'org.projectlombok:lombok:1.18.6'
```


* 3：节点运行一段时间后新增了一个群组，前置查不到新群组的信息。 

   答：调用 http://{ip}:{port}/WeBASE-Front/1/web3/refresh 方法，即可手动更新。

- 4：升级1.0.2版本时，数据库报错：

  ```
  Caused by: org.h2.jdbc.JdbcSQLException: NULL not allowed for column "TYPE"; SQL statement:
  alter table key_store_info add column type integer not null [23502-197]
          at org.h2.message.DbException.getJdbcSQLException(DbException.java:357) ~[h2-1.4.197.jar:1.4.197]
          at org.h2.message.DbException.get(DbException.java:179) ~[h2-1.4.197.jar:1.4.197]
          at org.h2.message.DbException.get(DbException.java:155) ~[h2-1.4.197.jar:1.4.197]
  ```

  答：将H2数据库删除（在h2目录下），或者配置新数据库名，在 application.yml 文件中的配置如下：

  ```
  spring:
    datasource:
      url: jdbc:h2:file:./h2/webasefront;DB_CLOSE_ON_EXIT=FALSE // 默认H2库为webasefront
  ...
  ```

- 5：日志报以下错误信息：

  ```
  2019-08-08 17:29:05.505 [pool-11-thread-1] ERROR TaskUtils$LoggingErrorHandler() - Unexpected error occurred in scheduled task.
  org.hyperic.sigar.SigarFileNotFoundException: 没有那个文件或目录
          at org.hyperic.sigar.FileSystemUsage.gather(Native Method) ~[sigar-1.6.4.jar:?]
          at org.hyperic.sigar.FileSystemUsage.fetch(FileSystemUsage.java:30) ~[sigar-1.6.4.jar:?]
          at org.hyperic.sigar.Sigar.getFileSystemUsage(Sigar.java:667) ~[sigar-1.6.4.jar:?]
  ```

  答：监控目录不存在，需配置节点所在磁盘目录，在 application.yml 文件中的配置如下：

  ```
  ...
  constant:  
    monitorDisk: /            // 要监控的磁盘目录，配置节点所在目录（如：/home）
  ...
  ```

- 6：启动报错“nested exception is javax.net.ssl.SSLException”：

```
...
nested exception is javax.net.ssl.SSLException: Failed to initialize the client-side SSLContext: Input stream not contain valid certificates.
```

答：CentOS的yum仓库的OpenJDK缺少JCE(Java Cryptography Extension)，导致Web3SDK无法正常连接区块链节点，因此在使用CentOS操作系统时，推荐使用[OracleJDK](#jdk)。


- 7：启动报错“Processing bcos message timeout”

```
...
[main] ERROR SpringApplication() - Application startup failed
org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'contractController': Unsatisfied dependency expressed through field 'contractService'; nested exception is org.springframework.beans.factory.UnsatisfiedDependencyException: Error creating bean with name 'contractService': Unsatisfied dependency expressed through field 'web3jMap'; nested exception is org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'web3j' defined in class path resource [com/webank/webase/front/config/Web3Config.class]: Bean instantiation via factory method failed; nested exception is org.springframework.beans.BeanInstantiationException: Failed to instantiate [java.util.HashMap]: Factory method 'web3j' threw exception; nested exception is java.io.IOException: Processing bcos message timeout
...
```

答：一些OpenJDK版本缺少相关包，导致节点连接异常。推荐使用[OracleJDK](#jdk)。

- 8：启动失败，日志却没有异常

```
===============================================================================================
Starting Server com.webank.webase.front.Application Port 5002 ................................[Failed]. Please view log file (default path:./log/).
Because port 5002 not up in 20 seconds.Script finally killed the process.
===============================================================================================
```

答：确认机器是否满足硬件要求。机器性能过低会导致服务端口一定时间内没起来，脚本会自动杀掉进程。可以尝试手动修改dist目录下的start.sh脚本，将启动等待时间设置久一点（默认600，单位：秒），然后启动。

```
...
startWaitTime=600
...
```

- 9：启动报错SSLContext: null

答：确保`conf/`目录下包含sdk证书；
若使用的是v1.5.0以前的版本，则需要保证`ca.crt, node.crt, node.key`；其中node.crt, node.key为sdk.crt, sdk.key复制并重命名得到；若使用v1.5.0及以上版本，则需要复制链的sdk目录下的所有文件(ca.crt, sdk.crt, sdk.key及gm文件夹)到前置服务的`conf`目录


## 3. 使用说明

### 测试用户管理

#### 3.1. 导入私钥

支持txt文件和pem文件导入测试用户的私钥信息

导入.txt私钥内容格式示例：

```
{
  "address":"0x06f81c8e1cb59b5df2cdeb87a212d17fba79aad7",
  "publicKey":"0x4b1041710a4427dc1c0d542c8f0fd312d92b0d03a989f512d1f8d3cafb851967f3592df0035e01fa63b2626165d0f5cffab15792161aa0360b8dfba2f3a7cf59",
  "privateKey":"71f1479d9051e8d6b141a3b3ef9c01a7756da823a0af280c6bf62d18ee0cc978", // 十六进制
  "userName":"111",
  "type":0  // type为0，不可修改
}
```
其中用户类型为0代表用户为WeBASE-Front的本地私钥用户，导入的私钥均为该类型；

导入.pem私钥内容示例：

```
-----BEGIN PRIVATE KEY-----
MIGEAgEAMBAGByqGSM49AgEGBSuBBAAKBG0wawIBAQQgC8TbvFSMA9y3CghFt51/
XmExewlioX99veYHOV7dTvOhRANCAASZtMhCTcaedNP+H7iljbTIqXOFM6qm5aVs
fM/yuDBK2MRfFbfnOYVTNKyOSnmkY+xBfCR8Q86wcsQm9NZpkmFK
-----END PRIVATE KEY-----
```
其中pem文件开头的`-----BEGIN PRIVATE KEY-----\n`和结尾的`\n-----END PRIVATE KEY-----\n`格式不可更改，否则将读取pem文件失败

#### 3.2. 导出私钥
<span id="loadKey"></span>

目前仅支持导出测试用户的txt格式私钥

**Java中如何使用导出的私钥**

以上文中的私钥加载：

基于javasdk的私钥加载：
```
@Test
public void testCrypto() {
    // 1-国密，0-ECDSA
    CryptoSuite cryptoSuite = new CryptoSuite(1);
    CryptoKeyPair keyPair = cryptoSuite.createKeyPair("e843a542a7a8240f9c9e418b9517c2c8f4dc041a11a44e614a3b026c3588c188");
    System.out.println("privateKey: " + keyPair.getHexPrivateKey());
    System.out.println("address: " + keyPair.getAddress());
    System.out.println("publicKey: " + keyPair.getHexPublicKey());
}
```

基于web3sdk的私钥加载：
```
@Test
public void loadPrivateKeyTest() {
  CryptoSuite
  String privateKey = "71f1479d9051e8d6b141a3b3ef9c01a7756da823a0af280c6bf62d18ee0cc978";
  Credentials credentials = GenCredential.create(privateKey);
  // private key 实例
  BigInteger privateKeyInstance = credentials.getEcKeyPair().getPrivateKey();
  System.out.println(Numeric.toHexStringNoPrefix(privateKeyInstance));
  // public key 实例
  BigInteger publicKeyInstance = credentials.getEcKeyPair().getPublicKey();
  System.out.println(Numeric.toHexString(publicKeyInstance));
  // address 地址
  String address = credentials.getAddress();
  System.out.println(address);
}

```

### 在IDE中开发WeBASE-Front
<span id="ide"></span>

IDE配置
- 由于项目依赖了lombok，需要在settings-build-compiler的`Enable Annotation Processing`设置中打钩
- 本项目使用gradle进行构建，可以在settings-build-build tools-gradle中设置本地的gradle环境

证书与项目配置
- 需要在资源目录中创建`conf`目录
- 将sdk中的所有证书文件拷贝到`resources/conf`目录
- 修改application.yml中的`sdk.ip`和`sdk.channelPort`

### 访问h2数据库

WeBASE-Front采用 JPA + H2数据库 的方式保存数据
- 源码查看各个**数据表**的内容：需要通过查看WeBASE-Front源码的各个包中带有`@Entity`注解的entity实体类；如，查看私钥数据表`KeyStoreInfo`则查看该文件`com.webank.webase.front.keystore.entity.KeyStoreInfo.java`
- 通过H2控制台**连接H2数据库**：

![](../../images/WeBASE/front/h2_console.png)
 
- 同机H2访问：可以通过浏览器打开`localhost:5002/WeBASE-Front/console`，以默认配置为例填入连接参数
  - `JDBC URL`应填入`file:../h2/webasefront;`，与前置服务的application.yml中配置的`spring.datasource.url`对应
  - 若未设置用户名与密码，则默认用户名为`sa`，密码为空
- 服务端H2访问：
  - 修改前置服务的application.yml中的`spring.h2.console.settings.web-allow-others`设为`true`，允许远端访问H2控制台
  - 重启前置服务
  - 访问`{ip}:{port}/WeBASE-Front/console`，参数填入方法同上



<span id="event_subscribe"></span>
## 4. 支持链上事件订阅和通知

在某些业务场景中，应用层需要实时获取链上的事件，如出块事件、合约Event事件等。应用层通过WeBASE连接节点后，**由于无法和节点直接建立长连接**，难以实时获取链上的消息。

支持通过**消息队列**(Message Queue)来获取WeBASE-Front(v1.2.3+)的链上事件的消息推送

目前支持出块事件与智能合约Event事件的事件Push通知，大致流程为：
1. WeBASE-Front连接到MQ-Server(目前支持RabbitMQ-Server);
2. WeBASE-Front接收节点的事件Push后，如出块通知，WeBASE-Front将出块消息发送到消息队列中；
2. 区块链应用连接MQ-Server，获取消息队列中待消费的消息，即可获得事件通知；

下面介绍如何搭建RabbitMQ的消息队列服务与WeBASE-Front的配置方法

### 4.1 RabbitMQ消息队列事件通知

#### 安装RabbitMQ服务并启用管理功能

启用消息队列的事件推送服务，需要
- 安装RabbitMQ Server

参考RabbitMQ官网的[下载与安装教程](https://www.rabbitmq.com/download.html)，安装并启动RabbitMQ-Server服务

*注：RabbitMQ依赖Erlang环境，可根据官网教程安装Erlang*

- 启动mq服务，并确保RabbitMQ Server服务所在主机的`5672`, `15672`端口可访问；

- 启用RabbitMQ的`rabbitmq_managerment`功能

启用该功能可通过访问`localhost:15672`页面，可视化管理MQ的队列与用户；否则，需要通过rabbitmqctl命令行工具管理；

启用方法：服务启动后，在mq所在主机运行以下命令，命令行显示启用成功即可：
```
  rabbitmq-plugins enable rabbitmq_management
```

#### 添加RabbitMQ管理员账户

若启用了`rabbitmq_managerment`的功能，可在浏览器访问mq服务所在主机的`ip:15672`端口，如访问本机`localhost:15672`

通过默认用户`guest`(密码也为`guest`)登录管理页，在Web页面上方的`Admin`项中，选择`add user`，新增tag为`Administrator`的管理员用户

注：
可通过RabbitMQ的命令行工具，添加管理员账户(`Administrator`)，具体可参考[rabbitmqctl文档](https://www.rabbitmq.com/rabbitmqctl.8.html)

**guest用户不支持远程登录Web管理页，如需远程登录管理页面，需要通过rabbitmqctl新增一个管理员用户**

#### WeBASE-Front的配置

通过配置applcation.yml中`spring-rabbitmq`项，WeBASE-Front即可连接到RabbitMQ-Server，将出块通知与合约Event通知推送到消息队列中：

**需要配置mq服务所在主机与管理员账户密码**
```
spring:
  datasource:
    ...
  jpa:
    ...
  h2:
    ...
  rabbitmq:
    host: 127.0.0.1 # rabbitmq部署所在主机的ip
    port: 5672 # rabbitmq默认连接端口
    username: defaultAccount # 要求具有Administrator权限的用户，本地连接rabbitmq可用guest账户
    password: defaultPassword 
    virtual-host: defaultVirtualHost # 消息队列和Exchange所在虚拟节点，默认为空或"/"
    publisher-confirm: true # 消息发布确认开启
    ssl:
      enabled: false # 是否启用ssl连接，默认false
```

#### 客户端（区块链应用/消息消费者）使用说明

##### 客户端开发流程

- 申请账号：客户端用户提供自己**客户端应用编号appId**，向mq-server运维管理员申请MQ服务的账号（可设置账户名和密码、virtual host）。
- 创建队列与赋予权限：运维管理员创建账号后，管理员以用户提供的客户端应用的`appId`为名字，创建一个该账户专属的队列，然后赋予该账户read其专属队列的权限( permission-read中设置)。
- 客户端连接到MQ：用户根据运维管理员提供的MQ账户名和密码、virtual host、消息交换机名（exchangeName），将自己的区块链应用连接到相应队列中，获取消息推送。

下面简单展示运维管理员通过RabbitMQ的Web工具管理MQ服务：

**创建MQ账户：**

![创建MQ账户](../../images/WeBASE/front-event/add_user.png)

**赋予MQ账户访问appId队列的read权限：**
![赋予read权限](../../images/WeBASE/front-event/set_permission.png)

**创建以appId命名的队列**

![创建appId队列](../../images/WeBASE/front-event/add_queue.png)

##### 客户端订阅事件推送流程：

- 客户端调用WeBASE-Front节点前置服务接口(`/event/newBlockEvent`和`event/contractEvent`)，注册事件监听；接口内容请查看[接口文档-事件通知](./interface.html#id330)

用户调用注册事件接口之后，实际上WeBASE-Front将以`appId+事件名+{randomString}`的routingKey，将用户所拥有的的队列Queue绑定到对应的Exchange中：

![appId队列绑定到群组Exchange](../../images/WeBASE/front-event/after_register.png)

- 用户在客户端以用户名密码连接到对应的virtual host，监听自己队列的消息，接收到消息后解析处理；

客户端获取事件通知过程需如上进行配置，可参考[WeBASE-Event-Client](https://github.com/WeBankFinTech/WeBASE-Event-Client)的消费者客户端的代码实现（Dev分支）

消费者客户端核心代码逻辑为：
```

@RabbitListener(queues = "${spring.rabbitmq.username}")
public void receive(Channel channel, Message message) throws IOException {
    log.info("++++++++ mq message body: {}, queue:{}", new String(message.getBody()),
            message.getMessageProperties());
    try {
        String bodyStr = new String(message.getBody());
        JSONObject json = JSONObject.parseObject(bodyStr);
        ...
        // 处理json消息体
    } catch (Exception e) {
      log.error("++++++++ mq 消息消费失败：id：{} Exception: {}", message.getMessageProperties().getDeliveryTag(), e);
      ...
    }
    ...
}
```

## 5. 配置文件解析
<span id="config"></span>

- 1. 配置文件解析

| 参数 | 默认值    | 描述          |
|------|-------------|-----------|
| server.port  | 5002 | 当前服务端口   |
| server.context-path  | /WeBASE-Front | 当前服务访问目录   |
| server.connection-timeout  | 30000 | 服务连接超时时间ms   |
| server.tomcat.max-threads  | 200 | tomcat最大线程数   |
| server.tomcat.max-connections  | 10000 | tomcat最大连接数   |
| sdk.orgName  | orgTest | sdk中默认的机构名   |
| sdk.corePoolSize  | 50 | sdk的core线程池大小   |
| sdk.maxPoolSize  | 100 | sdk的线程池最大值  |
| sdk.queueCapacity  | 100 | sdk请求队列最大长度   |
| sdk.timeout  | 10000 | sdk处理请求的超时时间ms   |
| sdk.keepAlive  | 60 | sdk最大连接数   |
| sdk.ip  | 127.0.0.1 | 节点的ip   |
| sdk.channelPort  | 20200 | 节点的channel端口   |
| sdk.encryptType  | 0 | 链的加密类型：0-ECDSA，1-国密   |
| logging.config  | classpath:log4j2.xml | logging配置文件的位置   |
| constant.keyServer  | 127.0.0.1:5004 | webase-sign服务的IP:Port（单个）   |
| constant.transMaxWait  | 30 | 交易最大等待时间(s)   |
| constant.monitorDisk  | / | 节点主机监控的路径 |
| constant.monitorEnabled  | true | 是否启用节点主机监控服务  |
| constant.aesKey  | EfdsW23D23d3df43 | webase服务的aes秘钥   |
| constant.nodePath  |  /fisco/nodes/127.0.0.1/node0 | 节点路径   |
| constant.http_read_timeOut  | 100000 | 访问服务的读取超时(ms)   |
| constant.http_connect_timeOut  | 100000 | 访问服务的连接超时(ms)   |
| constant.eventRegisterTaskFixedDelay  | 5000 | 事件推送注册的频率(ms)   |
| constant.syncEventMapTaskFixedDelay  | 60000 | 事件推送内存的同步频率(ms)   |
| constant.syncStatLogTime  | 5000 | 节点日志监控频率(ms)   |
| constant.syncStatLogCountLimit  | 10000 | 节点日志监控数据最大值   |
| constant.statLogEnabled  | false | 是否启用节点日志监控   |
| constant.eventCallbackWait  | 10 | 获取event log的超时时间（秒）   |


<!-- ### 配置https



#### 通过springboot配置https



#### 通过nginx配置https -->



