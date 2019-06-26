## 部署说明

### 1.1 拉取代码
执行命令：
```
git clone https://github.com/WeBankFinTech/webase-sign.git
```

进入目录：

```
cd webase-sign
```

### 1.2 编译代码

方式一：如果服务器已安装gradle，且版本为gradle-4.10或以上

```shell
gradle build -x test
```
方式二：如果服务器未安装gradle，或者版本不是gradle-4.10或以上，使用gradlew编译
```shell
./gradlew build -x test
```
构建完成后，会在根目录webase-sign下生成已编译的代码目录dist。

### 1.3 修改配置

（1）进入编译的代码目录：
```shell
cd dist
```
（2）以下有注释的地方根据实际情况修改：

```shell
vi conf/application.yml
```

```
server: 
  # 本工程服务端口，端口被占用则修改
  port: 8085
  context-path: /webase-sign

spring: 
  datasource: 
    # 数据库连接信息
    url: jdbc:mysql://127.0.0.1:3306/testdb?useUnicode=true&characterEncoding=utf8
    # 数据库用户名
    username: dbUsername
    # 数据库密码
    password: dbPassword
    driver-class-name: com.mysql.jdbc.Driver
    
constant: 
  # aes加密key（16位）
  aesKey: EfdsW23D23d3df43
```

### 1.4 服务启停
```shell
启动：sh start.sh
停止：sh stop.sh
检查：sh status.sh
```
**备注**：如果脚本执行错误，尝试以下命令:
```
赋权限：chmod + *.sh
转格式：dos2unix *.sh
```

### 1.5 查看日志

```shell
tail -f log/webase-sign.log
```