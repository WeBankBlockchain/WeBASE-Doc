# 升级说明

WeBASE-Node-Manager升级的兼容性说明，请结合[WeBASE-Node-Manager Changelog](https://github.com/WeBankFinTech/WeBASE-Node-Manager/blob/master/Changelog.md)进行阅读

#### v1.2.1 => v1.2.2

兼容性说明：支持国密，可参考[WeBASE-Node-Manager 国密支持](README.html#id3)和[WeBASE-Front 国密支持](https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/README.html#id3)

1. 初始化数据修改：数据表的`tb_method`默认数据需要替换为国密版默认数据，可参考项目中`scripts/gm`中的`webase-dml-gm.sql`中的第5项进行数据初始化；
2. 初始化数据修改：数据表`tb_alert_rule`默认数据支持中英文告警，可结合项目中`scripts/webase-dml.sql`第6项进行数据更新；

#### v1.2.0 => v1.2.1

兼容性说明：增加邮件告警功能

1. 数据表修改：增加了`tb_mail_server_config`邮箱服务器配置表（邮箱服务配置），`tb_alert_rule`告警规则表（告警类型配置），`tb_alert_log`告警日志表，可通过项目中`scripts/webase-ddl.sql`进行数据表初始化；
2. 初始化数据修改：邮件告警功能的默认数据需要通过项目中`scripts/webase-dml.sql`的6, 7项进行数据初始化；

#### v1.1.0 => v1.2.0

兼容性说明：增加证书管理功能

1. 数据表修改：增加证书管理功能：增加了`tb_cert`数据表，可通过项目中`scripts/webase-ddl.sql`进行数据表初始化；；
2. 数据表修改：数据表`tb_method`增加`contract_type字段`，用于判断合约方法method为普通合约或系统合约(precompiled)，可结合项目中`scripts/webase-dml.sql`第5项进行数据更新；
