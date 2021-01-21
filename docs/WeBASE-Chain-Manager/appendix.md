# 附录

## 1. 安装示例

### 1.1 Java部署

<span id="jdk"></span>

##### CentOS环境安装Java

<span id="centosjava"></span>

**注意：CentOS下OpenJDK无法正常工作，需要安装OracleJDK[下载链接](https://www.oracle.com/technetwork/java/javase/downloads/index.html)。**

```
# 创建新的文件夹，安装Java 8或以上的版本，将下载的jdk放在software目录
# 从Oracle官网(https://www.oracle.com/technetwork/java/javase/downloads/index.html)选择Java 8或以上的版本下载，例如下载jdk-8u201-linux-x64.tar.gz
$ mkdir /software

# 解压jdk
$ tar -zxvf jdk-8u201-linux-x64.tar.gz

# 配置Java环境，编辑/etc/profile文件
$ vim /etc/profile

# 打开以后将下面三句输入到文件里面并保存退出
export JAVA_HOME=/software/jdk-8u201  #这是一个文件目录，非文件
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

# 生效profile
$ source /etc/profile

# 查询Java版本，出现的版本是自己下载的版本，则安装成功。
java -version
```

##### Ubuntu环境安装Java

<span id="ubuntujava"></span>

```
  # 安装默认Java版本(Java 8或以上)
  sudo apt install -y default-jdk
  # 查询Java版本
  java -version
```

<span id="gradle"></span>

### 1.2 Gradle部署

此处给出简单步骤，供快速查阅。更详细的步骤，请参考[官网](http://www.gradle.org/downloads)。

（1）从[官网](http://www.gradle.org/downloads)下载对应版本的Gradle安装包，并解压到相应目录

```shell
mkdir /software/
unzip -d /software/ gradleXXX.zip
```

（2）配置环境变量

```shell
export GRADLE_HOME=/software/gradle-4.9
export PATH=$GRADLE_HOME/bin:$PATH
```

（3）查看版本

```
gradle -version
```

<span id="mysql"></span>

### 1.3. 数据库部署

此处以Centos安装*MariaDB*为例。*MariaDB*数据库是 MySQL 的一个分支，主要由开源社区在维护，采用 GPL 授权许可。*MariaDB*完全兼容 MySQL，包括API和命令行。其他安装方式请参考[MySQL官网](https://dev.mysql.com/downloads/mysql/)。

#### ① 安装MariaDB

- 安装命令

```shell
sudo yum install -y mariadb*
```

- 启停

```shell
启动：sudo systemctl start mariadb.service
停止：sudo systemctl stop  mariadb.service
```

- 设置开机启动

```
sudo systemctl enable mariadb.service
```

- 初始化

```shell
执行以下命令：
sudo mysql_secure_installation
以下根据提示输入：
Enter current password for root (enter for none):<–初次运行直接回车
Set root password? [Y/n] <– 是否设置root用户密码，输入y并回车或直接回车
New password: <– 设置root用户的密码
Re-enter new password: <– 再输入一次你设置的密码
Remove anonymous users? [Y/n] <– 是否删除匿名用户，回车
Disallow root login remotely? [Y/n] <–是否禁止root远程登录，回车
Remove test database and access to it? [Y/n] <– 是否删除test数据库，回车
Reload privilege tables now? [Y/n] <– 是否重新加载权限表，回车
```

#### ② 授权访问和添加用户

- 使用root用户登录，密码为初始化设置的密码

```
mysql -uroot -p -h localhost -P 3306
```

- 授权root用户远程访问

```sql
mysql > GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;
mysql > flush PRIVILEGES;
```

- 创建test用户并授权本地访问

```sql
mysql > GRANT ALL PRIVILEGES ON *.* TO 'test'@localhost IDENTIFIED BY '123456' WITH GRANT OPTION;
mysql > flush PRIVILEGES;
```

**安全温馨提示：**

- 例子中给出的数据库密码（123456）仅为样例，强烈建议设置成复杂密码
- 例子中root用户的远程授权设置会使数据库在所有网络上都可以访问，请按具体的网络拓扑和权限控制情况，设置网络和权限帐号

#### ③ 测试连接和创建数据库

- 登录数据库

```shell
mysql -utest -p123456 -h localhost -P 3306
```

- 创建数据库

```sql
mysql > create database webasechainmanager;
```

## 2. 常见问题

<span id="q&a"></span>

### 2.1 脚本没权限

- 执行shell脚本报错误"permission denied"或格式错误

```
赋权限：chmod + *.sh
转格式：dos2unix *.sh
```

### 2.2 构建失败

- 执行构建命令`gradle build -x test`抛出异常：

```
A problem occurred evaluating root project 'WeBASE-Chain-Manager'.
Could not find method compileOnly() for arguments [[org.projectlombok:lombok:1.18.2]] on root project 'WeBASE-Chain-Manager'.
```

  答：

方法1、已安装的Gradle版本过低，升级Gradle版本到4.10以上即可
方法2、直接使用命令：`./gradlew build -x test`

### 2.3 数据库问题

- 服务访问数据库抛出异常：

```
The last packet sent successfully to the server was 0 milliseconds ago. The driver has not received any packets from the server.
```

答：检查数据库的网络策略是否开通

```
下面以centos7为例：
查看防火墙是否开放3306端口： firewall-cmd --query-port=3306/tcp
防火墙永久开放3306端口：firewall-cmd --zone=public --add-port=3306/tcp --permanent
重新启动防火墙：firewall-cmd --reload
```

- 执行数据库初始化脚本抛出异常：

```
ERROR 2003 (HY000): Can't connect to MySQL server on '127.0.0.1' (110)
```

答：MySQL没有开通该帐号的远程访问权限，登录MySQL，执行如下命令，其中TestUser改为你的帐号

```
GRANT ALL PRIVILEGES ON *.* TO 'TestUser'@'%' IDENTIFIED BY '此处为TestUser的密码’' WITH GRANT OPTION;
```

<span id="application-yml"></span>

## 3. application.yml配置项说明

| 参数                                | 默认值                                         | 描述                                                         |
| ----------------------------------- | ---------------------------------------------- | ------------------------------------------------------------ |
| server.port                         | 5005                                           | 当前服务端口                                                 |
| server.servlet.context-path         | /WeBASE-Chain-Manager                          | 当前服务访问目录                                             |
| mybatis.typeAliasesPackage          | com.webank.webase.chain.mgr                    | mapper类扫描路径                                             |
| mybatis.mapperLocations             | classpath:mapper/*.xml                         | mybatis的xml路径                                             |
| spring.datasource.driver-class-name | com.mysql.cj.jdbc.Driver                       | mysql驱动                                                    |
| spring.datasource.url               | jdbc:mysql://127.0.0.1:3306/webasechainmanager | mysql连接地址                                                |
| spring.datasource.username          | defaultAccount                                 | mysql账号                                                    |
| spring.datasource.password          | defaultPassword                                | mysql密码                                                    |
| logging.config                      | classpath:log/log4j2.xml                       | 日志配置文件目录                                             |
| logging.level                       | com.webank.webase.chain.mgr: info              | 日志扫描目录和级别                                           |
| constant.resetGroupListCycle        | 600000                                         | 刷新群组列表任务执行完后，下一个开始间隔（毫秒）             |
| constant.groupInvalidGrayscaleValue | 1M                                             | 群组失效灰度期长度，灰度期过后，如果还没查到失效状态的群组，就删除（y:年, M:月, d:天, h:小时, m:分钟, n:永远有效） |
| constant.frontUrl                   | http://%1s:%2d/WeBASE-Front/%3s                | 前置服务的请求路径                                           |
| constant.httpTimeOut                | 5000                                           | http请求超时时间（毫秒）                                     |
| constant.contractDeployTimeOut      | 30000                                          | 合约部署超时时间（毫秒）                                     |
| constant.maxRequestFail             | 3                                              | 请求前置（frot）被允许失败次数，达到配置值后，将会停止往该路径发送请求 |
| constant.sleepWhenHttpMaxFail       | 60000                                          | 请求失败次数过多，熔断时间长度（毫秒）                       |
| executor.corePoolSize               | 3                                              | 线程池大小                                                   |
| executor.maxPoolSize                | 10                                             | 线程池最大线程数                                             |
| executor.queueSize                  | 50                                             | 线程池队列大小                                               |
| executor.threadNamePrefix           | "chain-mgr-async-"                             | 线程名前缀                                                   |