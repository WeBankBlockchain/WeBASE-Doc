# 一键升级

## 子系统升级
WeBASE子系统升级需要参考[WeBASE releases](https://github.com/WeBankFinTech/WeBASE/releases)中WeBASE子系统间的兼容性说明，若只升级某个子系统，则需要查看子系统的Changelog，检查是否与已有的其他子系统兼容

**切记复制备份已有的子服务项目文件，便于恢复**，下面介绍各个服务的升级步骤

#### WeBASE-Front升级

0. 备份已有文件或数据，下载新的安装包（可参考[安装包下载](../WeBASE/mirror.html#install_package)）
1. 替换`webase-front/apps`中的jar包
2. 采用新yml文件，并将旧版本yml已有配置添加到新版本yml中；可通过`diff aFile bFile`命令对比新旧yml的差异
3. `bash stop.sh && bash start.sh`重启


#### WeBASE-Node-Manager升级

0. 备份已有文件或数据，下载新的安装包（可参考[安装包下载](../WeBASE/mirror.html#install_package)）
1. 替换`webase-node-mgr/apps`中的jar包
2. 采用新yml文件，并将旧版本yml已有配置添加到新版本yml中；可通过`diff aFile bFile`命令对比新旧yml的差异
3. 查看[节点管理服务升级文档](../WeBASE-Node-Manager/upgrade.html)中对应版本是否需要修改数据表，若不需要升级则跳过
    3.1 若需要升级数据表，首先使用`mysqldump`命令备份数据库
    3.2 按照升级文档指引，操作数据表
4. `bash stop.sh && bash start.sh`重启

#### WeBASE-Web升级

0. 备份已有文件或数据，下载新的安装包（可参考[安装包下载](../WeBASE/mirror.html#install_package)）
1. 直接替换`webase-web`整个目录，无需重启Nginx

#### WeBASE-Sign升级

0. 备份已有文件或数据，下载新的安装包（可参考[安装包下载](../WeBASE/mirror.html#install_package)）
1. 替换`webase-sign/apps`中的jar包
2. 采用新yml文件，并将旧版本yml已有配置添加到新版本yml中；可通过`diff aFile bFile`命令对比新旧yml的差异
3. 查看[签名服务升级文档](../WeBASE-Sign/upgrade.html)中对应版本是否需要修改数据表，若不需要升级则跳过
    3.1 若需要升级数据表，首先使用`mysqldump`命令备份数据库
    3.2 按照升级文档指引，操作数据表
4. `bash stop.sh && bash start.sh`重启

#### 节点升级

FISCO-BCOS节点的升级的详情需要参考[FISCO-BCOS 版本信息](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/change_log/index.html#id24)文档
- 兼容升级 ：直接替换 旧版本 的节点二进制文件为 新版本 的节点二进制文件，并重启。此方法无法启用节点新特性
- 全面升级 ：参考 [安装FISCO-BCOS](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/installation.html) 搭建新链，重新向新节点提交所有历史交易

## 使用WeBASE升级脚本
<span id="auto">

在WeBASE v1.5.0后，WeBASE将提供`webase-upgrade.sh`脚本（位于webase-deploy目录中，与`common.properties`文件同级目录）

升级期间，脚本将暂停节点与WeBASE所有服务，替换WeBASE安装包（不会更新节点）、替换配置文件、更新数据库的数据表（并备份原数据）
- 确保`common.properties`中配置的数据库配置正确；若已经通过该配置成功完成了一键部署，即不用修改
- 需要确保WeBASE一键部署的文件目录未重命名（如webase-front）
- 需要连接外网下载新的WeBASE安装包
- 暂不支持WeBASE可视化部署的自动升级
- 若升级脚本报错中断后，备份的各子服务文件存放在以旧版本号命名的目录，如`./v1.4.3`目录中，只需要将该目录的文件恢复并重启WeBASE即可
    ```bash
    # 恢复文件到当前目录(common.properties所在目录)
    cp -rf ./v1.4.3/* .
    # 重启
    python3 deploy.py startAll
    ```

运行脚本，脚本将自动完成升级步骤

```bash
# 脚本依赖python3命令，dos2unix命令，curl命令，unzip命令
# 检查python3
$ python3 --version
Python 3.6.8
# 检查dos2unix
$ dos2unix -V
dos2unix 6.0.3
# 检查curl命令
$ curl -V
curl 7.29.0
## 依赖检测完成后，指定-o旧版本，-n新版本后，即可运行
# bash webase-upgrade.sh -o {old_webase_version} -n {new_webase-version}
$ bash webase-upgrade.sh -o v1.4.3 -n v1.5.0

## 下面简单阐述升级脚本的操作内容
################################################
# 下载新的webase安装包(zip包)，已存在旧版本的zip包，则重命名为webase-XXX-{old_version}

# 解压新的zip包到webase-front.zip => webase-front-v1.5.0

# 停止原有的，python3 deploy.py stopAll

## 复制旧版本的自服务的配置文件到新版本目录
# webase-web 直接复制全部
# 复制已有front的conf/*.yml, *.key, *.crt, *.so，覆盖新front的文件
# 复制已有sign的conf/*.yml
# 复制已有node-mgr已有的conf的*.yml，conf/log目录

## 备份node-manager db
# 备份node-mgr数据库到webase-node-mgr/script/backup_node_mgr_{old_version}.sql
# 从common.properties中获取两个数据库密码
# 到node-mgr中检测script/upgrade目录，有匹配v143开头的，v150的结尾的，有则执行 mysql  -e "source $sql_file"
# 更新数据表 执行webase-node-mgr-{new_version}/script/upgrade/v{old_version}_v{new_version}.sql

# 到sign...同上（当前版本无需升级数据库）

## 将旧版本的webase-XXX备份到当前目录的{old_version}目录，新版本的webase-XXX-{new_version}重命名为webase-XXX
# mv操作，备份已有的，如 webase-web => ./v1.4.3/webase-web 以及 webase-web-v1.5.0 => webase-web

## 更新各java服务的yml的版本号

# 启动新的，执行python3 deploy.py startAll
################################################
```


