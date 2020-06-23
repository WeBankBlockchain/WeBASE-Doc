# 升级说明

WeBASE-Web升级说明，请结合[WeBASE-Web Changelog](https://github.com/WeBankFinTech/WeBASE-Web)和[WeBASE管理平台使用手册](../WeBASE-Console-Suit/index.html)进行阅读。

#### v1.3.1

v1.3.1主要新增了动态群组管理、合约ABI导入、合约ABI编码器、支持导入私钥等功能，详情升级说明如下：

- 新增动态群组管理，包含生成群组、启动/停止群组、删除/恢复群组、查询节点群组状态等功能，操作说明可参考[动态群组管理使用指南](../WeBASE-Console-Suit/index.html#dynamic_group_use)
- 新增导入已部署合约ABI功能，支持导入已部署合约，进行合约调用
- 新增合约Abi编码器，可通过ABI构建交易参数
- 新增导入.p12/.pem/.txt私钥功能；其中.txt与节点前置导出私钥格式一致，.p12/.pem与控制台导出私钥格式一致；
