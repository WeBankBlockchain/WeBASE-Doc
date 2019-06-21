# WeBASE-Codegen-Monkey
[![License](https://img.shields.io/badge/license-Apache%202-4EB1BA.svg)](https://www.apache.org/licenses/LICENSE-2.0.html)
[![Gitter](https://badges.gitter.im/WeBASE-Codegen-Monkey/WeBASE-Codegen-Monkey.svg)](https://gitter.im/WeBASE-Codegen-Monkey/community)

> 道生一，一生二，二生三，三生万物。
> 万物负阴而抱阳，冲气以为和。
> 人之所恶，唯孤、寡、不谷，而王公以为称。
> 故物或损之而益，或益之而损。
> 人之所教，亦我而教人。
> 强梁者不得其死——吾将以为教父。
> -- 老子
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
[WeBASE-Collect-Bee](https://github.com/WeBankFinTech/WeBASE-Collect-Bee/tree/dev_v0.7.0.2019.06)集成了swagger插件，提供可视化互动API控制台
![效果图](https://github.com/WeBankFinTech/WeBASE-Codegen-Monkey/blob/dev_v0.7.0.2019.06/photos/grafana_demo.png)
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
