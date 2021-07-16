# 升级说明

WeBASE-Front升级的兼容性说明，请结合[WeBASE-Front Changelog](https://github.com/WeBankFinTech/WeBASE-Front)进行阅读

WeBASE-Front升级的必须步骤：
1. 备份已有文件或数据，下载新的安装包（可参考[安装包下载](../WeBASE/mirror.html#install_package)）
2. 采用新的安装包，并将旧版本yml已有配置添加到新版本yml中；可通过`diff aFile bFile`命令对比新旧yml的差异
3. `bash stop.sh && bash start.sh`重启


各个版本的具体修改可参考下文

#### v1.5.2
- 优化合约Java项目导出功能，支持批量编译合约，支持多用户与channel端口检查
- 合约仓库新增Asset资产合约
- 增加交易组装接口`/tran/convertRawTxStr`和编码交易函数接口`/trans/encodeFunction`
- 支持合约IDE绑定合约地址、支持无私钥用户时交易窗口直接创建私钥

#### v1.5.1
- 合约IDE支持导出合约的Java工程脚手架
- 合约仓库新增SmartDev存证合约
- 优化合约IDE，通过worker加载编译js文件，修复部分chrome浏览器加载js失败问题
- 修复无群组1启动报错问题
- 修复合约IDE中合约调用参数为字符串时不能输入空格

#### v1.5.0
- Web3SDK切换到JavaSDK
- 支持导出前置的SDK证书与私钥、支持导出Pem/P12/WeID私钥

#### v1.4.3
- 新增了合约仓库、在线工具、支持CNS

#### v1.4.2
- 新增了合约EventLog查询功能

#### v1.4.1
- 新增链权限ChainGovernance接口
- 新增getBlockHeaderByHash与getBlockHeaderByNumber接口

#### v1.4.0
- 增加返回 WeBASE-Front 和 WeBASE-Sign 版本号接口

#### v1.3.2
- 移除Fastjson，替换为Jackson 2.11.0。
- 升级web3sdk为2.4.1，并升级springboot等依赖项

#### v1.3.1
- 新增动态群组接口，包含生成群组、启动/停止群组、删除/恢复群组、单个/批量查询群组状态等接口

注：动态群组操作指南可参考[动态群组操作指南](../WeBASE-Console-Suit/index.html#dynamic_group_use)，接口详情可参考[接口文档](./interface.html#dynamic_group_interface)

- 前置的“合约管理”Tab中，新增导入合约abi功能，可以导入已部署的合约进行管理
- 前置的“合约管理”Tab中，新增合约ABI编码功能，可用于构造交易input入参
- 私钥管理中，支持导入控制台所导出的.p12私钥；

#### v1.3.0

##### 私钥管理修改
- 节点前置Web页面中的**私钥管理**转移至**合约管理**Tab下，改为**测试用户**管理

WeBASE-Front本地私钥仅用于本地的合约调试，不建议用于生产；因此Web页面中的**私钥管理**转移至**合约管理**Tab下，改为**测试用户**管理；

在WeBASE-Front的Web页面部署合约、发交易时所使用的私钥均为本地私钥，与WeBASE-Node-Manager私钥区分开；

##### 节点管理与前置私钥模块调整
- WeBASE-Node-Manager的私钥将通过WeBASE-Sign托管（新建私钥、保存私钥和交易签名），不再由WeBASE-Front生成和保存（仅保存公钥与地址）；
- 节点管理WeBASE-Node-Manager **v1.3.0前**通过节点前置WeBASE-Front的`/trans/handle`和`/contract/deploy`进行合约交易与部署，**v1.3.0后**将通过`/trans/handleWithSign`接口和`/contract/deployWithSign`接口进行合约部署与交易

生成私钥的流程（此处为type=2的外部私钥，WeBASE-Front的私钥始终留在Front的数据库中）
![使用sign生成私钥的流程](../../images/WeBASE/new_generate_pri.png)

交易签名的流程
![使用sign交易签名的流程](../../images/WeBASE/new_tx_sign.png)

因此WeBASE-Node-Manager私钥数据需要转移到WeBASE-Sign数据库中，具体操作请参考[WeBASE-Node-Manager v1.3.0升级说明](../WeBASE-Node-Manager/upgrade.html#v1-3-0)

##### API字段更新
- WeBASE-Front的`/trans/handleWithSign`接口和`/contract/deployWithSign`接口传参修改如下；

`/trans/handleWithSign`接口：
```
{
    "groupId" :1,
    "signUserId": "458ecc77a08c486087a3dcbc7ab5a9c3",
    "contractAbi":[],
    "contractAddress":"0x14d5af9419bb5f89496678e3e74ce47583f8c166",
    "funcName":"set",
    "funcParam":["test"]
}
```

`/contract/deployWithSign`接口
```
{
    "groupId":1,
    "signUserId": "458ecc77a08c486087a3dcbc7ab5a9c3",
    "bytecodeBin":"xxx",
    "abiInfo": [],
    "funcParam":[]
}
```

- WeBASE-Front的所有接口中`useAes`字段将默认为`true`，即私钥默认采用aes加密保存，调用时可不传入`useAes`；

##### 部署合约时不再自动注册CNS
- `/trans/handle`接口中，`contractAbi`修改为必填，即需要传入合约abi或合约单个函数的abi。

具体修改可参考[接口文档](../WeBASE-Front/interface.html)


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

*注：需要在build.gradle的dependencies中添加`org.springframework.boot:spring-boot-starter-amqp:1.5.9.RELEASE`的依赖*

**WeBASE-Front默认不启用事件消息推送功能**，如需启用请参考[附录-链上事件订阅和通知](./appendix.html#id11)

