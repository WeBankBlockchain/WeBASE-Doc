# 企业部署

## 1、企业部署

WeBASE四个服务的部署架构如下图：节点前置需要和区块链节点部署在同一台机器，签名服务可以和节点前置分开部署，也可以同机部署；节点管理和WeBASE管理平台可以同机部署，也可以分开部署。在企业生产环境，为了容灾往往会在多个节点上部署节点前置，也会部署多个签名服务、节点管理和WeBASE管理台。
- WeBASE lab版本已适配FISCO-BCOS 3.0.0版本，相关文档与代码仓库可跳转至 [WeBASE-lab分支](https://webasedoc.readthedocs.io/zh_CN/lab)查看


```eval_rst
.. important::
    FISCO-BCOS 2.0与3.0对比、JDK版本、WeBASE及其他子系统的兼容版本说明！`请查看 <https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/compatibility.html>`_
```
<img src="../../_images/Framework_2.png" width="700">

具体部署可以参考《WeBASE管理平台使用说明》中[手动搭建](../WeBASE-Console-Suit/index.html#id9)部分。

## 2、使用手册
WeBASE管理平台的使用请查看[使用手册](../WeBASE-Console-Suit/index.html)。
