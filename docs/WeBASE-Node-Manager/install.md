# 部署说明

## 1. 前提条件

| 序号 | 软件                  |
| ---- | --------------------- |
| 1    | FISCO-BCOS 2.0        |
| 2    | WeBASE-Front 对应版本 |
| 3    | MySQL5.6或以上版本    |
| 4    | Java1.8或以上版本     |


## 2. 注意事项
* 在服务搭建的过程中，如碰到问题，请查看 [常见问题解答](./install_FAQ.md)
* 安全温馨提示： 强烈建议设置复杂的数据库登录密码，且严格控制数据操作的权限和网络策略。

## 3. 拉取代码
执行命令：
```shell
git clone https://github.com/WeBankFinTech/WeBASE-Node-Manager.git
```
进入目录：

```shell
cd WeBASE-Node-Manager
```

## 4. 编译代码

方式一：如果服务器已安装Gradle，且版本为Gradle-4.10或以上

```shell
gradle build -x test
```

方式二：如果服务器未安装Gradle，或者版本不是Gradle-4.10或以上，使用gradlew编译

```shell
chmod +x ./gradlew && ./gradlew build -x test
```

构建完成后，会在根目录WeBASE-Node-Manager下生成已编译的代码目录dist。


## 5. 数据库初始化
### 5.1 新建数据库
```
#登录MySQL:
mysql -u ${your_db_account} -p${your_db_password}  例如：mysql -u root -p123456
#新建数据库：
CREATE DATABASE IF NOT EXISTS {your_db_name} DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
```

### 5.2 修改脚本配置
进入数据库脚本目录
```shell
cd  dist/script
```
修改数据库连接信息：
```shell
修改数据库名称：sed -i "s/webasenodemanager/${your_db_name}/g" webase.sh
修改数据库用户名：sed -i "s/defaultAccount/${your_db_account}/g" webase.sh
修改数据库密码：sed -i "s/defaultPassword/${your_db_password}/g" webase.sh
```
例如：将数据库用户名修改为root，则执行：
```shell
sed -i "s/defaultAccount/root/g" webase.sh
```

### 5.3 运行数据库脚本
执行命令：bash  webase.sh  ${dbIP}  ${dbPort}
如：

```shell
bash webase.sh 127.0.0.1 3306
```

## 6. 服务配置及启停
### 6.1 服务配置修改
（1）回到dist目录，dist目录提供了一份配置模板conf_template：

```
根据配置模板生成一份实际配置conf。初次部署可直接拷贝。
例如：cp conf_template conf -r
```

（2）修改服务配置：
```shell
修改服务端口：sed -i "s/5001/${your_server_port}/g" conf/application.yml
修改数据库IP：sed -i "s/127.0.0.1/${your_db_ip}/g" conf/application.yml
修改数据库端口：sed -i "s/3306/${your_db_port}/g" conf/application.yml
修改数据库名称：sed -i "s/webasenodemanager/${your_db_name}/g" conf/application.yml
修改数据库用户：sed -i "s/defaultAccount/${your_db_account}/g" conf/application.yml
修改数据库密码：sed -i "s/defaultPassword/${your_db_password}/g" conf/application.yml
```

### 6.2 服务启停
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

### 6.3 查看日志

在dist目录查看：
```shell
全量日志：tail -f log/WeBASE-Node-Manager.log
错误日志：tail -f log/WeBASE-Node-Manager-error.log
```