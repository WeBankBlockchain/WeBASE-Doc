# 升级说明

WeBASE-Web升级说明，请结合[WeBASE-Web Changelog](https://github.com/WeBankFinTech/WeBASE-Web)和[WeBASE管理平台使用手册](../WeBASE-Console-Suit/index.html)进行阅读。


#### v1.4.1
新增FISCO BCOS v2.5.0及以上版本的基于角色的权限管理功能，新增了开发者模式
- 新的权限管理基于角色，可参考FISCO BCOS[权限控制文档](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/manual/permission_control.html)
- 开发者模式：新增了用户角色developer，可进行查询交易，合约部署调用等功能，无法使用管理员的系统管理与监控等功能。

#### v1.4.0
v1.4.0 主要在兼容原有手动部署底层服务，手动添加 WeBASE-Front 前置服务的基础上，新增了可视化部署底层服务，以及节点的动态管理功能。

- 增加左下展示版本号，包括**链版本**和**兼容版本**。如果是国密版本，链版本号会**带有** `gm` 后缀，兼容版本仅代表兼容的节点版本，**不带有** `gm` 后缀。

**提示**
- 如果要体验可视化部署，请参考[可视化部署](../WeBASE-Install/visual_deploy.html)部署新环境然后部署新链；


#### v1.3.1

v1.3.1主要新增了动态群组管理、合约ABI导入、合约ABI编码器、支持导入私钥等功能，详情升级说明如下：

- 新增动态群组管理，包含生成群组、启动/停止群组、删除/恢复群组、查询节点群组状态等功能，操作说明可参考[动态群组管理使用指南](../WeBASE-Console-Suit/index.html#dynamic_group_use)
- 新增导入已部署合约ABI功能，支持导入已部署合约，进行合约调用
- 新增合约Abi编码器，可通过ABI构建交易参数
- 新增导入.p12/.pem/.txt私钥功能；其中.txt与节点前置导出私钥格式一致，.p12/.pem与控制台导出私钥格式一致；
