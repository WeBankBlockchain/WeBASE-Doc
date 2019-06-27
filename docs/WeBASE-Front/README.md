# 概要介绍

## 1. 功能说明
WeBASE-Front是和fisco-bcos节点配合使用的一个子系统，此分支支持fisco-bcos 2.0以上版本，可通过HTTP请求和节点进行通信，集成了web3jsdk，对接口进行了封装和抽象，具备可视化控制台，可以在控制台上查看交易和区块详情，开发智能合约，管理私钥，并对节点健康度进行监控和统计。 
  
  ![](./2.png) 
  
   部署方式有两种: (1)可以front组件单独部署作为独立控制台使用,打开http://{nodeIP}:8081/WeBASE-Front 即可访问控制台界面；(2)也可以结合[webase-node-mgr](https://github.com/WeBankFinTech/webase-node-mgr) 和 [webase-web](https://github.com/WeBankFinTech/webase-web)服务一起部署。

 注意：WeBASE-Front需要跟节点同机部署。一台机器部署多个节点，建议只部署一个front服务即可。
  