# 部署说明

## 1. 前提条件

| 环境   | 版本                |
| ------ | ------------------- |
| Java   | jdk1.8或以上版本    |
| 数据库 | MySQL-5.6或以上版本 |

备注：安装说明请参看 [附录-1](./appendix.html#id2)。

<!-- **国密支持**： 需要在配置文件`application.yml`中将`encryptType`从`0`设置为`1`以开启sdk的国密开关 -->

## 2. 拉取代码

执行命令：
```shell
git clone https://github.com/WeBankFinTech/WeBASE-Sign.git

# 若因网络问题导致长时间下载失败，可尝试以下命令
git clone https://gitee.com/WeBank/WeBASE-Sign.git
```

进入目录：

```
cd WeBASE-Sign
```

## 3. 编译代码

方式一：如果服务器已安装Gradle，且版本为Gradle-4.10或以上

```shell
gradle build -x test
```
方式二：如果服务器未安装Gradle，或者版本不是Gradle-4.10或以上，使用gradlew编译
```shell
chmod +x ./gradlew && ./gradlew build -x test
```
构建完成后，会在根目录WeBASE-Sign下生成已编译的代码目录dist。


## 4. 数据库初始化
```
#登录MySQL:
mysql -u ${your_db_account} -p${your_db_password}  例如：mysql -u root -p123456
#新建数据库：
CREATE DATABASE IF NOT EXISTS {your_db_name} DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
```

## 5. 修改配置

（1）进入dist目录

```
cd dist
```

dist目录提供了一份配置模板conf_template：

```
根据配置模板生成一份实际配置conf。初次部署可直接拷贝。
例如：cp conf_template conf -r
```

（2）修改配置（根据实际情况修改）：

```shell
vi conf/application.yml
```

```
server: 
  # 本工程服务端口，端口被占用则修改
  port: 5004
  context-path: /WeBASE-Sign

spring: 
  datasource: 
    # 数据库连接信息
    url: jdbc:mysql://127.0.0.1:3306/webasesign?serverTimezone=GMT%2B8&useUnicode=true&characterEncoding=utf8
    # 数据库用户名
    username: "dbUsername"
    # 数据库密码
    password: "dbPassword"
    driver-class-name: com.mysql.cj.jdbc.Driver
    
constant: 
  # aes加密key(16位)，如启用，各互联的子系统的加密key需保持一致
  aesKey: EfdsW23D23d3df43

```

<!-- 
使用sed命令直接修改
```shell
修改服务端口：sed -i "s/5004/${your_server_port}/g" conf/application.yml
修改数据库IP：sed -i "s/127.0.0.1/${your_db_ip}/g" conf/application.yml
修改数据库端口：sed -i "s/3306/${your_db_port}/g" conf/application.yml
修改数据库名称：sed -i "s/webasesign/${your_db_name}/g" conf/application.yml
修改数据库用户：sed -i "s/dbUsername/${your_db_account}/g" conf/application.yml
修改数据库密码：sed -i "s/dbPassword/${your_db_password}/g" conf/application.yml
``` -->

## 5. 服务启停

在dist目录下执行：

```shell
启动：bash start.sh
停止：bash stop.sh
检查：bash status.sh
```
**备注**：服务进程起来后，需通过日志确认是否正常启动，出现以下内容表示正常；如果服务出现异常，确认修改配置后，重启提示服务进程在运行，则先执行stop.sh，再执行start.sh。

```
...
	Application() - main run success...
```

## 6. 查看日志

在dist目录下查看：

```shell
tail -f log/WeBASE-Sign.log
```