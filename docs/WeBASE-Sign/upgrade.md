# 升级说明

#### v1.3.0

##### 私钥数据表字段更新
- WeBASE-Sign的tb_user表新增两个字段: 私钥用户的唯一业务编号`signUserId`，和私钥用户所属应用编号`appId`

**升级操作说明**

登陆mysql后，进入到相应database中，以`webasesign`的database为例；
```
mysql -uroot -p123456

// mysql 命令行
mysql> use webasesign;

// 在tb_user中添加列
mysql> alter table tb_user add column sign_user_id varchar(64) not null;
mysql> alter table tb_user add column app_id varchar(64) not null;

// 为已存在的user赋予sign_user_id和app_id随机的值即可，sign_user_id需赋予唯一值
// app_id设置为所有都一样
mysql> update table tb_user set app_id = 'app_default' where 1=1;
// sign_user_id随意设置一个值
mysql> update table tb_user set sign_user_id = '{yourValue}'' where userId = '{yourUserId}';
```

##### WeBASE-Front私钥数据迁移至WeBASE-Sign

- WeBASE-Node-Manager将通过WeBASE-Front的**`/trans/handleWithSign`接口和`/contract/deployWithSign`接口进行合约部署与交易**
，即WeBASE-Node-Manager原来存于前置的私钥将由WeBASE-Sign托管，前置将不保存WeBASE-Node-Manager的私钥（仅保存公钥与地址）；

**转移WeBASE-Node-Manager私钥到WeBASE-Sign的操作说明**
用户需要通过以下操作将存于前置H2数据库中属于节点管理的私钥数据导出，并导入到WeBASE-Sign数据库中
1. 打开WeBASE-Front H2数据库中的`KeyStoreInfo`表，通过`SELECT * FROM KEY_STORE_INFO WHERE TYPE = 2;`的SQL指令，获取所有属于WeBASE-Node-Manager的私钥；
2. 需保证WeBASE-Front、WeBASE-Node-Manager和WeBASE-Sign application.yml中的`aesKey`字段的值一样（使用AES加密落盘的Key）
3. 在mysql中将所有私钥数据按对应字段，并添加相应的`signUserId`值和`appId`值，执行insert操作，插入到WeBASE-Sign数据库的`tb_user`表中；

<!-- 可参考下列mysql脚本：
```
mysql>insert into tb_user values()
``` -->

##### API更新
- WeBASE-Sign的新建私钥接口`/user/newUser`需传入`signUserId`, `appId`才可新建用户，且可以传值`encryptType`指定该用户的类型为ECDSA或国密算法；

值得注意的是，现在WeBASE-Sign新建私钥用户后，不再返回`privateKey字段`，即私钥不离开WeBASE-Sign数据库。

- WeBASE-Sign的数据签名接口`/sign`传参修改，原用的`userId`改为传入`signUserId`，且可以传值`encryptType`指定该用户的类型为ECDSA或国密算法；

- WeBASE-Sign新增删除接口`/user`(DELETE)，可根据`signUserId`删除相应用户
