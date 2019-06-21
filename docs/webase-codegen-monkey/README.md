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
webase-front是和fisco-bcos节点配合使用的一个子系统，此分支支持fisco-bcos 2.0以上版本，可通过HTTP请求和节点进行通信，集成了web3jsdk，对接口进行了封装和抽象，具备可视化控制台，可以在控制台上查看交易和区块详情，开发智能合约，管理私钥，并对节点健康度进行监控和统计。 

   部署方式有两种: (1)可以front组件单独部署作为独立控制台使用,打开http://{nodeIP}:8081/webase-front 即可访问控制台界面；(2)也可以结合[webase-node-mgr](https://github.com/WeBankFinTech/webase-node-mgr) 和 [webase-web](https://github.com/WeBankFinTech/webase-web)服务一起部署。

 注意：webase-front需要跟节点同机部署。一台机器部署多个节点，建议只部署一个front服务即可。

## 2. 前提条件

| 依赖软件 | 支持版本 |
| :-: | :-: |
| gradle | gradle4.9或更高版本（构建工具） |
| java | 1.8.0_181或更高版本|
| fisco-bcos | v2.0.x版本 |

备注：安装说明请参看附录。
