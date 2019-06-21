# WeBASE-Codegen-Monkey
[![License](https://img.shields.io/badge/license-Apache%202-4EB1BA.svg)](https://www.apache.org/licenses/LICENSE-2.0.html)
[![Gitter](https://badges.gitter.im/WeBASE-Codegen-Monkey/WeBASE-Codegen-Monkey.svg)](https://gitter.im/WeBASE-Codegen-Monkey/community)

> 道生一，一生二，二生三，三生万物。
> 万物负阴而抱阳，冲气以为和。
> 人之所恶，唯孤、寡、不谷，而王公以为称。
> 故物或损之而益，或益之而损。
> 人之所教，亦我而教人。
> 强梁者不得

## 1. 组件介绍

### 1.1 数据导出组件：WeBASE-Collect-Bee

[WeBASE-Collect-Bee](https://github.com/WeBankFinTech/WeBASE-Collect-Bee/tree/dev_v0.7.0.2019.06)是一个基于[FISCO-BCOS](https://github.com/FISCO-BCOS/FISCO-BCOS)平台的数据导出工具。

数据导出组件[WeBASE-Collect-Bee](https://github.com/WeBankFinTech/WeBASE-Collect-Bee/tree/dev_v0.7.0.2019.06)的目的在于降低获取区块链数据的开发门槛，提升研发效率。研发人员几乎不需要编写任何代码，只需要进行简单配置，就可以把数据导出到指定的存储介质上，比如DB、ES、MQ、Hadoop等，并提供相关服务接口获取数据，以满足业务场景需求。

[WeBASE-Collect-Bee](https://github.com/WeBankFinTech/WeBASE-Collect-Bee/tree/dev_v0.7.0.2019.06)可以导出区块链上的基础数据，如当前块高、交易总量等。

如果正确配置了FISCO-BCOS上运行的所有合约，[WeBASE-Collect-Bee](https://github.com/WeBankFinTech/WeBASE-Collect-Bee/tree/dev_v0.7.0.2019.06)可以导出区块链上这些合约的业务数据，包括event、构造函数、合约地址、执行函数的信息等。

[WeBASE-Collect-Bee](https://github.com/WeBankFinTech/WeBASE-Collect-Bee/tree/dev_v0.7.0.2019.06)提供了基于Restful的API，支持通过http的方式调用这些接口。

### 1.2 代码自动生成组件：WeBASE-Codegen-Monkey

[WeBASE-Collect-Bee](https://github.com/WeBankFinTech/WeBASE-Collect-Bee/tree/dev_v0.7.0.2019.06)易于使用，且功能强大；但是仍有一定的开发门槛。为了更进一步地提升研发效率，我们开发了WeBASE-Codegen-Monkey。只需要在一个配置文件中进行少量简单的配置，同时按照要求提供相关的智能合约信息；当前版本可支持自动生成[WeBASE-Collect-Bee](https://github.com/WeBankFinTech/WeBASE-Collect-Bee/tree/dev_v0.7.0.2019.06)。

### 1.3 使用场景和解决方案

区块链的数据存储在区块链上，需要使用智能合约暴露的接口来进行调用。由于智能合约暴露的接口的限制，区块链上不适合进行复杂的数据查询、大数据分析和数据可视化等工作。因此，我们致力于提供一种智能化、自动化的数据导出和备份的解决方案。

#### 案例 数据可视化后台系统

- 背景

某互联网小贷公司基于FISCO-BCOS开发了区块链借条业务系统，客户之间的借贷合同信息和证明材料都会在脱敏后保存到区块链上。该公司的运营人员需要获得当前业务进展的实时信息和摘要信息。

- 解决方案

该公司使用WeBASE-Codegen-Monkey迅速生成了[WeBASE-Collect-Bee](https://github.com/WeBankFinTech/WeBASE-Collect-Bee/tree/dev_v0.7.0.2019.06)的代码，并根据实际需求进行了定制化开发，在一天之内投入到线上使用。导出到db的数据接入到了该公司的统一监控平台，该公司PM可以在业务后台系统上获得该业务的实时进展，该公司运维人员可以在公司运维监控室的大屏幕实时监控业务系统的状态。

#### 案例 区块链业务数据对账系统

- 背景

某公司基于FISCO-BCOS开发了区块链的业务系统，需要将本地数据与链上的数据进行对账。

- 解决方案

该公司使用WeBASE-Codegen-Monkey迅速生成了[WeBASE-Collect-Bee](https://github.com/WeBankFinTech/WeBASE-Collect-Bee/tree/dev_v0.7.0.2019.06)的代码，并根据实际需求进行了定制化开发。通过在智能合约中设计的各类event，相关的业务数据都被导出到数据库中；从而实现轻松对账的需求。

#### 案例 区块链业务数据查询系统

- 背景

某互联网公司基于FISCO-BCOS开发了区块链的业务系统，但是发现智能合约对业务报表的支持不佳。但是，公司的一线业务部门要求实时查看各类复杂的业务报表。

- 解决方案

该公司使用WeBASE-Codegen-Monkey迅速生成了[WeBASE-Collect-Bee](https://github.com/WeBankFinTech/WeBASE-Collect-Bee/tree/dev_v0.7.0.2019.06)的代码，并根据实际需求进行了定制化开发，区块链上的数据可以实时导出到数据库中。利用[WeBASE-Collect-Bee](https://github.com/WeBankFinTech/WeBASE-Collect-Bee/tree/dev_v0.7.0.2019.06)自带的Restful API，该公司的报表系统实现了和区块链数据的对接，可以获得准实时的各类业务报表。

### 1.4 特性介绍

#### 自动生成数据导出组件

只需用户提供智能合约编译后的Java代码和相关的底层链、数据库的基本信息，WeBASE-Codegen-Monkey就能帮助你自动生成一个区块链数据导出的组件。现阶段，支持将数据导出到Mysql数据库中。

#### 支持自定义导出数据内容

可以支持导出区块链的基本信息、智能合约的函数、Event等信息。可以对导出的数据库表、字段进行定制。也可以修改导出数据字段的长度。

#### 内置Restful API，提供常用的查询功能

自带常用的Restful API，支持查询块高、块信息、Event信息和函数信息等。

#### 支持多数据源，支持读写分离和分库分表

为了应对海量数据的导出，[WeBASE-Collect-Bee](https://github.com/WeBankFinTech/WeBASE-Collect-Bee/tree/dev_v0.7.0.2019.06)数据导出组件支持可配置的多数据源存储，读写分离和分库分表：数据可以存储到多个表中，也可以存储到多个库中。同时，内置的Restful API可以自动无感知地返回正常的数据。

#### 支持多活部署，多节点自动导出

[WeBASE-Collect-Bee](https://github.com/WeBankFinTech/WeBASE-Collect-Bee/tree/dev_v0.7.0.2019.06)数据导出组件支持多活部署，可自动进行分布式任务调度。


#### 支持区块重置导出
[WeBASE-Collect-Bee](https://github.com/WeBankFinTech/WeBASE-Collect-Bee/tree/dev_v0.7.0.2019.06)数据导出组件基于区块高度进行导出，并支持指定高度重新导出数据。

### 支持可视化的监控页面

[WeBASE-Collect-Bee](https://github.com/WeBankFinTech/WeBASE-Collect-Bee/tree/dev_v0.7.0.2019.06)可与grafana深度集成，支持自动生成dashboard实例，让您的链上数据了如指掌。

#### 提供可视化的互动API控制台

[WeBASE-Collect-Bee](https://github.com/WeBankFinTech/WeBASE-Collect-Bee/tree/dev_v0.7.0.2019.06)集成了swagger插件，提供可视化互动API控制台。

![[效果图]](../../images/webase-codegen-monkey/grafana_demo.png)

## 2. 快速开始

### 2.1 前置依赖

在使用本组件前，请确认系统环境已安装相关依赖软件，清单如下：

| 依赖软件 | 说明 |备注|
| --- | --- | --- |
| FISCO-BCOS | >= 2.0， 1.x版本请参考V0.5版本 |
| Bash | 需支持Bash（理论上来说支持所有ksh、zsh等其他unix shell，但未测试）|
| Java | >= JDK[1.8] |JAVA安装可参考附录2|
| Git | 下载的安装包使用Git | Git安装可参考附录3|
| MySQL | >= mysql-community-server[5.7] | MySQL安装可参考附录4|
| zookeeper | >= zookeeper[3.4] | 只有在进行集群部署的时候需要安装，zookeeper安装可参考附录5|
| docker    | >= docker[18.0.0] | 只有需要可视化监控页面的时候才需要安装，docker的安装可参考[docker安装手册](https://docker_practice.gitee.io/install/centos.html) |

### 2.2 部署步骤

#### 2.2.1 获取安装包

##### 2.2.1.1 下载安装包

```shell
#下载安装包
curl -LO https://github.com/WeBankFinTech/WeBASE-Codegen-Monkey/raw/dev_v0.7.0.2019.06/src/main/install_scripts.tar.gz
#解压安装包
tar -zxf install_scripts.tar.gz 
cd install_scripts
```

##### 2.2.1.2 进入安装路径

进入解压后的install_scripts文件夹目录，获得如下的目录结构，其中Evidence.java为合约示例。

```
├──install_scripts
    └── config
        └── contract
            └── Evidence.java
        └── resources
            └── application.properties
    └── generate_bee.sh
```

#### 2.2.2 配置安装包

##### 2.2.2.1 配置合约文件

请注意，请确保你使用的Web3SDK的版本大于等于**V1.2.0**。同时请注意，上链程序所安装的[fisco-solc](https://github.com/FISCO-BCOS/fisco-solc)必须与编译的版本一致。

找到你的业务工程（你要导出数据的那条区块链中，往区块链写数据的工程），复制合约产生的Java文件：请将Java文件**复制到./config/contract目录**下（请先删除目录结构中的合约示例Evidence.java文件）。

如果你的业务工程并非Java工程，那就先找到你所有的合约代码。不清楚如何将Solidity合约生成为Java文件，请参考：[合约代码转换为java代码](https://fisco-bcos-documentation.readthedocs.io/zh_CN/release-1.3/docs/web3sdk/advanced/gen_java_code.html)

请注意:**请勿使用数据库SQL语言的保留字来定义合约内部的变量、函数名定义**，否则会导致数据库无法成功建表。如定义一个变量名为key或定义一个函数为select或delete等。

##### 2.2.2.2 配置密钥文件

复制密钥相关的配置文件：请将你的配置文件**复制到./config/resources目录**下。配置文件包括：

-     ca.crt
-     node.crt
-     node.key

##### 2.2.2.3 配置应用

修改application.properties文件：该文件包含了所有的配置信息。以下配置信息是必须要修改的，否则跑不起来：

```
# 节点的IP及通讯端口、组号。NODE_NAME可以是任意字符和数字的组合
system.nodeStr=[NODE_NAME]@[IP]:[PORT]
system.groupId=[GROUP_ID]
# 最新版本的FISCO-BCOS平台中的NODE_NAME可以为任意值。
# 数据库的信息，暂时只支持mysql；serverTimezone用来设置时区
system.dbUrl=jdbc:mysql://[IP]:[PORT]/[database]?useSSL=false&serverTimezone=GMT%2b8&useUnicode=true&characterEncoding=UTF-8
system.dbUser=[user_name]
system.dbPassword=[password]
# 合约Java文件的包名
monitor.contractPackName=[编译Solidity合约时指定的包名]
```

更多配置详情可参考附件1：配置参数。

#### 2.2.3 生成代码并运行程序

##### 2.2.3.1 选择一：直接在本机运行

```
chmod +x generate_bee.sh
sh generate_bee.sh
```

当前目录下会生成[WeBASE-Collect-Bee](https://github.com/WeBankFinTech/WeBASE-Collect-Bee/tree/dev_v0.7.0.2019.06)工程代码。数据导出组件将直接启动，对应的执行日志会打印到终端上。

请注意:请务必按照以上命令操作，**切莫使用sudo命令来操作**，否则会导致Gradlew没有权限，导致depot数据失败。

##### 2.2.3.2 选择二：本机编译，复制执行包到其他服务器上运行

```
chmod +x generate_bee.sh
sh generate_bee.sh build
```

当前目录下会生成[WeBASE-Collect-Bee](https://github.com/WeBankFinTech/WeBASE-Collect-Bee/tree/dev_v0.7.0.2019.06)工程代码。请将此生成工程下的./WeBASE-Collect-Bee/dist文件夹复制到其他服务器上，并执行：

```
chmod +x *.jar
nohup java -jar *.jar >/dev/null 2>&1 &
tail -f *.log
```

##### 2.2.3.3 选择三：本机编译，复制执行包到其他服务器，使用supervisor来启动。

使用supervisor来守护和管理进程，supervisor能将一个普通的命令行进程变为后台daemon，并监控进程状态，异常退出时能自动重启。
它是通过fork/exec的方式把这些被管理的进程当作supervisor的子进程来启动，这样只要在supervisor的配置文件中，把要管理的进程的可执行文件的路径写进去即可。也实现当子进程挂掉的时候，父进程可以准确获取子进程挂掉的信息的，可以选择是否自己启动和报警。
supervisor还提供了一个功能，可以为supervisord或者每个子进程，设置一个非root的user，这个user就可以管理它对应的进程。
编译生成代码的部署同2.2.3.2

使用supervisor来安装与部署的步骤请参阅附录6

#### 2.2.3 检查运行状态及退出

##### 2.2.3.1 检查程序进程是否正常运行

```
ps -ef |grep WeBASE-Collect-Bee
```

如果看到如下信息，则代表进程执行正常：

```
app   21980 24843  0 15:23 pts/3    00:00:44 java -jar WeBASE-Collect-Bee0.3.0-SNAPSHOT.jar
```

##### 2.2.3.2 检查程序是否已经正常执行

当你看到程序运行，并在最后出现以下字样时，则代表运行成功：

```
Hibernate: select blockheigh0_.pk_id as pk_id1_2_, blockheigh0_.block_height as block_he2_2_, blockheigh0_.event_name as event_na3_2_, blockheigh0_.depot_updatetime as depot_up4_2_ from block_height_info blockheigh0_ where blockheigh0_.event_name=?
Hibernate: select blockheigh0_.pk_id as pk_id1_2_, blockheigh0_.block_height as block_he2_2_, blockheigh0_.event_name as event_na3_2_, blockheigh0_.depot_updatetime as depot_up4_2_ from block_height_info blockheigh0_ where blockheigh0_.event_name=?
Hibernate: select blockheigh0_.pk_id as pk_id1_2_, blockheigh0_.block_height as block_he2_2_, blockheigh0_.event_name as event_na3_2_, blockheigh0_.depot_updatetime as depot_up4_2_ from block_height_info blockheigh0_ where blockheigh0_.event_name=?
```

还可以通过以下命令来查看区块的同步状态：

```
tail -f webasebee.log| grep "sync block"
```

当看到以下滚动的日志时，则代表区块同步状态正常，开始执行下载任务。

```
$ tail -f webasebee.log| grep "sync block"
2019-05-05 14:41:07.348  INFO 60538 --- [main] c.w.w.c.service.CommonCrawlerService     : Try to sync block number 0 to 90 of 90
2019-05-05 14:41:07.358  INFO 60538 --- [main] c.w.w.c.service.BlockTaskPoolService     : Begin to prepare sync blocks from 0 to 90
2019-05-05 14:41:17.142  INFO 60538 --- [main] c.w.w.crawler.service.BlockSyncService   : Block 0 of 90 sync block succeed.
2019-05-05 14:41:17.391  INFO 60538 --- [main] c.w.w.crawler.service.BlockSyncService   : Block 1 of 90 sync block succeed.
2019-05-05 14:41:17.618  INFO 60538 --- [main] c.w.w.crawler.service.BlockSyncService   : Block 2 of 90 sync block succeed.
2019-05-05 14:41:18.072  INFO 60538 --- [main] c.w.w.crawler.service.BlockSyncService   : Block 3 of 90 sync block succeed.
2019-05-05 14:41:18.395  INFO 60538 --- [main] c.w.w.crawler.service.BlockSyncService   : Block 4 of 90 sync block succeed.
2019-05-05 14:41:18.796  INFO 60538 --- [main] c.w.w.crawler.service.BlockSyncService   : Block 5 of 90 sync block succeed.
2019-05-05 14:41:19.008  INFO 60538 --- [main] c.w.w.crawler.service.BlockSyncService   : Block 6 of 90 sync block succeed.
2019-05-05 14:41:19.439  INFO 60538 --- [main] c.w.w.crawler.service.BlockSyncService   : Block 7 of 90 sync block succeed.
2019-05-05 14:41:20.303  INFO 60538 --- [main] c.w.w.crawler.service.BlockSyncService   : Block 8 of 90 sync block succeed.
2019-05-05 14:41:20.512  INFO 60538 --- [main] c.w.w.crawler.service.BlockSyncService   : Block 9 of 90 sync block succeed.
2019-05-05 14:41:20.738  INFO 60538 --- [main] c.w.w.crawler.service.BlockSyncService   : Block 10 of 90 sync block succeed.
……
```

##### 2.2.3.3 检查数据是否已经正常产生

你也可以通过DB来检查，登录你之前配置的数据库，看到自动创建完表的信息，以及表内开始出现数据内容，则代表一切进展顺利。如你可以执行以下命令：

```
# 请用你的配置信息替换掉[]里的配置，并记得删除[]
mysql -u[用户名] -p[密码] -e "use [数据库名]; select count(*) from block_detail_info"
```

如果查询结果非空，出现类似的如下记录，则代表导出数据已经开始运行：

```
+----------+
| count(*) |
+----------+
|      633 |
+----------+
```

##### 2.2.3.4 停止导入程序

```
ps -ef |grep WeBASE-Collect-Bee |grep -v grep|awk '{print $2}' |xargs kill -9
```

恭喜您，到以上步骤，您已经完成了数据导出组件的安装和部署。如果您还需要额外获得可视化的监控页面，请参考2.3

### 2.3 可视化监控程序安装和部署

#### 2.3.1 安装软件

首先，请安装docker，docker的安装可参考[docker安装手册](https://docker_practice.gitee.io/install/centos.html)
等docker安装成功后，请下载grafana：

```
docker pull grafana/grafana
```

如果你是使用sudo用户安装了docker，可能会提示『permission denied』的错误，建议执行:

```
sudo docker pull grafana/grafana
```

#### 2.3.2 启动grafana

```
docker run   -d   -p 3000:3000   --name=grafana   -e "GF_INSTALL_PLUGINS=grafana-clock-panel,grafana-simple-json-datasource"   grafana/grafana
```

grafana将自动绑定3000端口并自动安装时钟和Json的插件。

#### 2.3.3 登录grafana界面

直接使用浏览器访问：http://your_ip:3000/，请注意使用你机器的IP替换掉your_ip，默认的用户名和密码为admin/admin

#### 2.3.4 添加MySQL数据源

在正常登录成功后，如图所示，选择左边栏设置按钮，点击『Data Sources』，选择『MySQL』数据源，随后按照提示的页面，配置 Host， Database， User 和 Password等。

![[添加步骤]](../../images/webase-codegen-monkey/add_datasource.png)

#### 2.3.5 导入Dashboard模板

WeBASE-Codegen-Monkey会自动生成数据的dashboard模板，数据的路径位于：WeBASE-Collect-Bee/src/main/scripts/grafana/default_dashboard.json，请点击左边栏『+』，选择『import』，点击绿色按钮『Upload.json File』,选择刚才的WeBASE-Collect-Bee/src/main/scripts/grafana/default_dashboard.json文件，最后，点击『import』按钮。

![[导入步骤]](../../images/webase-codegen-monkey/import_json.png)

如果导入成功，dashboards下面会出现『FISCO-BCOS区块链监控视图』，您可以选择右上方的时间按钮来选择和设置时间范围及刷新时间等。您也可以选中具体的页面组件进行编辑，自由地移除或挪动组件的位置，达到更好的使用体验。

更多关于Grafana的自定义配置和开发文档，可参考[Grafana官方文档](http://docs.grafana.org/guides/getting_started/)


