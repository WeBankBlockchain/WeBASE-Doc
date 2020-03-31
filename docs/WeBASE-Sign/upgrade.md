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


##### API更新
- WeBASE-Sign的新建私钥接口`/user/newUser`需传入`signUserId`, `appId`才可新建用户，且可以传值`encryptType`指定该用户的类型为ECDSA或国密算法；

值得注意的是，现在WeBASE-Sign新建私钥用户后，不再返回`privateKey字段`，即私钥不离开WeBASE-Sign数据库。

- WeBASE-Sign的数据签名接口`/sign`传参修改，原用的`userId`改为传入`signUserId`，且可以传值`encryptType`指定该用户的类型为ECDSA或国密算法；

- WeBASE-Sign新增停用用户的接口`/user`(DELETE)，可根据`signUserId`停用相应用户
