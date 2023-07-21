# 区块链教程 | 使用达梦数据库(DM)对WeBASE进行适配 

作者：梁锦辉

作为一个开放、功能丰富的区块链平台， WeBASE致力于提高区块链开发者的运维与管理效率。同时为使用者提供可以适配达梦数据库(DM)(信创环境)的兼容特性;
以下演示，我们通过WeBASE-Sign,为例子做的适配改造。

### |前期准备

#### 达数据库的安装
安装指南可以从达梦数据库(DM)官网获取：https://eco.dameng.com/document/dm/zh-cn/start/install-dm-linux-prepare.html

#### 获取达蒙数据库依赖配置
可以在maven或者gradle配置中引入

``` maven依赖配置示例
<dependency>H
<groupId>com.dameng</groupId>
<artifactId>DmJdbcDriver18</artifactId>
<version>8.1.1.193</version>
</dependency>
```

如果不同DM版本可以从数据库的安装目录下相关说明文档下获取到，
配置方法也可以在数据库安装目录下的\dmdbms\drivers\jdbc\readme.txt中看到依赖配置信息。

### DM结合WeBASE-SIGN的适配实现
当前WeBase-SIGN是使用的MYSQL作为数据库，达梦数据对MYSQL的兼容性也是比较优化，但存在有些关键语法的问题导致SQL执行不通过；
设计思路，此次改造通过增加使用开关来决定是否达启用达梦数据库(DM)，同时也不影响原来WeBase-SIGN支持MYSQL的能力，改造结果就是同时能支持MYSQL或者达梦数据库(DM)；

修改配置文件：src/main/resources/application.yml
```
driver-class-name: com.mysql.cj.jdbc.Driver
    driver-class-name: dm.jdbc.driver.DmDriver
    hikari:
      connection-test-query: SELECT 1 FROM DUAL
      connection-timeout: 30000



mybatis: 
  mapper-locations: classpath:mapper/*.xml
  configuration:
    variables:
      isDm8: true

```

修改映射文件：src/main/resources/mapper/UserDao.xml
```
<choose>
          <when test="${isDm8}">
              CREATE TABLE IF NOT EXISTS tb_user
              (
              user_id INT NOT NULL AUTO_INCREMENT COMMENT '用户编号',
              sign_user_id VARCHAR(64) NOT NULL COMMENT '用户唯一的业务编号',
              app_id varchar(64) NOT NULL COMMENT '用户对应的应用编号',
              address varchar(64) NOT NULL COMMENT '用户地址',
              public_key varchar(256) NOT NULL COMMENT '公钥',
              private_key varchar(256) NOT NULL COMMENT '私钥',
              description varchar(128) DEFAULT NULL COMMENT '描述',
              encrypt_type int NOT NULL COMMENT '加密类型，1：国密；0：ECDSA',
              gmt_create datetime DEFAULT NULL COMMENT '创建时间',
              gmt_modify datetime DEFAULT NULL COMMENT '修改时间',
              status char(1)  NOT NULL DEFAULT '1' COMMENT  '状态： 1 有效 0 无效',
              NOT CLUSTER PRIMARY KEY (user_id),
              CONSTRAINT unique_uuid UNIQUE(sign_user_id)
              ) STORAGE(ON "webase", CLUSTERBTR);

          </when>
          <otherwise>
              CREATE TABLE IF NOT EXISTS tb_user (
              user_id int(11) NOT NULL AUTO_INCREMENT COMMENT '用户编号',
              sign_user_id varchar(64) NOT NULL COMMENT '用户唯一的业务编号',
              app_id varchar(64) NOT NULL COMMENT '用户对应的应用编号',
              address varchar(64) NOT NULL COMMENT '用户地址',
              public_key varchar(256) NOT NULL COMMENT '公钥',
              private_key varchar(256) NOT NULL COMMENT '私钥',
              description varchar(128) DEFAULT NULL COMMENT '描述',
              encrypt_type int NOT NULL COMMENT '加密类型，1：国密；0：ECDSA',
              gmt_create datetime DEFAULT NULL COMMENT '创建时间',
              gmt_modify datetime DEFAULT NULL COMMENT '修改时间',
              status char(1)  NOT NULL DEFAULT '1' COMMENT  '状态： 1 有效 0 无效',
              PRIMARY KEY (user_id),
              UNIQUE KEY unique_uuid (sign_user_id)
              ) ENGINE=InnoDB AUTO_INCREMENT=100001 DEFAULT CHARSET=utf8 COMMENT='用户信息表';
          </otherwise>
</choose>
```

使用开关"${isDm8}"适配MYSQL和DMDB;








