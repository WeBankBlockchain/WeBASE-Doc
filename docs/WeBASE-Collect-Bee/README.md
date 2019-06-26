# 概要介绍
[![License](https://img.shields.io/badge/license-Apache%202-4EB1BA.svg)](https://www.apache.org/licenses/LICENSE-2.0.html)
[![Gitter](https://badges.gitter.im/WeBASE-Collect-Bee/WeBASE-Collect-Bee.svg)](https://gitter.im/WeBASE-Collect-Bee/community)


> 穿花度柳飞如箭，
> 粘絮寻香似落星。
> 小小微躯能负重，
> 器器薄翅会乘风。
> -- 吴承恩

## 1. 组件介绍

### 1.1 组件介绍
WeBASE-Collect-Bee 是一个基于[FISCO-BCOS](https://github.com/FISCO-BCOS/FISCO-BCOS)平台的数据导出工具。

数据导出组件WeBASE-Collect-Bee的目的在于降低获取区块链数据的开发门槛，提升研发效率。研发人员几乎不需要编写任何代码，只需要进行简单配置，就可以把数据导出到Mysql数据库。

WeBASE-Collect-Bee可以导出区块链上的基础数据，如当前块高、交易总量等。如果正确配置了FISCO-BCOS上运行的所有合约，WeBASE-Collect-Bee可以导出区块链上这些合约的业务数据，包括event、构造函数、合约地址、执行函数的信息等。

数据导出组件支持多数据源、分库分表、读写分离、分布式部署。

WeBASE-Collect-Bee提供了基于Restful的API，支持通过http的方式调用这些接口。

WeBASE-Collect-Bee还集成了Swagger组件，提供了可视化的文档和测试控制台。

你可以通过[WeBASE-Codegen-Monkey](https://github.com/WeBankFinTech/WeBASE-Codegen-Monkey/tree/dev_v0.7.0.2019.06)来自动生成本工程，只需要在一个配置文件中进行少量简单的配置，同时按照要求提供相关的智能合约信息；我们推荐这种方式。

### 1.2 使用场景和解决方案

区块链的数据存储在区块链上，需要使用智能合约暴露的接口来进行调用。由于智能合约暴露的接口的限制，区块链上不适合进行复杂的数据查询、大数据分析和数据可视化等工作。因此，我们致力于提供一种智能化、自动化的数据导出和备份的解决方案。

#### 案例 数据可视化后台系统

- 背景

某互联网小贷公司基于FISCO-BCOS开发了区块链借条业务系统，客户之间的借贷合同信息和证明材料都会在脱敏后保存到区块链上。该公司的运营人员需要获得当前业务进展的实时信息和摘要信息。

- 解决方案

该公司使用[WeBASE-Codegen-Monkey](https://github.com/WeBankFinTech/WeBASE-Codegen-Monkey/tree/dev_v0.7.0.2019.06)迅速生成了WeBASE-Collect-Bee的代码，并根据实际需求进行了定制化开发，在一天之内投入到线上使用。

导出到db的数据接入到了该公司的统一监控平台，该公司PM可以在业务后台系统上获得该业务的实时进展，该公司运维人员可以在公司运维监控室的大屏幕实时监控业务系统的状态。

#### 案例 区块链业务数据对账系统

- 背景

某公司基于FISCO-BCOS开发了区块链的业务系统，需要将本地数据与链上的数据进行对账。

- 解决方案

该公司使用[WeBASE-Codegen-Monkey](https://github.com/WeBankFinTech/WeBASE-Codegen-Monkey/tree/dev_v0.7.0.2019.06)迅速生成了WeBASE-Collect-Bee的代码，并根据实际需求进行了定制化开发。通过在智能合约中设计的各类event，相关的业务数据都被导出到数据库中；从而实现轻松对账的需求。

#### 案例 区块链业务数据查询系统

- 背景

某互联网公司基于FISCO-BCOS开发了区块链的业务系统，但是发现智能合约对业务报表的支持不佳。但是，公司的一线业务部门要求实时查看各类复杂的业务报表。

- 解决方案

该公司使用[WeBASE-Codegen-Monkey](https://github.com/WeBankFinTech/WeBASE-Codegen-Monkey/tree/dev_v0.7.0.2019.06)迅速生成了WeBASE-Collect-Bee的代码，并根据实际需求进行了定制化开发，区块链上的数据可以实时导出到数据库中。利用WeBASE-Collect-Bee自带的Restful API，该公司的报表系统实现了和区块链数据的对接，可以获得准实时的各类业务报表。

### 1.3 特性介绍

#### 可自动生成代码

可使用[WeBASE-Codegen-Monkey](https://github.com/WeBankFinTech/WeBASE-Codegen-Monkey/tree/dev_v0.7.0.2019.06)生成的代码和配置文件，自动组装成数据导出工程实例

#### 支持灵活的数据库策略

集成sharding-jdbc组件，支持多数据源、分库分表、读写分离

#### 支持集群部署和分布式任务调度

集成elstic-job开源组件，支持灵活的分布式部署和任务调度

#### 可定制化的数据导出策略

提供灵活的可配置的区块、交易、事件、账户等数据导出功能，过滤不需要的数据

#### 提供丰富的Restful API查询接口

支持丰富的Restful API数据查询接口

#### 提供可视化的互动API控制台

集成swagger插件，提供可视化互动API控制台

### 支持可视化的监控页面

WeBASE-Collect-Bee可与grafana深度集成，支持自动生成dashboard实例，让您的链上数据了如指掌。



