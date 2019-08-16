# 附录

## 1. 安装问题

### 1.1 Java部署

此处给出简单步骤，供快速查阅。更详细的步骤，请参考[官网](http://www.oracle.com/technetwork/java/javase/downloads/index.html)。

#### ① 安装包下载

从[官网](http://www.oracle.com/technetwork/java/javase/downloads/index.html)下载对应版本的java安装包，并解压到服务器相关目录

```shell
mkdir /software
tar -zxvf jdkXXX.tar.gz /software/
```

#### ② 配置环境变量

- 修改/etc/profile

```
sudo vi /etc/profile
```

- 在/etc/profile末尾添加以下信息

```shell
JAVA_HOME=/nemo/jdk1.8.0_181
PATH=$PATH:$JAVA_HOME/bin
CLASSPATH==.:$JAVA_HOME/lib
export JAVA_HOME CLASSPATH PATH
```

- 重载/etc/profile

```
source /etc/profile
```

#### ③ 查看版本

```
java -version
```

### 1.2. 数据库部署

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
mysql > create database webasetransaction;
```

### 1.3. Zookeeper部署

此处给出简单步骤，供快速查阅。详情请参考[官网](https://zookeeper.apache.org/)。

（1）从[官网](https://zookeeper.apache.org/releases.html)下载对应版本的安装包，并解压到相应目录

```shell
mkdir /software
tar -zxvf zookeeper-XXX.tar.gz /software/
```

（2）配置和启动

ZooKeeper的安装包括单机模式安装，以及集群模式安装。具体步骤请参考官网说明：

- [集群部署](https://zookeeper.apache.org/doc/r3.4.13/zookeeperAdmin.html#sc_zkMulitServerSetup) 
- [单机部署](https://zookeeper.apache.org/doc/r3.4.13/zookeeperAdmin.html#sc_singleAndDevSetup)

## 2. 常见问题

### 2.1 脚本没权限

执行shell脚本报错误"permission denied"

答：使用 “chmod +x 文件” 给文件增加权限

### 2.2 构建失败

“gradle build -x test”失败，不能编译Lombok注解：

```
...
/data/trans/webase-transcation/src/main/java/com/webank/webase/transaction/trans/TransService.java:175: error: cannot find symbol
                        log.warn("save fail. contract is not deploed", contractAddress);
                        ^
  symbol:   variable log
  location: class TransService
/data/trans/webase-transcation/src/main/java/com/webank/webase/transaction/trans/TransService.java:183: error: cannot find symbol
                                log.warn("call fail. contractAddress:{} abi is not exists", contractAddress);
                                ^
  symbol:   variable log
  location: class TransService
Note: /data/trans/webase-transcation/src/main/java/com/webank/webase/transaction/util/ContractAbiUtil.java uses unchecked or unsafe operations.
Note: Recompile with -Xlint:unchecked for details.
100 errors

FAILURE: Build failed with an exception.
...
```

  答： 修改 build.gradle文件，将以下代码的注释去掉

```
 //annotationProcessor 'org.projectlombok:lombok:1.18.2'
```