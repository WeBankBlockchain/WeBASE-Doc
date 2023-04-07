# 升级说明

WeBASE-Front升级的兼容性说明，请结合[WeBASE-Front Changelog](https://github.com/WeBankBlockchain/WeBASE-Front)进行阅读

WeBASE-Front升级的必须步骤：
1. 备份已有文件或数据，下载新的安装包（可参考[安装包下载](../WeBASE/mirror.html#install_package)）
2. 采用新的安装包，并将旧版本yml已有配置添加到新版本yml中；可通过`diff aFile bFile`命令对比新旧yml的差异
3. `bash stop.sh && bash start.sh`重启

