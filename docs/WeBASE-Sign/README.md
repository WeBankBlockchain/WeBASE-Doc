# 概要介绍

## 功能介绍
本系统为签名服务子系统。功能：管理公私钥、对数据进行签名。

## 国密支持

WeBASE-Sign v1.2.2+已支持 [国密版FISCO-BCOS](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/manual/guomi_crypto.html)，使用WeBASE v1.2.2及以上版本

具体需要适配国密版FISCO-BCOS的地方有：
1. 在配置文件`application.yml`中开启web3sdk的国密开关；