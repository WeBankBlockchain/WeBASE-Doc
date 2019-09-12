# 部署说明

## 1. 前提条件

| 环境   | 版本                |
| ------ | ------------------- |
| Java   | jdk1.8或以上版本    |
| 数据库 | MySQL-5.6或以上版本 |

备注：安装说明请参看 [附录-1](./appendix.html#id2)。

## 2. 拉取代码

执行命令：
```
git clone https://github.com/WeBankFinTech/WeBASE-Sign.git
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

## 4. 修改配置

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
    username: dbUsername
    # 数据库密码
    password: dbPassword
    driver-class-name: com.mysql.cj.jdbc.Driver
    
constant: 
  # aes加密key（16位）
  aesKey: EfdsW23D23d3df43
```

## 5. 服务启停

在dist目录下执行：

```shell
启动：bash start.sh
停止：bash stop.sh
检查：bash status.sh
```
**备注**：如果脚本执行错误，尝试以下命令:
```
赋权限：chmod + *.sh
转格式：dos2unix *.sh
```

## 6. 查看日志

在dist目录下查看：

```shell
tail -f log/WeBASE-Sign.log
```