# 可视化部署

可视化部署，即通过界面化的操作来部署和管理区块链服务，主要包括：

1. 部署区块链底层服务；
2. 新增，删除节点；
3. 切换节点类型（共识，观察，游离）；
4. 启动，停止节点；
5. 群组和节点可视化管理；
6. 重置区块链服务；

### 环境准备

在进行可视化部署之前，请按照部署要求，准备相应的部署环境。

#### 主机数量
使用可视化部署搭建一个 4 节点的区块链服务至少需要 5 台主机。

1 台 主机部署签名服务（WeBASE-Sign），节点管理平台（WeBASE-Web）和节点管理服务（WeBASE-Node-Manager）。

剩余 4 台主机每台部署一个区块链节点服务。

#### 主机配置
推荐 2 核 4G 内存；500G + 硬盘

#### 端口开放
防火墙和安全组（云服务主机）开放如下端口：

|  端口 | 描述  |
|---|---|
| 22  | SSH 登录端口  |
| 20200  |  节点 P2P 通信端口 |
| 5000  |  WeBASE-Web 节点管理平台的访问端口 |

#### 操作系统要求
由于在部署区块链底层节点（FISCO-BCOS）服务时，需要使用 Docker 服务，所以需要选择能够安装 Docker 服务的操作系统：

| 操作系统 | 最低要求 |
| ---- | -------- |
| CentOS / RHEL | CentOS 7.3 |
| Debian | Stretch 9  |
| Ubuntu | Xenial 16.04 |

#### 安装 Docker

如果使用云服务器，推荐使用**操作系统镜像模板**的方式创建主机：

> 在一台主机上安装 Docker 后，然后使用安装 Docker 服务后的操作系统做一个镜像模板。通过这个模板镜像来创建主机，这样新创建的主机就自带了 Docker 服务。

安装 Docker 服务，请参考：[Docker 安装](#id19) 

#### SSH 免密登录

在部署时，WeBASE-Node-Manager 服务会为每个节点生成相应的配置文件，然后使用 `scp` 命令通过 SSH 免密登录将节点的配置文件发送到对应的主机。

>**提示：**
>
> * 配置 WeBASE-Node-Manager 主机到其它节点主机的 SSH 免密登录；
> * 注意免密登录的账号权限，否则会造成创建文件目录，Docker 命令执行失败；

**免密登录配置方法**

* 使用 SSH 登录 WeBASE-Node-Manager 主机：`ssh root@[IP]`

* 检查 `~/.ssh/` 目录是否已经存在 `id_rsa.pub` 公钥文件
    * 如果存在，则进行下一步；
    * 如果不存在，执行命令 `ssh-keygen`，然后直接两次回车即可生成（提示输入密码时，直接回车）；
* 使用 `ssh-copy-id -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa.pub root@[IP]` 命令，将公钥文件上传到需要免密登录的主机（替换 [IP] 为主机的 IP 地址），然后输入远程主机的登录密码

* 输出结果出现 `Number of key(s) added: 1` 结果，表示免密登录配置成功

* 执行命令 `ssh -o StrictHostKeyChecking=no root@[IP]`，检查是否能成功登录主机


#### Docker 镜像
虽然可视化自动部署功能可以自动从 Docker 仓库拉取镜像，但是由于网络原因，拉取镜像的速度不仅很慢，同时只有极小的概率能够拉取成功。

为了保证部署过程顺利和快速完成，**强烈推荐在部署或者新增节点前，手动拉取镜像，然后上传到部署节点服务的主机。**

**手动拉取镜像分两种：**
    
* 本地没有拉取过镜像

    ```Bash
    # 从 CDN 拉取镜像 tar 文件
    # 替换 {VERSION} 为需要拉取的镜像版本
    wget https://www.fisco.com.cn/cdn/webase/releases/download/{VERSION}/docker-fisco-webase.tar
    
    # 登录需要部署的主机，解压镜像 tar 文件
    docker load -i docker-fisco-webase.tar
    ```

* 本地已经所需要版本的镜像，或者拉取过镜像的 tar 包
    * 检查本地是否有镜像版本
    
    ```Bash
    # 需要主机已经安装了 Docker 服务
    # 检查本地是否有镜像，如果输出有，检查本是否
    docker images -a |grep -i "fiscoorg/fisco-webase"
    ```
    
    * 本地有所需要的镜像版本，或者从 cdn 拉取过镜像的 tar 包

    ```Bash
    # 压缩本地镜像到 tar 文件，如果有 tar 文件，跳过
    # 替换 {VERSION} 为需要拉取的镜像版本
    docker save -o docker-fisco-webase.tar fiscoorg/fisco-webase:{VERSION}
    
    # 发送镜像 tar 文件到需要部署的主机
    scp docker-fisco-webase.tar root@[IP]:/root/
    
    # 登录需要部署的主机，解压 tar 文件
    docker load -i docker-fisco-webase.tar
    ```

关于镜像版本，请参考：[https://hub.docker.com/r/fiscoorg/fisco-webase/tags](https://hub.docker.com/r/fiscoorg/fisco-webase/tags)，其中以 -gm 结尾的标识国密版本。


### 可视化部署实现原理
可视化部署的实现原理如下：

* WeBASE-Node-Manager 根据填写的主机，调用初始化脚本，通过 SSH 远程登录每台主机，检查主机环境，包括是否安装 `Docker`，`wget`，`curl` 等服务；

* WeBASE-Node-Manager 根据填写的部署信息，调用 `build_chain.sh` 脚本，生成每台主机上各个节点的配置信息，同时还有各个机构的私钥和证书，链私钥和证书等等配置文件；

* WeBASE-Node-Manager 通过使用 `scp` 命令，将文件从 WeBASE-Node-Manager 主机上拷贝到相应主机；

* WeBASE-Node-Manager 通过 SSH 远程调用 Docker 指令根据每个节点配置使用 `docker run` 启动节点；

* 新增机构时，通过调用 `gen_agency_cert.sh` 脚本根据链私钥生成机构的私钥和证书；

* 新增节点时，通过调用 `gen_node_cert.sh` 脚本根据机构的私钥生成节点的私钥和证书； 

### 部署依赖服务

#### 签名服务

WeBASE-Sign 作为区块链的私钥管理服务，管理发送交易时所需要的私钥。

在可视化的部署后，在对节点进行游离、共识和观察操作时（通过发送一笔交易实现），需要提供一个私钥来发送变更交易。所以需要部署 WeBASE-Sign 服务，来管理发送交易所需要的私钥账户。

* 参考 [签名服务 WeBASE-Sign 部署文档](../WeBASE-Sign/install.html#id1) 优先部署 WeBASE-Sign 服务。

#### 节点管理服务
WeBASE-Node-Manager 是整个区块链节点的管理服务，同时，节点的部署也是通过 WeBASE-Node-Manager 来完成的。

参考 [节点管理服务 WeBASE-Node-Manager 部署文档](../WeBASE-Node-Manager/install.html#id1) 部署 WeBASE-Node-Manager 服务。

部署 WeBASE-Node-Manager 时，需要根据自己的场景修改配置文件 `WeBASE-Node-Manager/dist/conf/application.yml` 。

**配置主要包括：**

* 数据库 IP，端口，数据库名，访问账号和密码
* 配置签名服务 WeBASE-Sign 的访问地址，默认端口：`5004`
* 部署区块链服务时，部署节点服务的主机存放节点配置和数据的目录，默认：`/opt/fisco`
* SSH 免密账号和密码，默认：`root` 和 `22`
* 部署方式
    * 0：兼容以前先部署区块链服务和 WeBASE-Front 前置后，手动添加到 WeBASE-Node-Manager 管理服务；
    * 1：使用可视化部署的方式来部署节点服务；
* 加密方式，在执行 WeBASE-Node-Manager **数据库初始化脚本时**就确定了当前的 WeBASE-Node-Manager 是使用哪种加密方式
    * 0：非国密；
    * 1：国密；

具体的相关配置，可以参考下面的配置说明，在配置完成后，重启节点管理服务（WeBASE-Node-Manager）。

```yaml
# 修改数据库配置
spring:
  datasource:
    # 数据库 IP，端口，数据库名
    url: jdbc:mysql://[IP]:3306/webasenodemanager?serverTimezone=GMT%2B8&useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull
    # 数据库访问账号
    username: "xxx"
    # 数据库访问密码
    password: "xxx"

constant:
  # 1.4.0 visual deploy
  # WeBASE-Sign 访问地址，前面部署的签名服务的访问地址
  webaseSignAddress: "127.0.0.1:5004"
  # 部署区块链服务的节点主机存放节点配置文件和数据的目录
  rootDirOnHost: "/opt/fisco"
  # SSH 免密登录的账号
  sshDefaultUser: root
  # SSH 服务的端口，默认 22
  sshDefaultPort: 22
  # 部署方式：0, 先使用 build_chain.sh 部署链和 WeBASE-Front 服务，然后手动添加 ; 1, 使用可视化部署
  deployType: 1

sdk:
  # 加密类型：0: 非国密;  1: 国密
  # 根据执行的数据库初始化脚本类型来设置
  encryptType: 0
```

#### 节点管理平台
WeBASE-Web 是节点的管理页面，提供节点管理服务的界面化操作。

* 参考 [节点管理平台 WeBASE-Web 部署文档](../WeBASE-Web/install.html#id1) 部署 WeBASE-Web 服务。

### 可视化部署
在部署完节点管理服务（WeBASE-Node-Manager）和节点管理平台（WeBASE-Web）后，使用浏览器，访问节点管理平台页面：

```Bash
http://{deployIP}:{webPort}

# 默认端口：5000

示例：http://127.0.0.1:5000
```
#### 部署操作

**提示：**
>1. 由于网络问题，建议先参考：[Docker 安装](#id19) 进行 Docker 安装以及参考：[手动拉取 Docker 镜像](#id6) 后再进行部署操作，防止由于网络原因导致部署失败；
>2. 如果部署**国密**版本，建议参考：[手动下载 TASSL](#tassl)，手动下载 TASSL 下载库；
>3. 如果 WeBASE-Node-Manager 的 `application.yml` 中的 `deployType` 配置为 0，则会要求添加前置服务。只有当 `deployType` 配置为 1 时，才会进入可视化部署界面；

打开节点管理平台页面后，登录后修改密码，默认进入**节点管理页面**：

![visual-deploy-index](../../images/WeBASE-Console-Suit/visual-deploy/visual-deploy-index.png)

* 点击部署，打开部署界面：

具体的配置说明，可以将鼠标移动到配置的**感叹号**上，展示相应的提示信息。
![visual-deploy-ui](../../images/WeBASE-Console-Suit/visual-deploy/visual-deploy-ui.png)

**示例：**

![visual-deploy-demo](../../images/WeBASE-Console-Suit/visual-deploy/visual-deploy-demo.png)
    
* 点击开始部署后，在上面的链信息列，可以查看到当前链的状态已经部署链的进度；

* 根据进度条，在部署完成后，如图：
    
![visual-deploy-finish](../../images/WeBASE-Console-Suit/visual-deploy/visual-deploy-finish.png)

**提示：**
1. **机构名**： 必须为英文和数字，不能含有空格和汉字；
2. **Docker 拉取方式：** 建议参考[手动拉取 Docker 镜像](#id6) 进行手动拉取镜像的操作；

#### 新增节点
节点新增，也称作区块链扩容，指在已有的区块链服务中，增加新的节点。

在新增节点时，需要输入一个新的 IP 主机的地址。

**提示：**
> 1. 新主机也需要配置 SSH 免密登录；
> 2. 建议参考[手动拉取 Docker 镜像](#id6) 在新添加主机上进行手动拉取镜像的操作后再执行添加节点的操作；

新增的节点，**默认处于游离状态**，需要手动**变更节点为共识或者观察节点**后，新节点开始从原有节点同步区块数据。

**具体操作：**

* 点击**新增节点**按钮；
* 输入主机 IP 地址和机构名称（可以是已经存在的机构或者新机构）；
* 选择群组；
* 选择 Docker 拉取方式；
* 点击确认，即可完成增加节点操作；

![visual-deploy-add-node](../../images/WeBASE-Console-Suit/visual-deploy/visual-deploy-add-node.png)

#### 节点操作
节点操作，包括：

* 节点的启动，停止；
* 节点的类型切换：共识，观察和游离；
* 删除节点；

![visual-deploy-node-change-type](../../images/WeBASE-Console-Suit/visual-deploy/visual-deploy-node-change-type.png)

点击节点列表的操作项操作即可。但是需要注意：

* 停止操作时，节点必须处于游离状态；
* 变更节点为游离节点时，该群组内，至少有两个共识节点；
* 变更节点类型，需要发送交易，请先在**私钥管理添加私钥账号；**
* 删除节点时，节点必须处于停止状态；

![visual-deploy-add-user-key](../../images/WeBASE-Console-Suit/visual-deploy/visual-deploy-add-user-key.png)

#### 重置区块链
如果在部署区块链服务时，出现了部署失败的问题，可以使用重置功能，重置区块链服务，然后进行重新部署。

如果要重置当前区块链，点击**重置**按钮，等待重置完成。

当执行重置操作时，并不会真正物理删除节点的数据，而是使用 `mv` 命令，将区块链的整个数据移动到临时目录。

* WeBASE-Node-Manager 服务的临时目录
    * `WeBASE-Node-Manager/dist/NODES_ROOT_TMP` 目录中存放了所有重置节点的节点配置文件
    * **不包含**具体的节点数据文件
    * 文件名格式 `default_chain-YYYYMMDD_HHmmSS（删除时间）`：default_chain-20200722_102631
    
* 节点主机中的临时目录
    * `WeBASE-Node-Manager/dist/conf/application.yml` 配置文件中 `rootDirOnHost` 配置目录下的 `deleted-tmp` 目录
    * 包含了**节点的所有文件**配置文件和节点数据文件
    * 文件名格式 `default_chain-YYYYMMDD_HHmmSS（删除时间）`：default_chain-20200722_102631


### 常见问题
#### Docker 安装
在 Debian/Ubuntu/CentOS/RHEL，直接执行命令：

```Bash
# 该脚本是 Docker 官方提供的 Linux 自动安装脚本
bash <(curl -s -L get.docker.com)
```

在 CentOS/RHEL 8.x 中，使用上面的自动脚本安装时，会出现下面的错误：

```Bash
Last metadata expiration check: 0:37:43 ago on Sat 22 Feb 2020 07:40:15 PM CST.
Error: 
 Problem: package docker-ce-3:19.03.6-3.el7.x86_64 requires containerd.io >= 1.2.2-3, but none of the providers can be installed
  - cannot install the best candidate for the job
  - package containerd.io-1.2.10-3.2.el7.x86_64 is excluded
  - package containerd.io-1.2.2-3.3.el7.x86_64 is excluded
  - package containerd.io-1.2.2-3.el7.x86_64 is excluded
  - package containerd.io-1.2.4-3.1.el7.x86_64 is excluded
  - package containerd.io-1.2.5-3.1.el7.x86_64 is excluded
  - package containerd.io-1.2.6-3.3.el7.x86_64 is excluded
(try to add '--skip-broken' to skip uninstallable packages or '--nobest' to use not only best candidate packages) 
```

要解决这个问题，需要手动安装 `containerd.io`后，在执行自动安装脚本

```Bash
# 下载最新的 containerd.io 安装包
wget https://download.docker.com/linux/centos/8/x86_64/stable/Packages/containerd.io-1.2.13-3.2.el7.x86_64.rpm 

# 手动安装 containerd.io 
yum localinstall containerd.io-1.2.13-3.2.el7.x86_64.rpm 

```

#### 手动下载 TASSL 

FISCO BCOS 国密版本需要使用 TASSL 生成国密版本的证书，部署工具会自动从GitHub 下载，解压后放置于 `~/.fisco/tassl`，如果碰到下载失败，请尝试从[https://gitee.com/FISCO-BCOS/LargeFiles/blob/master/tools/tassl.tar.gz](https://gitee.com/FISCO-BCOS/LargeFiles/blob/master/tools/tassl.tar.gz) 下载并解压后，放置于 `~/.fisco/tassl`


    
