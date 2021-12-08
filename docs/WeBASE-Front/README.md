# 概要介绍

## 使用说明

WeBASE-Front是和FISCO-BCOS节点配合使用的一个子系统。此分支支持FISCO-BCOS 2.0以上版本，集成web3sdk，对接口进行了封装，可通过HTTP请求和节点进行通信。另外，具备可视化控制台，可以在控制台上开发智能合约，部署合约和发送交易，并查看交易和区块详情。还可以管理私钥，对节点健康度进行监控和统计。 


WeBASE-Front使用方式有以下三种：

1、单独部署作为独立控制台使用，请参考[部署说明](install.md)。

2、结合[WeBASE-Node-Manager](https://github.com/WeBankBlockchain/WeBASE-Node-Manager)和[WeBASE-Web](https://github.com/WeBankBlockchain/WeBASE-Web)服务一起部署使用，请参考[WeBASE安装部署](../WeBASE-Install/index.html)。

3、结合[WeBASE-Sign](https://github.com/WeBankBlockchain/WeBASE-Sign)服务一起部署使用，调用WeBASE-Sign进行数据签名，再发送上链。此方式在方式1的基础上再部署WeBASE-Sign服务，然后需调用合约部署（结合WeBASE-Sign）接口、交易处理（结合WeBASE-Sign）接口进行合约部署和调用（需要在yml中配置sign的地址）。


