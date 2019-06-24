# 附录

## 1. 安装问题

### 1.1 Java部署

此处给出简单步骤，供快速查阅。更详细的步骤，请参考[官网](http://www.oracle.com/technetwork/java/javase/downloads/index.html)。

（1）从[官网](http://www.oracle.com/technetwork/java/javase/downloads/index.html)下载对应版本的java安装包，并解压到相应目录

```shell
mkdir /software
tar -zxvf jdkXXX.tar.gz /software/
```

（2）配置环境变量

```shell
export JAVA_HOME=/software/jdk1.8.0_121
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
```

### 1.2. 数据库部署

此处以Centos/Fedora为例。

（1）切换到root

```shell
sudo -s
```

（2）安装mysql

```shell
yum install mysql*
#某些版本的linux，需要安装mariadb，mariadb是mysql的一个分支
yum install mariadb*
```

（3）启动mysql

```shell
service mysqld start
#若安装了mariadb，则使用下面的命令启动
systemctl start mariadb.service
```

（4）初始化数据库用户

初次登录

```shell
mysql -u root
```

给root设置密码和授权远程访问

```sql
mysql > SET PASSWORD FOR 'root'@'localhost' = PASSWORD('123456');
mysql > GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;
```

**安全温馨提示：**

1. 例子中给出的数据库密码（123456）仅为样例，强烈建议设置成复杂密码
2. 例子中的远程授权设置会使数据库在所有网络上都可以访问，请按具体的网络拓扑和权限控制情况，设置网络和权限帐号

授权test用户本地访问数据库

```sql
mysql > create user 'test'@'localhost' identified by 'test1234';
```

（5）测试连接

另开一个ssh测试本地用户test是否可以登录数据库

```shell
mysql -utest -ptest1234 -h 127.0.0.1 -P 3306
```

登陆成功后，执行以下sql语句，若出现错误，则用户授权不成功

```sql
mysql > show databases;
mysql > use test;
```

（6）创建数据库

登录数据库

```shell
mysql -utest -ptest1234 -h 127.0.0.1 -P 3306
```

创建数据库

```sql
mysql > create database db_transaction;
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

执行shell脚本报错误permission denied。

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