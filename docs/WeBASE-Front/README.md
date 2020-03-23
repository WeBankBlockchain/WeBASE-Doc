# 概要介绍

## 使用说明

WeBASE-Front是和FISCO-BCOS节点配合使用的一个子系统。此分支支持FISCO-BCOS 2.0以上版本，集成web3sdk，对接口进行了封装，可通过HTTP请求和节点进行通信。另外，具备可视化控制台，可以在控制台上开发智能合约，部署合约和发送交易，并查看交易和区块详情。还可以管理私钥，对节点健康度进行监控和统计。 

  ![](./2.png)

WeBASE-Front使用方式有以下三种：

1、单独部署作为独立控制台使用，请参考[部署说明](install.md)。

2、结合[WeBASE-Node-Manager](https://github.com/WeBankFinTech/WeBASE-Node-Manager)和[WeBASE-Web](https://github.com/WeBankFinTech/WeBASE-Web)服务一起部署使用，请参考[WeBASE安装部署](../WeBASE-Install/index.html)。

3、结合[WeBASE-Sign](https://github.com/WeBankFinTech/WeBASE-Sign)服务一起部署使用，调用WeBASE-Sign进行数据签名，再发送上链。此方式在方式1的基础上再部署WeBASE-Sign服务，然后需调用以下两个接口进行合约部署和调用：[合约部署（结合WeBASE-Sign）](interface.html#webase-sign)、[交易处理（结合WeBASE-Sign）](interface.html#id223)。

 **注意：** WeBASE-Front需要跟节点同机部署，一个节点对应一个WeBASE-Front服务。

## 国密支持

WeBASE-Front v1.2.2+已支持 [国密版FISCO-BCOS](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/manual/guomi_crypto.html)，使用WeBASE v1.2.2及以上版本

WeBASE-Front具体需要适配国密版FISCO-BCOS的地方有：
1. 在配置文件`application.yml/applicationContext.xml`中开启web3sdk的国密开关；
2. 合约编译支持国密版：
    1. WeBASE-Front的Web已引入sol-0.4.25-gm.js，已无缝支持国密版智能合约的编译/部署/调用；
    2. WeBASE-Front后台编译国密版智能合约，需要用solcJ-gm的jar包替换web3sdk默认使用的ethereum的solcJ jar包;

安装详情可查看下一章节的[WeBASE-Front部署说明](install.html)

## 支持链上事件订阅和通知

在某些业务场景中，应用层需要实时获取链上的事件，如出块事件、合约Event事件等。应用层通过WeBASE连接节点后，**由于无法和节点直接建立长连接**，难以实时获取链上的消息。

为了解决这个问题，应用层可通过WeBASE-Front订阅链上事件，当事件触发时，可通过RabbitMQ消息队列通知到应用层，架构如下：

![链上事件通知架构](../../images/WeBASE/front-event/event_structure.png)

WeBASE-Front默认不启用消息推送功能，如需启用请参考[附录-链上事件订阅和通知](./appendix.html#id11)