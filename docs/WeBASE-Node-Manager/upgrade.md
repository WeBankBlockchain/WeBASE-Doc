# 升级说明

WeBASE-Node-Manager升级的兼容性说明，请结合[WeBASE-Node-Manager Changelog](https://github.com/WeBankBlockchain/WeBASE-Node-Manager)进行阅读

WeBASE-Node-Manager升级的必须步骤：
1. 备份已有文件或数据，下载新的安装包（可参考[安装包下载](../WeBASE/mirror.html#install_package)）
2. 使用新的安装包，并将旧版本yml已有配置添加到新版本yml中；可通过`diff aFile bFile`命令对比新旧yml的差异
3. 查看[节点管理服务升级文档](../WeBASE-Node-Manager/upgrade.html)中对应版本是否需要修改数据表，若不需要升级则跳过
    3.1 若需要升级数据表，首先使用`mysqldump`命令备份数据库
    3.2 按照升级文档指引，操作数据表
4. `bash stop.sh && bash start.sh`重启



