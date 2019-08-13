# 快速搭建

​	一键部署可以在 **同机** 快速搭建WeBASE管理台环境，方便用户快速体验WeBASE管理平台。

​	一键部署会搭建：节点（FISCO-BCOS 2.0）、节点前置子系统（WeBASE-Front）、节点管理子系统（WeBASE-Node-Manager）、管理平台（WeBASE-Web）。其中，节点的搭建是可选的，可以通过配置来选择使用已有链或者搭建新链。一键部署架构如下：

![[]](../../images/WeBASE/deploy.png)

## 前提条件

| 环境   | 版本                   |
| ------ | ---------------------- |
| Java   | jdk1.8或以上版本 |
| MySQL | MySQL-5.6或以上版本 |
| Python | 2.7                 |
| MySQL-python | 1.2.5 |

**备注：** 安装说明请参看[附录](#id8)。

## 拉取部署脚本

获取部署安装包：
```shell
wget https://github.com/WeBankFinTech/WeBASELargeFiles/releases/download/v1.0.2/webase-deploy.zip
```
解压安装包：
```shell
unzip webase-deploy.zip
```
进入目录：
```shell
cd webase-deploy
```

## 修改配置

① mysql数据库需提前安装，已安装直接配置即可，还未安装请参看[数据库部署](#id9)；

② 可以使用以下命令修改，也可以直接修改文件（vi common.properties），没有变化的可以不修改；

③ 一键部署支持使用已有链或者搭建新链。通过参数"if.exist.fisco"配置是否使用已有链，以下配置二选一即可：

- 当配置"yes"时，需配置已有链的路径
- 当配置"no"时，需配置节点fisco版本和节点安装个数，搭建的新链默认两个群组

​    如果不使用一键部署搭建新链，可以参考FISCO BCOS官方文档搭建 [FISCO BCOS部署流程](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/installation.html#fisco-bcos)；

④ 服务端口不能小于1024。

```shell
# 数据库信息
mysql.ip（数据库ip）：sed -i "s%localhost%${your_db_ip}%g" common.properties
mysql.port（数据库端口）：sed -i "s%3306%${your_db_port}%g" common.properties
mysql.user（数据库用户名）：sed -i "s%dbUsername%${your_db_account}%g" common.properties
mysql.password（数据库密码）：sed -i "s%dbPassword%${your_db_password}%g" common.properties
mysql.database（数据库名称）：sed -i "s%webasenodemanager%${your_db_name}%g" common.properties

# WeBASE管理平台服务端口
web.port（管理平台服务端口）：sed -i "s%5000%${your_web_port}%g" common.properties
# 节点管理子系统服务端口
mgr.port（节点管理子系统服务端口）：sed -i "s%5001%${your_mgr_port}%g" common.properties
# 节点前置子系统端口
front.port（节点前置子系统服务端口）：sed -i "s%5002%${your_front_port}%g" common.properties

# 节点监听Ip
node.listenIp（节点监听Ip）：sed -i "s%127.0.0.1%${your_listen_ip}%g" common.properties
# 节点p2p端口
node.p2pPort（节点p2p端口）：sed -i "s%30300%${your_p2p_port}%g" common.properties
# 节点链上链下端口
node.channelPort（节点channel端口）：sed -i "s%20200%${your_channel_port}%g" common.properties
# 节点rpc端口
node.rpcPort（节点rpc端口）：sed -i "s%8545%${your_rpc_port}%g" common.properties

# 是否使用已有的链（yes/no）
if.exist.fisco（是否使用已有链）：sed -i "s%yes%${your_existed_fisco}%g" common.properties

# 使用已有链时需配置
fisco.dir（已有链的路径，start_all.sh脚本所在路径）：sed -i "s%fiscoDir%${your_fisco_dir}%g" common.properties

# 搭建新链时需配置
fisco.version（节点FISCO-BCOS版本）：sed -i "s%2.0.0%${your_fisco_version}%g" common.properties
node.counts（节点安装个数，不修改的话默认两个）：sed -i "s%nodeCounts%${your_node_counts}%g" common.properties

示例（将端口由5000改为5008）：sed -i "s%5000%5008%g" common.properties
```

## 部署
部署所有服务（使用已有链本命令不会搭建节点）：
```shell
python deploy.py installAll
```
停止所有服务（使用已有链本命令不会停止节点）：
```shell
python deploy.py stopAll
```
服务部署后，如果需要单独启停，可以使用以下命令：
```shell
启动FISCO-BCOS节点:      python deploy.py startNode
停止FISCO-BCOS节点:      python deploy.py stopNode
启动WeBASE-Web:          python deploy.py startWeb
停止WeBASE-Web:          python deploy.py stopWeb
启动WeBASE-Node-Manager: python deploy.py startManager
停止WeBASE-Node-Manager: python deploy.py stopManager
启动WeBASE-Front:        python deploy.py startFront
停止WeBASE-Front:        python deploy.py stopFront
```

**备注：** 

- 部署脚本会拉取相关安装包进行部署，需保持网络畅通。
- 首次部署需要下载编译包和初始化数据库，重复部署时可以根据提示不重复操作
- 部署过程出现问题可以查看[常见问题](#id10)

## 访问

WeBASE管理平台：

```
http://{deployIP}:{webPort}
示例：http://localhost:5000
```

**备注：** 

- 部署服务器IP和管理平台服务端口需对应修改，网络策略需开通
- WeBASE管理平台使用说明请查看[使用手册](https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Console-Suit/index.html#id13)（获取WeBASE管理平台默认账号和密码，并初始化系统配置）

## 日志路径

```
|-- webase-deploy # 一键部署目录
|--|-- log # 部署日志目录
|--|-- webase-web # 管理平台目录
|--|--|-- log # 管理平台日志目录
|--|-- webase-node-mgr # 节点管理服务目录
|--|--|-- log # 节点管理服务日志目录
|--|-- webase-front # 节点前置服务目录
|--|--|-- log # 节点前置服务日志目录
|--|-- nodes # 一件部署搭链节点目录
|--|--|-- 127.0.0.1
|--|--|--|-- node0 # 具体节点目录
|--|--|--|--|-- log # 节点日志目录
```

**备注：** 当前节点日志路径为一件部署搭链的路径，使用已有链请在相关路径查看日志。

## 附录

### Java环境部署

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

### 数据库部署

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
mysql > create database webasenodemanager;
```

### Python部署

- CentOS

  ```
  sudo yum install -y python-requests
  ```

- Ubuntu

  ```
  sudo apt-get install -y python-requests
  ```

### MySQL-python部署

- CentOS

  ```
  sudo yum install -y MySQL-python
  ```

- Ubuntu

  ```
  sudo apt-get install -y python-pip
  sudo pip install MySQL-python
  ```

## 常见问题

### Python命令出错

```
  File "deploy.py", line 62
    print helpMsg
                ^
SyntaxError: Missing parentheses in call to "print". Did you mean print(helpMsg)?
```

答：检查Python版本

### 找不到MySQLdb

```
Traceback (most recent call last):
...
ImportError: No module named MySQLdb
```

答：需要安装MySQL-python，安装请参看 [附录](#mysql-python)

### 安装MySQL-python遇到问题

```
Command "python setup.py egg_info" failed with error code 1
```

答：运行下面两个命令
```
pip install --upgrade setuptools
python -m pip install --upgrade pip
```

### 部署时某个组件失败，重新部署提示端口被占用问题

答：因为有个别组件是启动成功的，需先执行“python deploy.py stopAll”将其停止，再执行“python deploy.py installAll”部署全部。

### 管理平台启动时Nginx报错

```
...
==============      WeBASE-Web      start...  ==============
Traceback (most recent call last):
...
Exception: execute cmd  error ,cmd : sudo /usr/local/nginx/sbin/nginx -c /data/app/webase-deploy/comm/nginx.conf, status is 256 ,output is nginx: [emerg] open() "/etc/nginx/mime.types" failed (2: No such file or directory) in /data/app/webase-deploy/comm/nginx.conf:13
```

答：检查服务器是否安装了nginx，如果未安装，则通过"which nginx"查询nginx文件路径并删除。

### 部署时数据库访问报错

```
...
checking database connection
Traceback (most recent call last):
  File "/data/temp/webase-deploy/comm/mysql.py", line 21, in dbConnect
    conn = mdb.connect(host=mysql_ip, port=mysql_port, user=mysql_user, passwd=mysql_password, charset='utf8')
  File "/usr/lib64/python2.7/site-packages/MySQLdb/__init__.py", line 81, in Connect
    return Connection(*args, **kwargs)
  File "/usr/lib64/python2.7/site-packages/MySQLdb/connections.py", line 193, in __init__
    super(Connection, self).__init__(*args, **kwargs2)
OperationalError: (1045, "Access denied for user 'root'@'localhost' (using password: YES)")
```

答：确认数据库用户名和密码

### 节点sdk目录不存在

```
...
======= FISCO-BCOS sdk dir:/data/app/nodes/127.0.0.1/sdk is not exist. please check! =======
```

答：确认节点安装目录下有没有sdk目录（企业部署工具搭建的链可能没有），如果没有，需手动创建"mkdir sdk"，并将节点证书（ca.crt、node.crt、node.key）复制到该目录，再重新部署。
