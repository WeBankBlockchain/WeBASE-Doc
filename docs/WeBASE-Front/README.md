# 概要介绍

WeBASE-Front是和FISCO-BCOS节点配合使用的一个子系统。此分支支持FISCO-BCOS 2.0以上版本，集成web3sdk，对接口进行了封装，可通过HTTP请求和节点进行通信。另外，具备可视化控制台，可以在控制台上开发智能合约，部署合约和发送交易，并查看交易和区块详情。还可以管理私钥，对节点健康度进行监控和统计。 

  ![](./2.png)

WeBASE-Front使用方式有三种：

1、单独部署作为独立控制台使用，请参考[部署说明](install.md)。

2、结合[WeBASE-Node-Manager](https://github.com/WeBankFinTech/WeBASE-Node-Manager)和[WeBASE-Web](https://github.com/WeBankFinTech/WeBASE-Web)服务一起部署使用，请参考[WeBASE安装部署](https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Install/index.html)。

3、结合[WeBASE-Sign](https://github.com/WeBankFinTech/WeBASE-Sign)服务一起部署使用，调用WeBASE-Sign进行数据签名，再发送上链。

 **注意：** WeBASE-Front需要跟节点同机部署。一台机器部署多个节点，部署一个WeBASE-Front服务即可。
