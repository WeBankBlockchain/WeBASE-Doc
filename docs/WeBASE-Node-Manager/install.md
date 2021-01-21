# 部署说明

## 1. 前提条件

| 序号 | 软件                  |
| ---- | --------------------- |
| 1    | FISCO-BCOS 2.0        |
| 2    | WeBASE-Front 对应版本 |
| 3    | MySQL5.6或以上版本    |
| 4    | Java8或以上版本       |


## 2. 注意事项
*  Java推荐使用[OracleJDK](https://www.oracle.com/technetwork/java/javase/downloads/index.html)，[JDK配置指引](./appendix.html#jdk)
* 在服务搭建的过程中，如碰到问题，请查看 [常见问题解答](./install_FAQ.html)
* 安全温馨提示： 强烈建议设置复杂的数据库登录密码，且严格控制数据操作的权限和网络策略

**通过WeBASE-Sign私钥管理**
WeBASE-Node-Manager v1.3.0+将通过WeBASE-Sign进行私钥管理，即使用WeBASE-Node-Manager v1.3.0+的版本需要同步安装WeBASE-Sign v1.3.0，详情可参考[升级文档](upgrade.html)进行阅读


**国密支持：**

WeBASE-Node-Manager v1.2.2+已支持 [国密版FISCO-BCOS](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/manual/guomi_crypto.html)，与[WeBASE-Front v1.2.2+](../WeBASE-Front/index.html)配合使用

```eval_rst
.. important::
    使用国密版WeBASE-Node-Manager需要开启web3sdk的国密开关和script/gm中的webase-gm.sh脚本进行数据库初始化
```

开启web3sdk的国密开关：
- 将配置文件`application.yml/applicationContext.xml`中web3sdk配置的`encryptType`从`0`修改为`1`；

部署时初始化数据库：
- 执行`dist/script/gm`中的webase-gm.sh脚本进行初始化，而非`dist/script`中的webase.sh，；


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

```eval_rst
.. important::
	如果使用国密版，应进入dist/script/gm目录，对/gm目录下的webase-gm.sh进行下文的操作，并在最后运行webase-gm.sh
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

**备注**：
- 如果使用国密版本，则将application.yml中`sdk-encryptType`由`0`改为`1`
- 如果使用可视化部署，则将application.yml中`constant-deployType`由`0`改为`1`，并设置`constant-webaseSignAddress`为当前的webase-sign路径。具体使用方法可以参考[可视化部署-手动部署](../WeBASE-Install/visual_deploy.html#visual-deploy-manual)


### 6.2 服务启停
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

### 6.3 查看日志

在dist目录查看：
```shell
全量日志：tail -f log/WeBASE-Node-Manager.log
错误日志：tail -f log/WeBASE-Node-Manager-error.log
```