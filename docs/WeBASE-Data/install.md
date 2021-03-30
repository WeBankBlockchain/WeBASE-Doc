# 部署说明

## 1 环境准备

|         依赖软件          |       支持版本        |
| :-----------------------: | :-------------------: |
|        FISCO BCOS         |    2.5.0或以上版本    |
|       WeBASE-Front        |    1.4.0或以上版本    |
|           Java            |    JDK8或以上版本     |
|           MySQL           |     5.6或以上版本     |
|       Elasticsearch       | 7.8.0（使用ES时部署） |
| elasticsearch-analysis-ik | 7.8.0（使用ES时部署） |
|           Nginx           |  nginx1.6或以上版本   |

- 部署说明可以参考[安装示例（附录1）](./appendix.html#instal)
- 在服务搭建的过程中，如碰到问题，请查看[常见问题（附录2）](./appendix.html#q&a)

## 2. 拉取代码

执行命令：

```
git clone https://github.com/WeBankFinTech/WeBASE-Data.git
或
git clone https://gitee.com/WeBank/WeBASE-Data.git
```

## 3 WeBASE-Data-Collect搭建

​	WeBASE-Data-Collect为监管数据导出和分析服务，自带配置页面，支持配置多个链，并通过添加区块链前置来获取区块链数据。同时可以配置应用相关信息，合约和用户信息。

### 3.1 编译代码

进入目录：

```shell
cd WeBASE-Data/WeBASE-Data-Collect
```

方式一：如果服务器已安装Gradle，且版本为Gradle-4.10或以上

```shell
gradle build -x test
```

方式二：如果服务器未安装Gradle，或者版本不是Gradle-4.10或以上，使用gradlew编译

```shell
chmod +x ./gradlew && ./gradlew build -x test
```

构建完成后，会在目录WeBASE-Data-Collect下生成已编译的代码目录dist。

### 3.2 数据库初始化

（1）新建数据库

```
#登录MySQL:
mysql -u ${your_db_account} -p${your_db_password} 
例如：mysql -u root -p123456
#新建数据库：
CREATE DATABASE IF NOT EXISTS {your_db_name} DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
例如：CREATE DATABASE IF NOT EXISTS webasedata DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
```

（2）修改脚本配置

进入数据库脚本目录script

```shell
cd  dist/script
```

修改数据库连接信息：

```shell
修改数据库名称：sed -i "s/webasedata/${your_db_name}/g" webase.sh
修改数据库用户名：sed -i "s/defaultAccount/${your_db_account}/g" webase.sh
修改数据库密码：sed -i "s/defaultPassword/${your_db_password}/g" webase.sh
```

例如：将数据库用户名修改为root，则执行：

```shell
sed -i "s/defaultAccount/root/g" webase.sh
```

（3）运行数据库脚本

```shell
bash  webase.sh ${dbIP} ${dbPort}
例如：bash webase.sh 127.0.0.1 3306
```

### 3.3 配置修改

（1）回到dist目录，dist目录提供了一份配置模板conf_template：

```
根据配置模板生成一份实际配置conf。初次部署可直接拷贝。
例如：cp conf_template conf -r
```

（2）修改配置文件*conf/applicationyml*，主要修改数据库连接和es连接信息，完整配置项说明请查看 [配置项说明（附录3.1）](./appendix.html#application-yml-collect)

- 服务端口，默认不修改。
- 数据库连接（数据库名需事先创建）。
- 需要需要将交易数据存入elasticsearch的话，需要将ifEsEnable设置成true，并配置IP端口和用户名密码。不使用则不需要修改。**使用elasticsearch的话，需先部署elasticsearch，再部署WeBASE-Data**。

```shell
...
server:
  port: 5009
  servlet:
    context-path: /WeBASE-Data-Collect

# database connection configuration
spring:
  datasource:
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://127.0.0.1:3306/webasedata?serverTimezone=GMT%2B8&useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull
    username: "defaultAccount"
    password: "defaultPassword"
  elasticsearch:
    rest:
      uris: 127.0.0.1:9200
      username: "elasticAccount"
      password: "elasticPassword"
# constants
constant:
  ## if use elasticsearch
  ifEsEnable: false
...
```

### 3.4 服务启停

```shell
启动：bash start.sh
停止：bash stop.sh
检查：bash status.sh
```

**备注**：服务进程起来后，需通过日志确认是否正常启动，出现以下内容表示正常；如果服务出现异常，确认修改配置后，重启。如果提示服务进程在运行，则先执行stop.sh，再执行start.sh。

```
...
	Application() - main run success...
```

### 3.5 访问

配置页面访问：

```
http://{deployIP}:{deployPort}/WeBASE-Data-Collect
示例：http://localhost:5009/WeBASE-Data-Collect
```

- 部署服务器IP和服务端口需对应修改，网络策略需开通

### 3.6 查看日志

```shell
全量日志：tail -f log/WeBASE-Data-Collect.log
错误日志：tail -f log/WeBASE-Data-Collect-error.log
```

## 4 WeBASE-Data-Fetcher搭建

​	WeBASE-Data-Fetcher为监管数据查询服务，向WeBASE-Data-Web服务提供数据查询接口。

### 4.1 编译代码

返回WeBASE-Data目录并进入WeBASE-Data-Fetcher目录。

方式一：如果服务器已安装Gradle，且版本为Gradle-4.10或以上

```shell
gradle build -x test
```

方式二：如果服务器未安装Gradle，或者版本不是Gradle-4.10或以上，使用gradlew编译

```shell
chmod +x ./gradlew && ./gradlew build -x test
```

构建完成后，会在目录WeBASE-Data-Fetcher下生成已编译的代码目录dist。

### 4.2 配置修改

（1）dist目录，dist目录提供了一份配置模板conf_template：

```
根据配置模板生成一份实际配置conf。初次部署可直接拷贝。
例如：cp conf_template conf -r
```

（2）修改配置文件*conf/applicationyml*，完整配置项说明请查看 [配置项说明（附录3.2）](./appendix.html#application-yml-fetcher)

- 服务端口，默认不修改。
- 数据库连接（数据库名需事先创建，需要和WeBASE-Data-Collect服务连接相同的数据库）。
- 如果需要进行搜索，查询elasticsearch里的交易数据，需要将ifEsEnable设置成true，并配置IP端口和用户名密码。不使用则不需要修改。**使用elasticsearch的话，需先部署elasticsearch，再部署WeBASE-Data**。

```shell
# server config
server:
  port: 5010
  servlet:
    context-path: /WeBASE-Data-Fetcher

# database connection configuration
spring:
  datasource:
    driver-class-name: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://127.0.0.1:3306/webasedata?serverTimezone=GMT%2B8&useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull
    username: "defaultAccount"
    password: "defaultPassword"
  elasticsearch:
    rest:
      uris: 127.0.0.1:9200
      username: "elasticAccount"
      password: "elasticPassword"
# constant config
constant:
  ## if use elasticsearch
  ifEsEnable: false
...
```

### 4.3 服务启停

```shell
启动：bash start.sh
停止：bash stop.sh
检查：bash status.sh
```

**备注**：服务进程起来后，需通过日志确认是否正常启动，出现以下内容表示正常；如果服务出现异常，确认修改配置后，重启。如果提示服务进程在运行，则先执行stop.sh，再执行start.sh。

```
...
	Application() - main run success...
```

### 4.4 访问

没有单独页面，可以通过swagger查看调用接口：

```
http://{deployIP}:{deployPort}/WeBASE-Data-Fetcher/swagger-ui.html
示例：http://localhost:5010/WeBASE-Data-Fetcher/swagger-ui.html
```

- 部署服务器IP和服务端口需对应修改，网络策略需开通

### 4.5 查看日志

```shell
全量日志：tail -f log/WeBASE-Data-Fetcher.log
错误日志：tail -f log/WeBASE-Data-Fetcher-error.log
```

## 5 WeBASE-Data-Web搭建

​	WeBASE-Data-Web为数据监管平台，提供数据浏览页面。

### 5.1 进入目录

返回WeBASE-Data目录并进入WeBASE-Data-Web目录。

```
cd WeBASE-Data-Web
```

### 5.2 配置修改

​	在docs目录下有配置文件nginx.conf，修改完后替换安装的nginx的配置文件nginx.conf（这里nginx安装配置文件在/usr/local/nginx/conf下面，如果这里没找到，可以到/etc下寻找，如有权限问题，请加上sudo）。

- 修改配置：

```
# 修改服务器ip，也可以使用域名
sed -i "s%127.0.0.1%${your_ip}%g" docs/nginx.conf

# 修改WeBASE-Data-Web服务端口（端口需要开通策略且不能被占用）
sed -i "s%5200%${your_port}%g" docs/nginx.conf

# 修改静态文件路径（文件需要有权限访问）
sed -i "s%/data/WeBASE-Data-Web/dist%${your_file_dir}%g" docs/nginx.conf

# WeBASE-Data-Fetcher服务ip和端口
sed -i "s%10.0.0.1:5010%${your_fetcher}%g" docs/nginx.conf
```

- 复制配置文件nginx.conf

```
cp -rf docs/nginx.conf /usr/local/nginx/conf
```

**备注：**  如果服务器已有nginx，可在原配置文件nginx.conf增加一个server：

```
    upstream data_server{
        server 10.0.0.1:5010; # WeBASE-Data-Fetcher服务ip和端口
    }
    server {
        listen       5200 default_server; # 前端端口（端口需要开通策略且不能被占用）
        server_name  127.0.0.1;           # 服务器ip，也可配置为域名
        location / {
                root   /WeBASE-Data/WeBASE-Data-Web/dist;   # 前端文件路径(对应修改文件需要有权限访问)
                index  index.html index.htm;
                try_files $uri $uri/ /index.html =404;
        }

        include /etc/nginx/default.d/*.conf;

        location /mgr {
                    proxy_pass    http://data_server/;    		
                    proxy_set_header		Host			 $host;
                    proxy_set_header		X-Real-IP		 $remote_addr;
                    proxy_set_header		X-Forwarded-For	 $proxy_add_x_forwarded_for;
        }
    }
```

### 5.3 启动nginx

启动命令：

```
/usr/local/nginx/sbin/nginx # nginx在/usr/local目录下
```

检查nginx是否启动：

```
ps -ef | grep nginx
```

### 5.4 访问

```
http://{deployIP}:{webPort}
示例：http://127.0.0.1:5200
```

- 部署服务器IP和服务端口需对应修改，网络策略需开通

### 5.5 查看日志

```shell
进程日志：tail -f logs/access.log
错误日志：tail -f logs/eror.log
```

