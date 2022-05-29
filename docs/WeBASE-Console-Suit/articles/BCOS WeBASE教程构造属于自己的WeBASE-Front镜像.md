## BCOS WeBASE教程|构造属于自己的WeBASE-Front镜像 

> 作者：liwh1227
>
> github：https://github.com/liwh1227

### 1.背景
  官方文档已经提供了`WeBASE-Front`容器[一建docker部署WeBASE](https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Install/docker_install.html)和可执行程序[WeBASE-Front部署说明](https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/install.html)两种部署方式。本文档内容主要针对容器部署方式，如何修改Dockerfile并实现镜像打包和并运行服务。

### 2. 前提条件

#### 2.1 系统环境

| 环境     | 版本                                   |
| -------- | -------------------------------------- |
| 操作系统 | CentOS Linux release 7.9.2009 (Core)   |
| Docker   | Docker version 20.10.16, build aa7e414 |
| git      | git version 1.8.3.1                    |

#### 2.2 拉取代码

执行命令：

```bash
git clone https://github.com/WeBankBlockchain/WeBASE-Front.git

# 若因网络问题导致长时间下载失败，可尝试以下命令
git clone https://gitee.com/WeBank/WeBASE-Front.git
```

进入目录：

https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/install.html

