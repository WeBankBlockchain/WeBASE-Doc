# 升级说明

WeBASE-Sign升级的兼容性说明，请结合[WeBASE-Sign Changelog](https://github.com/WeBankFinTech/WeBASE-Sign)进行阅读

WeBASE-Sign升级的必须步骤：
0. 备份已有文件或数据，下载新的安装包（可参考[安装包下载](../WeBASE/mirror.html#install_package)）
1. 替换`webase-sign/apps`中的jar包
2. 采用新yml文件，并将旧版本yml已有配置添加到新版本yml中；可通过`diff aFile bFile`命令对比新旧yml的差异
3. 查看[签名服务升级文档](../WeBASE-Sign/upgrade.html)中对应版本是否需要修改数据表，若不需要升级则跳过
    3.1 若需要升级数据表，首先使用`mysqldump`命令备份数据库
    3.2 按照升级文档指引，操作数据表
4. `bash stop.sh && bash start.sh`重启

各个版本的具体修改可参考下文

#### v1.5.0

- 支持导出私钥，增加配置项`supportPrivateKeyTransfer: true`，接口支持私钥传输（aes加密后的私钥），配置项为`false`时不支持导出
- jar包升级：mysql-connector-java:8.0.22、bcprov-jdk15on:1.67
- 修复ECDSA签名结果序列化bug


#### v1.4.0
- 增加返回 WeBASE-Sign 版本号接口
- 默认Aes加密模式由`ECB`改为更安全的`CBC`，同时支持在yml配置中选择CBC与ECB

#### v1.3.2
- 移除Fastjson，替换为Jackson 2.11.0。
- 升级web3sdk为2.4.1，并升级springboot等依赖项

#### v1.3.1
- 新增`/user/import`接口，支持导入私钥，详情参考[接口文档](./interfaces.html)
- 新增`Credential`实例的缓存机制，优化签名性能

#### v1.3.0

##### 私钥数据表字段更新
- WeBASE-Sign的tb_user表新增两个字段: 私钥用户的唯一业务编号`signUserId`，和私钥用户所属应用编号`appId`

**升级操作说明**

如果WeBASE-Sign中有已存在的私钥数据，则在`tb_user`表新增列`sign_user_id`和`app_id`后，还需要赋予其初始值，且`sign_user_id`需赋予唯一值

登陆mysql后，进入到相应database中，以`webasesign`的database为例；
```
mysql -uroot -p123456

// mysql 命令行
mysql> use webasesign;

// 在tb_user中添加列
mysql> alter table tb_user add column sign_user_id varchar(64) not null;
mysql> alter table tb_user add column app_id varchar(64) not null;

// 添加sign_user_id的唯一约束
mysql> alter table tb_user add unique key unique_uuid (sign_user_id);

```

**如果仅将WeBASE-Node-Manager的私钥迁移至WeBASE-Sign中，则无需进行下面的sign_user_id赋值操作**

如果有已存在的user的sign_user_id和app_id赋值，sign_user_id赋予唯一的随机值即可；

```
// app_id可以设置为一样，也可根据user具体标签赋予不同的app_id值
mysql> update tb_user set app_id = 'app_default' where 1=1;
// 为每个user的sign_user_id设置一个唯一的随机值
mysql> update tb_user set sign_user_id = '{yourValue}'' where user_id = '{yourUserId}';
```


##### API更新
- WeBASE-Sign的新建私钥接口`/user/newUser`需传入`signUserId`, `appId`才可新建用户，且可以传值`encryptType`指定该用户的类型为ECDSA或国密算法；

值得注意的是，现在WeBASE-Sign新建私钥用户后，不再返回`privateKey字段`，即私钥不离开WeBASE-Sign数据库。

- WeBASE-Sign的数据签名接口`/sign`传参修改，原用的`userId`改为传入`signUserId`，签名时会根据user的类型选择ECDSA或国密算法进行签名；

- WeBASE-Sign新增停用用户的接口`/user`(DELETE)，可根据`signUserId`停用相应用户；
