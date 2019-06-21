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

