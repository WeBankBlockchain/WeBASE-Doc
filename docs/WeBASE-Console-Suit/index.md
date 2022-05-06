# WeBASE管理平台使用手册

## 概览

### 基本描述

WeBASE管理平台是由四个WeBASE子系统组成的一套管理FISCO-BCOS联盟链的工具集。

### 主要功能

1. 区块链数据概览
2. 节点管理
3. 合约管理
4. 私钥管理
5. 系统管理
6. 系统监控
7. 交易审计
8. 订阅事件
9. 账号管理
10. 移动端管理台
11. 数据监控大屏

![](../../images/WeBASE-Console-Suit/overview_2.png)

### 部署架构

这套管理工具主要由：节点前置，签名服务，节点管理，WeBASE管理平台四个WeBASE子系统构成。WeBASE四个服务的部署架构如下图：节点前置需要和区块链节点部署在同一台机器；节点管理和WeBASE管理平台可以同机部署，也可以分开部署。

<img src="../../_images/Framework_2.png" width="700">


## 使用前提

### 群组搭建

区块链浏览器展示的数据是从区块链上同步下来的。为了同步数据需要初始化配置（添加群组信息和节点信息），故在同步数据展示前需要用户先搭建好区块链群组。[FISCO-BCOS 2.0](https://github.com/FISCO-BCOS/FISCO-BCOS.git)提供了多种便捷的群组搭建方式。

1. 如果是开发者进行开发调试，建议使用[build_chain](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/manual/build_chain.html)。
2. 如果是开发企业级应用，建议使用企业部署工具[FISCO-BCOS generator](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/enterprise_tools/index.html)。

两者的主要区别在于build_chain为了使体验更好，搭建速度更快，辅助生成了群组内各个节点的私钥；但企业部署工具出于安全的考虑不辅助生成私钥，需要用户自己生成并设置。

##### Liquid支持

如果使用的`liquid`合约的链，并在WeBASE管理台或WeBASE-Front的合约IDE中编译Liquid合约，要求**手动**在WeBASE-Front所在主机配置Liquid环境，可参考WeBASE-Front节点前置文档中的[Liquid配置](../WeBASE-Front/liquid.md)或[Liquid官方配置文档](https://liquid-doc.readthedocs.io/zh_CN/latest/docs/quickstart/prerequisite.html)

配置好Liquid环境后，需要重启WeBASE-Front

### WeBASE管理平台搭建

WeBASE管理平台分为四个部分：节点前置，签名服务，节点管理，WeBASE管理台。

当前版本我们提供了三种搭建方式：[**一键搭建**](../WeBASE/install.md)、纯手动搭建各子系统、[可视化部署](../WeBASE-Install/visual_deploy.md)。

#### 1、一键搭建

适合同机部署，快速体验的情况使用。具体搭建流程参见[**安装文档**](../WeBASE/install.md)。

#### 2、手动搭建

##### 2.1、签名服务搭建

签名服务使用Spring Boot的JAVA后台服务，具体搭建流程参见[《签名服务安装说明》](../WeBASE-Sign/install.md)。

##### 2.2、节点前置搭建

节点前置使用Spring Boot的JAVA后台服务，具体搭建流程参见[《节点前置安装说明》](../WeBASE-Front/install.md)。

##### 2.3、节点管理搭建

节点管理使用Spring Boot的JAVA后台服务，具体搭建流程参见[《节点管理安装说明》](../WeBASE-Node-Manager/install.md)。

##### 2.4、WeBASE管理平台

WeBASE管理台使用框架`vue-cli`，具体搭建流程参见[《WeBASE管理平台安装说明》](../WeBASE-Web/install.md)。

## 系统初始化配置

服务搭建成功后，可使用网页浏览器访问nginx配置的WeBASE管理台IP和端口(例如`127.0.0.1:5000`)，进入到管理平台页面。

管理平台默认用户为`admin`，默认密码为`Abcd1234`（第一次登陆成功后会要求重置密码，请按照密码标准设置一个更加安全的密码）。

### 添加节点前置

未初始化节点前置的管理平台，会引导去节点管理页面添加节点前置。
- 节点前置服务需要填写前置的IP与端口（默认为`127.0.0.1`和`5002`），机构名则根据实际自定义填写

<!-- ![](../../images/WeBASE-Console-Suit/node_manager_add_front.png) -->
![](../../images/WeBASE-Console-Suit/lab/new_front.png)


前置添加完成后，管理平台就会开始拉取群组信息和群组的区块信息。此时数据概览页面应该就有数据了。为了解析和审计区块数据，需要把相关的合约和用户导入到管理平台。具体看下面两个小节。

### 合约管理

#### 1、添加合约

管理平台提供两种添加合约的方式，一个是新建一个合约，一个是导入已有合约。同时合约编辑器还提供新建目录。用目录的形式管理合约，主要是为了解决同名合约引用的问题。合约添加完成后，需要编译保存。

![](../../images/WeBASE-Console-Suit/contract_add_2.png)

#### 2、部署合约

合约编译时会自动保存合约内容，编译成功后可以执行合约部署。

![](../../images/WeBASE-Console-Suit/contract_compile_deploy_2.png)

#### 3、合约调用

在合约部署成功后，可以在合约IDE页面的右上角点击发交易，向合约发送交易进行合约调用。

![](../../images/WeBASE-Console-Suit/contract_send_transaction.png)

交易发送成功后，将返回交易回执。可以在数据概览-交易列表-更多中根据transactionHash搜索交易，通过交易解析和Event解析查看可视化的交易回执信息。具体操作方法参考下文的区块链数据概览章节中的交易解析与Event解析。(注：Liquid合约的交易暂未支持交易解析）

![](../../images/WeBASE-Console-Suit/transaction_output.png)

### 私钥管理

私钥管理提供了新建私钥用户和导入公钥用户两种用户导入方式。第一种方式主要用于新建用户（私钥托管在签名服务中），在管理平台的合约管理中部署和调用合约。第二种方式主要用于把交易和用户关联起来。

![](../../images/WeBASE-Console-Suit/key_manager_tx_audit.png)

## 各模块的详细介绍

本小节概要介绍管理平台的各个模块，方便大家对WeBASE管理平台套件有一个整体的认识。这套工具集主要提供的管理功能有：

### 区块链数据概览

数据概览页面，展示了区块链的核心数据指标：节点个数，区块数量，交易数量，通过管理台部署的合约数量。关键监控指标：历史15天的交易量。
- 节点信息列表：展示了节点的ID，节点块高，节点view和运行状态；
- 区块信息列表：展示了最近5个块的概览信息，点击更多可以查看更多历史区块；
- 交易信息列表：展示了最近5个交易的概览信息，点击更多可以查看更多历史交易；

![](../../images/WeBASE-Console-Suit/overview_2.png)

其中右下角的交易信息列表点击可跳入具体一条交易中查看交易详细信息：交易详细信息还包含了
- 交易解析：可以将交易返回的交易回执数据进行解析并可视化；
- Event解析：可以将交易返回的Event数据进行解析并可视化；

未解析的raw数据如下图所示：

![](../../images/WeBASE-Console-Suit/transaction_analysis_raw.png)

进行交易解析后如下图所示：(注：Liquid合约的交易暂未支持交易解析）

![](../../images/WeBASE-Console-Suit/transaction_analysis.png)

同样的，Event数据解析后可以看到：(注：Liquid合约的交易暂未支持交易解析）

![](../../images/WeBASE-Console-Suit/transaction_event.png)

### 节点管理

节点管理主要提供了前置列表、节点列表、修改节点共识状态的功能。

用户可以通过新增节点前置，把新的节点前置添加到前置列表。系统会默认拉取这些前置所在的群组和各个群组的节点信息。在节点列表中，用户可以修改节点的共识状态：共识节点、观察节点、游离节点。其中修改为游离节点相当于将节点移出群组，停止节点前务必先将节点设置为游离节点，否则将触发节点异常。

前置列表与节点管理：
- 前置列表：可以查看节点前置状态，导出前置的SDK证书zip包
- 节点管理：显示所有的共识/观察节点（无论运行或停止），以及正在运行的游离节点

![](../../images/WeBASE-Console-Suit/front_node_manage.png)


修改节点共识状态：

![](../../images/WeBASE-Console-Suit/node_manager_edit.png)

### 合约管理

合约管理提供了一个图形化的合约IDE环境、已部署的合约列表、合约仓库等功能。

图形化合约IDE提供了一整套的合约管理工具：新建合约，保存合约，编译合约，部署合约，调用合约接口。其中，新建合约可以通过编辑键入合约内容，也可以上传合约文件；编译合约后才可以部署合约；部署合约成功后，可以通过发送交易调用合约接口。具体操作步骤可以参考上一章节中系统初始化配置介绍。

合约IDE：
- 进行Liquid合约编译需要在WeBASE-Front所在主机配置Liquid环境，可参考WeBASE-Front节点前置文档中的[Liquid配置](../WeBASE-Front/liquid.md)或参考[Liquid环境配置](https://liquid-doc.readthedocs.io/zh_CN/latest/docs/quickstart/prerequisite.html)进行配置后方可使用。
- 若当前群组属于Liquid群组（Wasm群组），合约IDE将自动切换至Liquid编译模式，并自动检查是否已在节点前置所在主机配置Liquid环境。

![](../../images/WeBASE-Console-Suit/contract_ide.png)

合约列表：包含WeBASE已登记合约与链上已部署的合约

已登记合约：包含通过IDE部署的合约、导入ABI的合约

<!-- ![](../../images/WeBASE-Console-Suit/contract_list.png) -->
![](../../images/WeBASE-Console-Suit/lab/contract_list.png)

链上全量合约：包含通过其他平台部署到链上的合约与WeBASE已登记的合约（链上合约只有合约地址），可通过导入按钮，填入合约ABI导入到本地

![](../../images/WeBASE-Console-Suit/contract_list_all.png)


ABI编码：支持对ABI的方法与入参进行编码

![](../../images/WeBASE-Console-Suit/abi_analysis.png)

### 私钥管理

私钥管理包含新建私钥用户和新建公钥用户两个功能。在合约管理界面，可以看到合约部署和交易调用功能。这里的私钥管理可以新建私钥用户，私钥将托管在签名服务中，然后通过签名服务对合约部署和合约调用进行签名。注：外部账户可通过新建公钥账户导入，主要用于把交易和用户关联起来。

私钥管理：包含WeBASE本地已登记的私钥用户与链上全量私钥用户。

已登记私钥：包含本地创建的私钥与导入的私钥

![](../../images/WeBASE-Console-Suit/private_key.png)

链上全量私钥：包含链上私钥和本地已登记的私钥，可通过导入按钮，作为公钥用户导入到本地

![](../../images/WeBASE-Console-Suit/private_key_all.png)

添加私钥用户：

![](../../images/WeBASE-Console-Suit/key_manager_add_user_2.png)

导入私钥：支持导入.txt/.pem/.p12格式及明文的私钥，其中.txt私钥可由WeBASE-Front导出，.pem/.p12私钥可由console控制台导出。如果需要导入自定义私钥，可根据节点前置导出的.txt私钥，编辑其中的privateKey字段内容。

![](../../images/WeBASE-Console-Suit/import_private.png)

导出私钥：可以选中导出.txt/.pem/.p12/WeID等格式的私钥，其中WeID格式私钥为十进制明文私钥，txt则是十六进制明文私钥；在代码中加载私钥可以参考[节点前置-私钥加载](../WeBASE-Front/appendix.html#loadKey)

![](../../images/WeBASE-Console-Suit/export_private.png)


### 系统管理

系统管理目前支持权限管理、系统配置管理、证书管理的功能。

**权限管理**：在FISCO BCOS3.0中，链上角色按照不同的权责可划分为三类：治理角色、合约管理员角色和用户角色，三种角色依次进行管理和被管理。详情可参考[FISCO BCOS权限治理体系设计](https://fisco-bcos-doc.readthedocs.io/zh_CN/latest/docs/design/committee_design.html)和[FISCO BCOS权限治理使用指南](https://fisco-bcos-doc.readthedocs.io/zh_CN/latest/docs/develop/committee_usage.html)

值得注意的是，在区块链初始化启动之前，在配置中必须**开启并设置好权限治理的配置**，才能正确启动权限治理模式。区块链启动后再配置将不起作用。详细方法参考[FISCO BCOS权限治理使用指南](https://fisco-bcos-doc.readthedocs.io/zh_CN/latest/docs/develop/committee_usage.html)
- 开启权限治理模式的主要要点是：将`is_auth_check`选项置为`true`，`auth_admin_account`初始委员会账户地址需要配置正确的地址。FISCO BCOS不同的节点部署模式，开启权限治理的方式略有不同
- 开启权限后，需要**在WeBASE权限管理中导入对应的链管理员私钥**

![](../../images/WeBASE-Console-Suit/lab/permission_home.png)


**系统配置管理**：系统属性包含FISCO-BCOS链的tx_count_limit和tx_gas_limit两种属性值的配置。注：一般不建议随意修改tx_count_limit和tx_gas_limit，如下情况可修改这些参数：
- 机器网络或CPU等硬件性能有限：调小tx_count_limit，降低业务压力； 
- 业务逻辑太复杂，执行区块时gas不足：调大tx_gas_limit。

配置管理：

![](../../images/WeBASE-Console-Suit/system_config.png)

配置系统属性值：

![](../../images/WeBASE-Console-Suit/system_config_edit.png)

**证书管理**：支持导入和查看证书信息，包括查看Front对应节点的链证书、机构证书、节点证书，可查看证书内容、证书有效期、证书链关系等信息；
- 证书链关系可通过比对父证书指纹与证书指纹查找；
- 平台将默认加载所有Front的证书，需要在Webase-Front配置文件中配置nodePath节点路径；

FISCO-BCOS证书说明可以参考FISCO-BCOS使用手册的[证书说明](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/manual/certificates.html)

证书列表：
- 支持导出SDK证书：v1.5.0后支持导出节点前置的SDK证书zip包，可用于连接节点

![](../../images/WeBASE-Console-Suit/cert_manage.png)

导入证书：

![](../../images/WeBASE-Console-Suit/cert_manage_add.png)

### 系统监控

系统监控包含了**监控**与**异常告警**两部分；

监控主要包括节点监控和主机监控，可以选择节点、时间范围等条件进行筛选查看：
- 节点监控主要有区块高度，pbftview，待打包交易；
- 主机监控主要有主机的CPU，内存，网络和硬盘IO；

节点监控：

![](../../images/WeBASE-Console-Suit/node_monitor.png)

主机监控：

![](../../images/WeBASE-Console-Suit/host_mornitor_2.png)

异常告警部分主要包括**邮件服务配置**和**告警类型配置**：

**邮件服务配置：**
<span id="mail-config"></span>

如何配置邮件服务可查看本文档末尾的[附录-配置邮件服务指南](#mail-use)

可配置邮件告警所用到的邮件服务器相关参数，包含邮件协议类型protocol、邮件服务器地址host、服务使用端口port、用户邮箱地址username、用户邮箱授权码password；鉴权选项包含Authentication验证开关authentication（默认开启）；
- 邮件告警的邮箱协议类型默认使用SMTP协议，使用25默认端口，默认使用username/password进行用户验证，目前仅支持通过TLS/SSL连接邮件服务器；
- 目前仅支持更新原有的邮件服务器配置，不支持新增配置；

```eval_rst
.. important::
	使用测试功能前，需要到“告警类型配置”中，在左上角**开启邮件服务总开关**；
```

注：邮件告警功能需要确保邮件服务器配置正确；务必使用`测试`按键，向指定的邮箱地址发送测试邮件并查收邮件。如果配置错误，将发送测试邮件失败，指定邮箱将收不到测试邮件；

![](../../images/WeBASE-Console-Suit/mail_server_config.png)

邮件服务配置测试：

以当前表单中输入的配置值发送测试邮件（无论是否已保存，都以表单中当前的值为配置发送测试邮件）；**需要提前开启邮件服务开关**；

![](../../images/WeBASE-Console-Suit/mail_server_config_test.png)


**告警类型配置（告警邮件配置）：**

包含了告警类型的配置，告警日志的查看；可配置告警类型的参数值，包含告警邮件标题ruleName，告警邮件内容alertContent，告警邮件发送时间间隔alertIntervalSeconds（单位：秒），上次告警时间lastAlertTime，目标告警邮箱地址userList，是否启用该类型的邮件告警enable，告警等级alertLevel等；
- 包含了节点状态告警、审计告警、证书有效期告警三种；
- 目前仅支持更新原有的三个邮件告警的配置，不支持新增配置；
- 需要先在左上角**开启邮件服务**才可以开启各个类型的邮件告警以及发送测试邮件；

包含了不同告警类型的配置，左上角可以开启邮件服务（作为告警邮件的全局开关），点击告警标题可查看详细配置内容；

下方则是告警日志的内容，可查看告警邮件的具体内容；告警项已处理后，可以点击确认键确认已消除异常；

其中在WeBASE-Node-Manager的配置文件application.yml的constant可以配置定时任务定时监控节点状态、审计状态、证书有效期的频率，监控到异常状态时将触发邮件告警，发送告警邮件到联系人邮箱，同时按配置的间隔时间定时重复发送告警邮件，直到异常状态消除；

**注：定时任务的频率为检查系统是否异常的频率，而配置不同的告警类型中的告警时间间隔是发送告警邮件的频率**，如，设置检查频率为1h，配置的告警频率为6h，那么，系统会每小时检查一次系统状态，若出现异常，在定时任务检查到异常时，距离上次告警邮件超过6小时，则会发送一次告警邮件。

![](../../images/WeBASE-Console-Suit/alert_rule.png)

点击修改可以修改配置项的值，启用/禁用不同类型的告警，修改配置后不需要重启即可生效；

注：修改告警内容时，大括号`{}`以及里面的变量名不可去除，否则无法正常发送告警邮件。

![](../../images/WeBASE-Console-Suit/alert_rule_edit.png)

### 交易审计

联盟链中各个机构按照联盟链委员会制定的规章在链上共享和流转数据。这些规章往往是字面的，大家是否遵守缺乏监管和审计。因此为了规范大家的使用方式，避免链的计算资源和存储资源被某些机构滥用，急需一套服务来辅助监管和审计链上的行为。交易审计就是结合上面的区块链数据，私钥管理和合约管理三者的数据，以区块链数据为原材料，以私钥管理和合约管理为依据做的一个综合性的数据分析功能。交易审计提供可视化的去中心化合约部署和交易监控、审计功能，方便识别链资源被滥用的情况，为联盟链治理提供依据。

交易审计主要指标：

| 主要指标             | 指标描述                                                     |
| :------------------- | ------------------------------------------------------------ |
| 用户交易总量数量统计 | 监控链上各个外部交易账号的每日交易量                         |
| 用户子类交易数量统计 | 监控链上各个外部交易账号的每种类型的每日交易量               |
| 异常交易用户监控     | 监控链上出现的异常交易用户（没在区块链中间件平台登记的交易用户） |
| 异常合约部署监控     | 监控链上合约部署情况，非白名单合约（没在区块链中间件平台登记的合约）记录 |

用户交易审计：可以指定用户、时间范围、交易接口进行筛选查看交易

![](../../images/WeBASE-Console-Suit/tx_audit_user_tx.png)

异常用户审计：

![](../../images/WeBASE-Console-Suit/abnormal_user.png)

异常合约审计：

![](../../images/WeBASE-Console-Suit/abnormal_contract.png)

### 订阅事件

订阅事件管理：可查看前置中已订阅的链上事件通知，包括出块事件列表和合约Event事件列表。详情请参考[节点前置-链上事件订阅和通知](../WeBASE-Front/appendix.html#event_subscribe)

出块事件列表：

![](../../images/WeBASE-Console-Suit/event_new_block.png)

合约Event事件列表：
![](../../images/WeBASE-Console-Suit/event_contract_event.png)

### 账号管理

账号管理提供管理台登陆账号的管理功能。管理台用户分为三种角色：
- 普通用户，只有查看权限；

- 管理员用户，拥有管理平台的读写权限；

- 开发者用户，拥有开发者自身的合约和私钥用户的读写权限，数据概览权限；

  开发者模式默认关闭。如需开启此功能，可以在WeBASE-Node-Manager配置文件application.yml中修改developerModeEnable为true，然后重启服务。

  ![](../../images/WeBASE-Console-Suit/developer_mode_enable.png)

注：此处账号与私钥管理的私钥用户为两种不同的概念，账号用于管理台权限控制，私钥用户为区块链账户。

账号管理：

![](../../images/WeBASE-Console-Suit/login_user_manager_2.png)

添加登陆账号并指定账号类型：

![](../../images/WeBASE-Console-Suit/login_user_add_2.png)


### 移动端管理台

移动端管理台：支持区块链数据概览、链上合约、链上用户、节点列表、区块列表和交易列表的展示
- 在移动端设备访问WeBASE时将自动切换到移动端管理台页面

![](../../images/WeBASE-Console-Suit/web_mobile.png)

### 数据监控大屏

数据监控大屏页面的入口位于WeBASE管理台的左上角，点击“数据大屏”即可进入数据监控大屏，适用于企业级控制中心需要全局监控链状态数据的场景。
- 数据大屏每次仅展示单个群组的数据，并定时访问后台刷新数据。

![](../../images/WeBASE-Console-Suit/lab/big_screen_lab.png)

在“节点管理”中，可以点击节点列表中的“备注”按钮，为数据大屏中的节点配置IP地址、机构名与城市。

![](../../images/WeBASE-Console-Suit/ecc_node_desc.png)

在右上角的“群组管理”中，可以点击群组列表的“备注”按钮，为数据大屏中的群组配置群组应用名（标题）

![](../../images/WeBASE-Console-Suit/ecc_group_desc.png)


## 升级兼容说明


WeBASE-Front升级至最新版，可查看[节点前置升级说明](../WeBASE-Front/upgrade.md)，请结合[WeBASE-Front Changelog](https://github.com/WeBankBlockchain/WeBASE-Front)进行阅读

WeBASE-Node-Manager升级至最新版，可查看[节点管理服务升级说明](../WeBASE-Node-Manager/upgrade.md)，请结合[WeBASE-Node-Manager Changelog](https://github.com/WeBankBlockchain/WeBASE-Node-Manager)进行阅读

WeBASE-Sign升级至最新版，可查看[签名服务升级说明](../WeBASE-Sign/upgrade.md)，请结合[WeBASE-Sign Changelog](https://github.com/WeBankBlockchain/WeBASE-Sign)进行阅读

## 附录

### 配置邮件服务指南 
<span id="mail-use"></span>

请先阅读本文档中管理平台使用手册的[各模块的详细介绍-系统监控-邮件服务配置](#mail-config)

问：邮件服务怎么用？

答：在后台搭建邮件服务（邮箱服务器），用于后台监控到系统异常情况时，发送告警邮件到指定邮箱，方便运维；

下面介绍具体的使用方法：

邮件服务所使用的邮箱服务器：
1. 企业可使用自行搭建的邮箱服务器；
2. 普通用户可以使用QQ邮箱、网易邮箱等第三方邮箱；

#### 开通邮箱服务

163邮箱开通邮箱服务：

- 登陆邮箱后，在邮箱的`设置`中找到包含`SMTP`的设置项；

![](../../images/WeBASE-Console-Suit/mail_guide_setting_163.png)

- 勾选`IMAP/SMTP`和`POP3/SMTP`，初次开启时，会提醒用户设置**授权码**，并进行手机安全验证；
- 设置授权码后，勾选`IMAP`, `POP3`, `SMTP`开启全部服务；

![](../../images/WeBASE-Console-Suit/mail_guide_163.png)

QQ邮箱开通邮箱服务：

- 登陆邮箱后，在邮箱的`设置账户`中找到`POP3/IMAP/SMTP/Exchange/CardDAV/CalDAV服务`项；

![](../../images/WeBASE-Console-Suit/mail_guide_setting_qq.png)

- 开启`POP3/SMTP服务`和`IMAP/SMTP服务`并按照指引进行手机安全验证并设置授权码，；


#### 配置邮件服务

记下所设置的**授权码**，授权码即邮件服务中用到的“密码”，按照本文档[各模块介绍-系统监控](#mail-config)进行配置：

第一步，进入“告警类型配置”中，点击左上角“启用告警”以**开启邮件服务开关**

![](../../images/WeBASE-Console-Suit/alert_rule.png)

第二步，进入“邮件告警配置”，配置邮件服务

- 因为Node-Manager仅使用邮箱服务器的发件服务，因此**协议类型**填写`smtp`（IMAP/POP3均为收件服务协议）；
- 邮箱服务器填写`smtp.xx.com`，端口号默认为`25`即可启用邮件服务；如需使用其他端口如465则需要开放WeBASE-Node-Manager所在服务器的相应端口限制；
- 用户名填写邮箱地址，密码填写上文设置的**授权码**；

![](../../images/WeBASE-Console-Suit/mail_server_config.png)

配置完成后，点击“测试”后，输入接收测试邮件的邮箱地址，测试成功即可“保存”邮件服务的配置；

![](../../images/WeBASE-Console-Suit/mail_server_config_test.png)

#### 注意事项

“邮件告警配置”中填写的端口默认为25，在不同服务器环境和不同邮箱所需的端口号有所差异，如果需要开启SSL进行邮箱安全验证则需要开通服务器防火墙相应的端口号。

目前已知的包含：
- SMTP协议：默认使用25端口(非SSL)，SSL默认465端口(SSL)或587端口(TLS)
- POP3/IMAP协议：因为邮箱服务使用的是发邮件功能，未用到POP3或IMAP收件协议，此处仅作端口说明：其中POP3默认110端口(非SSL)和995端口(SSL)，IMAP默认143端口(非SSL)和993端口(SSL)
- 126邮箱的SSL端口除了587，还可尝试994；在阿里云下25端口被禁用，请尝试587端口或其他端口；
