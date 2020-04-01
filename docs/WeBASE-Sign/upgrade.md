# 升级说明

WeBASE-Sign升级的兼容性说明，请结合[WeBASE-Sign Changelog](https://github.com/WeBankFinTech/WeBASE-Sign/blob/master/Changelog.md)进行阅读

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
