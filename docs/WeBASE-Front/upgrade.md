# 升级说明

<!-- #### v1.3.0

- WeBASE-Front中私钥管理转由WeBASE-Sign管理，接口调用方式不变（传入用户地址`address`）；WeBASE-Front数据库中原有的私钥无需删除修改，且需要通过以下sql脚本，插入到WeBASE-Sign数据库中；

- WeBASE-Front的接口中`useAes`字段(私钥是否采用aes加密)将默认为`true`，且私钥由WeBASE-Sign同一加密管理； -->


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

**WeBASE-Front默认不启用事件消息推送功能**，如需启用请参考[附录-链上事件订阅和通知](./appendix.md#id11)

