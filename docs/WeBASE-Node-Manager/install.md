## 部署说明

### 1.1 注意事项
* 在服务搭建的过程中，如碰到问题，请查看 [常见问题解答](./install_FAQ.md)
* 安全温馨提示： 强烈建议设置复杂的数据库登录密码，且严格控制数据操作的权限和网络策略。

### 1.2 拉取代码
执行命令：
```shell
git clone https://github.com/WeBankFinTech/WeBASE-Node-Manager.git
```
### 1.3 编译代码
进入代码根目录：
```shell
cd WeBASE-Node-Manager
```
在代码的根目录WeBASE-Node-Manager执行构建命令：
```shell
gradle build -x test
（没有安装Gradle  则使用 ./gradlew build -x test）
```
构建完成后，会在根目录WeBASE-Node-Manager下生成已编译的代码目录dist。


### 1.4 数据库初始化
#### 1.4.1 新建数据库
```
#登录MySQL:
mysql  -u ${your_db_account}  -p${your_db_password}  例如：mysql  -u root  -p123456
#新建数据库：
CREATE DATABASE IF NOT EXISTS {your_db_name} DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
```

#### 1.4.2 修改脚本配置
进入数据库脚本目录
```shell
cd  dist/script
```
修改数据库连接信息：
```shell
修改数据库名称：sed -i "s/fisco-bcos-data/${your_db_name}/g" webase.sh
修改数据库用户名：sed -i "s/defaultAccount/${your_db_account}/g" webase.sh
修改数据库密码：sed -i "s/defaultPassword/${your_db_password}/g" webase.sh
```
例如：将数据库用户名修改为root，则执行：
```shell
sed -i "s/defaultAccount/root/g" webase.sh
```

#### 1.4.3 运行数据库脚本
执行命令：bash  webase.sh  ${dbIP}  ${dbPort}
如：
```shell
bash  webase.sh  127.0.0.1 3306
```

### 1.5 节点服务的配置及启动
#### 1.5.1 服务配置修改
进入到已编译的代码配置文件目录：
```shell
cd dist/conf
```
修改服务配置：
```shell
修改当前服务（WeBASE-Node-Manager）端口：sed -i "s/8080/${your_server_port}/g" application.yml
修改数据库IP：sed -i "s/127.0.0.1/${your_db_ip}/g" application.yml
修改数据库端口：sed -i "s/3306/${your_db_port}/g" application.yml
修改数据库名称：sed -i "s/fisco-bcos-data/${your_db_name}/g" application.yml
修改数据库用户名：sed -i "s/defaultAccount/${your_db_account}/g" application.yml
修改数据库密码：sed -i "s/defaultPassword/${your_db_password}/g" application.yml
```

#### 1.5.2 服务启停
进入到已编译的代码根目录：
```
cd dist
```
启动：
```shell
bash start.sh
```
停止：
```shell
bash stop.sh
```
状态检查：
```shell
bash serverStatus.sh
```
### 1.5.3 查看日志
进入到日志目录：
```shell
cd dist/logs
```
全量日志：tail -f node-mgr.log
错误日志：tail -f node-mgr-error.log
