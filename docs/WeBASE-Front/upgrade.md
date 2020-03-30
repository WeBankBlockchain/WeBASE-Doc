# 升级说明

#### v1.3.0

##### 私钥管理调整
- WeBASE-Front本地私钥仅用于本地的合约调试，不建议用于生产；因此web页面中的私钥管理转移至合约管理Tab下，改为测试用户管理；在WeBASE-Front的页面部署合约、发交易时所使用的的均为本地私钥，与WeBASE-Node-Manager私钥区分开；

##### WeBASE-Node-Manager私钥调整
- WeBASE-Node-Manager将通过WeBASE-Front的**`/trans/handleWithSign`接口和`/contract/deployWithSign`接口进行合约部署与交易**
，即WeBASE-Node-Manager的私钥将由WeBASE-Sign托管（通过传入`signUserId`新建私钥和交易签名），WeBASE-Front将不保存WeBASE-Node-Manager的私钥（仅保存公钥与地址）；

**转移WeBASE-Node-Manager私钥到WeBASE-Sign的操作说明**
用户需要通过以下操作将存于前置H2数据库中属于节点管理的私钥数据导出，并导入到WeBASE-Sign数据库中
1. 打开WeBASE-Front H2数据库中的`KeyStoreInfo`表，通过`SELECT * FROM KEY_STORE_INFO WHERE TYPE = 2;`的SQL指令，获取所有属于WeBASE-Node-Manager的私钥；
2. 需保证WeBASE-Front、WeBASE-Node-Manager和WeBASE-Sign application.yml中的`aesKey`字段的值一样（使用AES加密落盘的Key）
3. 在mysql中将所有私钥数据按对应字段，并添加相应的`signUserId`值和`appId`值，执行insert操作，插入到WeBASE-Sign数据库的`tb_user`表中；如未安装WeBASE-Sign，则按照[WeBASE-Sign安装文档](https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Sign/install.html)配置环境并运行WeBASE-Sign后，再执行插入操作；

<!-- 可参考下列mysql脚本：
```
mysql>insert into tb_user values()
``` -->
##### API字段更新
- WeBASE-Front的`/trans/handleWithSign`接口和`/contract/deployWithSign`接口传参修改，改为与`/trans/handle`接口和`/contract/deploy`一致，**WeBASE-Node-Manager**将通过且（传入用户地址`address`）；WeBASE-Front数据库中原有的私钥无需删除修改，且需要通过以下sql脚本，插入到WeBASE-Sign数据库中；
- WeBASE-Front的所有接口中`useAes`字段将默认为`true`，即私钥默认采用aes加密保存，调用时可不传入`useAes`；

#### v1.2.3

##### 修复api中的合约Bin字段

修复了WeBASE-Front接口中`contractBin`与`bytecodeBin`字段的bug

- `contractBin`是指合约编译后的运行时二进制码(runtime-bin)，多用于交易解析用
- `bytecodeBin`是指合约编译的完整二进制码(bytecode bin)，一般用于部署合约

将部分接口的`contractBin`字段修改为`bytecodeBin`字段，修改的接口包含`contract/deployWithSign`，共1个；

其余包含以上两个字段的接口，均在接口文档中丰富了字段说明，方便区分

##### 支持链上事件订阅和通知

在某些业务场景中，应用层需要实时获取链上的事件，如出块事件、合约Event事件等。应用层通过WeBASE连接节点后，**由于无法和节点直接建立长连接**，难以实时获取链上的消息。

为了解决这个问题，应用层可通过WeBASE-Front订阅链上事件，当事件触发时，可通过RabbitMQ消息队列通知到应用层，架构如下：

![链上事件通知架构](../../images/WeBASE/front-event/event_structure.png)

启用消息队列的事件推送服务，需要以下几步操作：
1. 安装RabbitMQ Server，启动mq服务，并确保RabbitMQ Server服务所在服务器的`5672`, `15672`端口可访问；
2. 启用RabbitMQ的`rabbitmq_managerment`功能,（在mq服务所在主机中运行`rabbitmq-plugins enable rabbitmq_management`）；
3. 配置`application.yml`中`spring-rabbitmq`项，通过`host`, `port`连接mq server, 且`username`, `password`有足够权限配置管理mq服务；

**WeBASE-Front默认不启用事件消息推送功能**，如需启用请参考[附录-链上事件订阅和通知](./appendix.html#id11)

