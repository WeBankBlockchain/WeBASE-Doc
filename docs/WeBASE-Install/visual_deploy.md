# 可视化部署

可视化部署是指通过 WeBASE 管理平台，在 **多台** 主机上快速部署 **FISCO-BCOS 底层节点和 WeBASE-Front 前置** 以及 对底层节点的扩容操作。

可视化部署，需要先部署依赖服务，包括管理平台（WeBASE-Web）、节点管理子系统（WeBASE-Node-Manager）、签名服务（WeBASE-Sign）。

然后通过 WeBASE 管理平台（WeBASE-Web）的界面来部署节点（FISCO-BCOS 2.0+）和节点前置子系统（WeBASE-Front）。


### 环境准备

在进行可视化部署之前，请按照部署要求，准备相应的部署环境。

#### 系统环境

##### 硬件配置
使用可视化部署搭建一个 **4 节点** 的区块链服务至少需要 **5 台**主机。

其中 1 台主机部署 **可视化部署的依赖** 服务，包括管理平台（WeBASE-Web）、节点管理子系统（WeBASE-Node-Manager）、签名服务（WeBASE-Sign）。

剩余 4 台主机每台部署一个 FISCO-BCOS 节点和 WeBASE-Front 前置服务。

**注意：**
- 在企业级部署时，为了安全，推荐将签名服务（WeBASE-Sign）放在内网中，与管理平台、管理子系统分开部署。此处为了方便演示，因此将签名服务（WeBASE-Sign）部署在同一台主机。


**具体配置**

| 名称 | 最低配置  |推荐配置  |
|---|---|---|
| CPU  | 2 核  | 4 核 |
| 内存 |  4 G | 8 G |
| 磁盘 |  100G + | 500G + |

##### 操作系统
部署节点的主机操作系统需要满足安装 Docker 服务的最低版本要求；

| 操作系统 | 最低要求 |
| ---- | -------- |
| CentOS / RHEL | CentOS 7.3 |
| Ubuntu | Xenial 16.04 |


##### 端口开放

主机防火墙需要开放以下端口。如果是云服务器，需要配置**云服务器安全组策略**中的端口开放规则。

|  端口 | 描述  |
|------|------|
| 22  | SSH 登录端口  |
| 20200  |  节点 P2P 通信端口 |
| 5000  |  WeBASE-Web 节点管理平台的访问端口 |


##### 安装 Docker

如果使用云服务器，推荐使用**操作系统镜像模板**的方式创建主机，即在一台主机上安装 Docker 后，然后使用安装 Docker 服务后的操作系统做一个镜像模板。通过这个模板镜像来创建主机，这样新创建的主机就自带了 Docker 服务。

安装 Docker 服务，请参考下文**常见问题**中：[Docker 安装](#install_docker)

##### 拉取 Docker 镜像

可视化部署需要使用`FISCO BCOS + WeBASE-Front`组成的节点与前置Docker镜像，并提供拉取Docker镜像的两种方式（**推荐通过CDN加速服务拉取**）：
- 通过WeBASE CDN服务下载镜像压缩包后，通过`docker load`命令安装镜像
- 直接通过`docker pull`命令直接从DockerHub拉取镜像

```eval_rst
.. important::
可视化自动部署功能支持自动从 Docker 仓库拉取镜像，仅通过页面点击就可以完成Docker拉取。但是由于DockerHub的网络原因，拉取镜像的速度较慢，耗时过长，容易导致拉取镜像失败，页面的可视化部署操作失败。
因此，为了保证部署过程顺利和快速完成，推荐在执行可视化部署前，手动拉取镜像，并将镜像上传到每个需要部署节点服务的主机。
```

拉取镜像的方法，请参考下文**常见问题**中：[拉取 Docker 镜像](#pull_image)

##### 配置 SSH 免密登录

在节点管理台进行可视化部署时，节点管理（WeBASE-Node-Manager）服务会为每个节点生成相应的配置文件，然后通过 SSH 免密登录，使用 `scp` 命令将节点的配置文件发送到对应的主机，然后远程登录到节点主机，执行系统命令来操作节点。下面介绍配置免密登录的各个步骤

```eval_rst
.. important::
    1. 配置 WeBASE-Node-Manager 主机到其它节点主机的 SSH 免密登录；
    2. 注意免密登录的账号权限，否则会造成创建文件目录，Docker 命令执行失败；
    3. 如果免密账号为非 `root` 账号，保证账号有 `sudo` **免密** 权限，即使用 `sudo` 执行命令时，不需要输入密码；
```

**免密登录配置方法**

```eval_rst
.. important::
    1. 如果 WeBASE-Node-Manager 已经生成过秘钥对，建议使用命令 `ssh-keygen -t rsa -m PEM` 重新生成；
```

* 使用 SSH 登录 WeBASE-Node-Manager 所在主机：`ssh root@[IP]`

* 检查 `~/.ssh/` 目录是否已经存在 `id_rsa` 私钥文件和对应的 `id_rsa.pub` 公钥文件。如果存在，备份现有私钥对
    
    ```Bash
    mv ~/.ssh/id_rsa ~/.ssh/id_rsa.bak
    mv ~/.ssh/id_rsa.pub ~/.ssh/id_rsa.pub.bak 
    ```

* 执行命令 `ssh-keygen -t rsa -m PEM`，然后直接两次回车即可生成（提示输入密码时，直接回车）

* 将公钥文件上传到需要免密登录的主机（替换 [IP] 为主机的 IP 地址），然后输入远程主机的登录密码

    ssh-copy-id -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa.pub root@[IP]

* 输出结果出现 `Number of key(s) added: 1` 结果，表示免密登录配置成功

* 检查从部署 WeBASE-Node-Manager 服务的主机是否能成功免密登录部署节点的主机（替换 [IP] 为主机的 IP 地址）

    `ssh -o StrictHostKeyChecking=no root@[IP]`
    

**节点主机 sudo 账号免密配置方法**

```Bash
# 切换到 root 或者有权限账户
vi /etc/sudoers

# 添加下面一行并保存
# 替换 user 为 SSH 免密登录账号
user   ALL=(ALL) NOPASSWD : ALL
```

### 部署依赖服务
可视化部署需要依赖 WeBASE 的中间件服务，包括**管理平台（WeBASE-Web）、节点管理子系统（WeBASE-Node-Manager）、签名服务（WeBASE-Sign）**。

对于依赖服务的安装，有两种方式（ **一键部署** 和 **手动部署** ），选择其中一种部署方式即可

#### 1. 一键部署依赖服务

适合**同机部署**，快速体验WeBASE的情况使用

具体环境依赖参考[**一键部署-前提条件**](../WeBASE/install.html#id2)。

**拉取部署脚本**

获取部署安装包：
```shell
wget https://github.com/WeBankFinTech/WeBASELargeFiles/releases/download/v1.4.2/webase-deploy.zip
```
解压安装包：
```shell
unzip webase-deploy.zip
```
进入目录：
```shell
cd webase-deploy
```

**注意：**
- 配置可视化部署配置文件时，选择`visual-deploy.properties`进行配置
- 选择部署方式时，选择 **可视化部署** 方式，即执行 `deploy.py` 脚本时，执行 `python3 deploy.py installWeBASE`

修改 `visual-deploy.properties` 文件。
<span id="visual-deploy-config"></span>


```eval_rst
.. important::
    注意： `sign.ip` 配置的 IP 是WeBASE-Sign签名服务对外提供服务访问的 IP 地址，供其他部署节点主机访问。
```

```shell
# WeBASE子系统的最新版本(v1.1.0或以上版本)
webase.web.version=v1.4.2
webase.mgr.version=v1.4.2
webase.sign.version=v1.4.2
fisco.webase.docker.cdn.version=v1.4.2

# 节点管理子系统mysql数据库配置
mysql.ip=127.0.0.1
mysql.port=3306
mysql.user=dbUsername
mysql.password=dbPassword
mysql.database=webasenodemanager

# 签名服务子系统mysql数据库配置
sign.mysql.ip=localhost
sign.mysql.port=3306
sign.mysql.user=dbUsername
sign.mysql.password=dbPassword
sign.mysql.database=webasesign

# WeBASE管理平台服务端口
web.port=5000

# 节点管理子系统服务端口
mgr.port=5001

# 签名服务子系统端口
sign.port=5004

# 是否使用国密（0: standard, 1: guomi）
encrypt.type=0

# WeBASE-Sign 对外提供服务的访问 IP 地址
# 部署在其它主机的节点，需要使用此 IP 访问 WeBASE-Sign 服务
# 不能是 127.0.0.1 或者 localhost
sign.ip=

# SSH 免密登录账号
mgr.ssh.user=root
# SSH 访问端口
mgr.ssh.port=22
# 部署节点服务的主机，存放链数据的目录
mgr.ssh.rootDirOnHost=/opt/fisco
```

完成配置文件修改后，则执行部署：

**备注：** 

- 部署脚本会拉取相关安装包进行部署，需保持网络畅通。
- 首次部署需要下载编译包和初始化数据库，重复部署时可以根据提示不重复操作
- 部署过程中出现报错时，可根据错误提示进行操作，或根据本文档中的[常见问题](#q&a)进行排查
- 不建议使用sudo执行脚本，例如`sudo python3 deploy.py installWeBASE`（sudo会导致无法获取当前用户的环境变量如JAVA_HOME）


```shell
# 部署并启动可视化部署的所有服务
python3 deploy.py installWeBASE
```

如果遇到docker必须使用sudo运行，报错`Docker....Permission Denied`，可以参考[常见问题-创建docker用户组](#docker_sudo)

部署完成后可以看到`deploy has completed `的日志：

```shell
$ python3 deploy.py installWeBASE
...
============================================================
              _    _     ______  ___  _____ _____ 
             | |  | |    | ___ \/ _ \/  ___|  ___|
             | |  | | ___| |_/ / /_\ \ `--.| |__  
             | |/\| |/ _ | ___ |  _  |`--. |  __| 
             \  /\  |  __| |_/ | | | /\__/ | |___ 
              \/  \/ \___\____/\_| |_\____/\____/  
...
...
============================================================
==============      deploy has completed     ==============
============================================================
==============    webase-web version  v1.4.2        ========
==============    webase-node-mgr version  v1.4.2   ========
==============    webase-sign version  v1.4.2       ========
============================================================
```


* 服务部署后，需要对各服务进行启停操作，可以使用以下命令：

```shell
# 可视化部署
部署并启动可视化部署的所有服务  python3 deploy.py installWeBASE
停止可视化部署的所有服务  python3 deploy.py stopWeBASE
启动可视化部署的所有服务  python3 deploy.py startWeBASE
# 各子服务启停
启动WeBASE-Node-Manager: python3 deploy.py startManager
停止WeBASE-Node-Manager: python3 deploy.py stopManager
启动WeBASE-Web:          python3 deploy.py startWeb
停止WeBASE-Web:          python3 deploy.py stopWeb
启动WeBASE-Sign:        python3 deploy.py startSign
停止WeBASE-Sign:        python3 deploy.py stopSign
```

#### 2. 手动部署依赖服务
适合**多机部署**，企业级的情况使用。

具体步骤如下：

* 签名服务（WeBASE-Sign）
    
    * 参考 [签名服务 WeBASE-Sign 部署文档](../WeBASE-Sign/install.html#id1) 部署 WeBASE-Sign 服务

* 管理平台（WeBASE-Web）

    * 参考 [节点管理平台 WeBASE-Web 部署文档](../WeBASE-Web/install.html#id1) 部署 WeBASE-Web 服务
    
* 节点管理子系统（WeBASE-Node-Manager）
    * 参考 [节点管理服务 WeBASE-Node-Manager 部署文档](../WeBASE-Node-Manager/install.html#id1) 部署 WeBASE-Node-Manager 服务
    * 修改 `WeBASE-Node-Manager/dist/conf/application.yml` 配置文件示例如下：
        * 配置文件中 `deployType` 为 `1`，启用节点管理服务的可视化部署功能
        * 配置文件中 `webaseSignAddress` 的 IP 地址，其余主机需要通过此IP访问签名服务
    
```eval_rst
.. important::
    1. 注意 WeBASE-Node-Manager 服务的 `webaseSignAddress` 配置。WeBASE-Front 节点会使用此地址访问 WeBASE-Sign。所以不能使用 **`127.0.0.1`**，需要填写对外服务的 IP 地址。
```

```yaml
 constant:
  # 1.4.0 visual deploy
  # 部署方式修改为 1，启用可视化部署
  deployType: 1
  
  # WeBASE-Sign 服务的访问地址，前面部署的签名服务的访问地址
  # 注意 IP 地址，WeBASE-Front 会使用此 IP 地址访问签名服务
  # 不能使用 127.0.0.1 
  webaseSignAddress: "xxx.xx.xx.xxx:5004"
  
  # 部署区块链服务的节点主机存放节点配置文件和数据的目录
  rootDirOnHost: "/opt/fisco"
  
  # SSH 免密登录的账号 和 端口，默认为 root 和 22
  sshDefaultUser: root
  sshDefaultPort: 22
```


### 可视化部署节点
在部署完依赖服务后，使用浏览器，访问节点管理平台页面：

```Bash
# 默认端口 5000
http://{deployIP}:{webPort}
```
#### 部署节点

可视化部署节点时，后台服务将通过在各个主机安装`FISCO BCOS + WeBASE-Front`的Docker镜像，结合免密远程操作进行自动化部署节点与节点前置的过程。

因此，正如上文步骤中“拉取Docker镜像”的阐述，此操作依赖Docker服务，并推荐手动拉取节点与前置的Docker镜像（否则将自动从DockerHub拉取）

**提示：**
- 在执行部署前，请 **手动安装 Docker 服务** 和 **手动拉取 Docker 镜像**，防止由于网络原因导致部署失败

    - 参考下文 **常见问题** 中的 [安装 Docker](#install_docker)
    - 参考下文 **常见问题** 中的 [拉取 Docker 镜像](#pull_image)
    
- 如果部署 **国密** 版本，**手动下载 TASSL 库**，防止由于 GitHub 不能访问，导致部署失败
    - 参考下文**常见问题**中的 [手动下载 TASSL](#tassl)，手动下载 TASSL 下载库

- 部署时，填写的 **机构名** 必须为英文和数字，不能含有空格和汉字


打开节点管理平台页面后，登录后修改密码，默认进入**节点管理页面**：

![visual-deploy-index](../../images/WeBASE-Console-Suit/visual-deploy/visual-deploy-index.png)

* 点击部署，打开部署界面：

具体的配置说明，可以将鼠标移动到配置的**感叹号**上，展示相应的提示信息。
![visual-deploy-ui](../../images/WeBASE-Console-Suit/visual-deploy/visual-deploy-ui.png)

**示例：**

![visual-deploy-demo](../../images/WeBASE-Console-Suit/visual-deploy/visual-deploy-demo.png)
    
* 点击开始部署后，在上面的链信息列，可以查看到当前链的状态已经部署链的进度；

* 部署成功后，如图：
    
![visual-deploy-finish](../../images/WeBASE-Console-Suit/visual-deploy/visual-deploy-finish.png)



#### 新增节点
节点新增，也称作节点扩容，指在已有的区块链服务中，在新的主机上，添加一个新的节点。

**提示：**
- 新主机配置 SSH 免密登录
    - 参考上文的 [配置 SSH 免密登录](#ssh)
    
- **手动安装 Docker 服务**和 **手动拉取 Docker 镜像**，防止由于网络原因导致添加失败
    - 参考下文**常见问题**中的 [安装 Docker](#install_docker)
    - 参考下文**常见问题**中的 [拉取 Docker 镜像](#pull_image)

- 新增的节点，**默认处于游离状态**，需要手动**变更节点为共识或者观察节点**后，新节点开始从原有节点同步区块数据。

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

点击节点列表的操作项操作即可。

![visual-deploy-add-user-key](../../images/WeBASE-Console-Suit/visual-deploy/visual-deploy-add-user-key.png)

**提示**
- 停止操作时，节点必须处于游离状态；
- 变更节点为游离节点时，该群组内，至少有两个共识节点；
- 变更节点类型，需要发送交易，请先在**私钥管理 中 添加私钥账号；**
- 删除节点时，节点必须处于停止状态；

<span id="q&a"></span>
### 常见问题

<span id="install_docker" />

#### 安装 Docker
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
<span id="pull_image" />

#### 拉取 Docker 镜像

镜像版本：
- v2.7.0
- v2.7.0-gm

**提示：**
- 最近的镜像版本，请参考：[https://hub.docker.com/r/fiscoorg/fisco-webase/tags](https://hub.docker.com/r/fiscoorg/fisco-webase/tags)

##### 拉取方式

* 检查本地是否已有镜像
    
```Bash
# 检查本地是否有镜像
docker images -a |grep -i "fiscoorg/fisco-webase" | grep -i v2.7.0
    
# 如果有如下输出，表示本地已有镜像；否则表示本地没有镜像
fiscoorg/fisco-webase   v2.7.0     bf4a26d5d389  5 days ago   631MB
# 如果是国密，版本号会带 -gm
fiscoorg/fisco-webase   v2.7.0-gm  bf4a26d5d389  5 days ago   631MB
```
    
* 如果本地没有镜像（如果本地有镜像，跳过）
    
    * 从 CDN 拉取镜像压缩包
    
    ```Bash
    # 从 CDN 拉取镜像 tar 文件
    # 非国密
    wget https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/WeBASE/releases/download/v1.4.2/docker-fisco-webase.tar
    # 国密
    wget https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/WeBASE/releases/download/v1.4.2/docker-fisco-webase-gm.tar
    
    # 解压镜像 tar 文件
    docker load -i docker-fisco-webase.tar
    ```
    
    * 从 Docker 官方拉取镜像

   ```Bash
   # 执行 Docker 拉取命令
   docker pull fiscoorg/fisco-webase:v2.7.0
   # 国密
   docker pull fiscoorg/fisco-webase:v2.7.0-gm  
   ```
   
* 压缩镜像到 `tar` 文件
    
```Bash
# 压缩镜像为 tar 文件
docker save -o docker-fisco-webase.tar fiscoorg/fisco-webase:v2.7.0
```
    
* 发送镜像 `tar` 文件到部署节点的主机

```Bash
# 发送镜像 tar 文件到需要部署节点的主机
scp docker-fisco-webase.tar root@[IP]:/root/
```
    
* 解压镜像 `tar` 文件
    
```Bash
# 登录需要部署的主机，解压 tar 文件
docker load -i docker-fisco-webase.tar
```
    
* 节点主机检查是否已经成功拉取镜像
    
```Bash
# 检查是否成功拉取镜像
docker images -a |grep -i "fiscoorg/fisco-webase"
    
# 如果有如下输出，表示拉取成功
fiscoorg/fisco-webase   v2.7.0  bf4a26d5d389  5 days ago   631MB
# 如果是国密，版本号会带 -gm
fiscoorg/fisco-webase   v2.7.0-gm  bf4a26d5d389  5 days ago   631MB
```

#### 手动下载 TASSL 

FISCO BCOS 国密版本需要使用 TASSL 生成国密版本的证书，部署工具会自动从GitHub 下载，解压后放置于 `~/.fisco/tassl`，如果碰到下载失败，请尝试从[https://gitee.com/FISCO-BCOS/LargeFiles/blob/master/tools/tassl.tar.gz](https://gitee.com/FISCO-BCOS/LargeFiles/blob/master/tools/tassl.tar.gz) 下载并解压后，放置于 `~/.fisco/tassl`


    
#### 没有进入可视化部署界面
在登录区块链管理平台后，没有进入可视化部署页面。此时，修改 WeBASE-Node-Manager 服务中的 `dist/conf/application.yml` 文件中的 `deployType` 的值是否为 `1` 后，重启 WeBASE-Node-Manager 服务即可。

#### 新增节点时，提示请手动拉取 Docker 镜像错误

SSH 登录新主机，使用 `docker images -a |grep -i "fiscoorg/fisco-webase"` 命令检查是否有镜像。

* 如果存在，请参考上文： **常见问题** 中的 [拉取 Docker 镜像](#pull_image)

* 如果**不**存在，请检查新主机中 SSH 账号的 `sudo` 免密配置。


#### 部署失败以及区块链重置
如果在部署区块链服务时，出现了部署失败的问题，可以使用重置功能，重置区块链服务，然后进行重新部署。

如果要重置当前区块链，点击**重置**按钮，等待重置完成。

执行重置操作，并 **不会真正物理删除节点的数据**，而是使用 `mv` 命令，将区块链的整个数据移动到临时目录。

- WeBASE-Node-Manager 服务的临时目录
    * `WeBASE-Node-Manager/dist/NODES_ROOT_TMP` 目录中存放了所有重置节点的节点配置文件
    * **不包含**具体的节点数据文件
    * 文件名格式 `default_chain-YYYYMMDD_HHmmSS（删除时间）`：default_chain-20200722_102631
    
- 节点主机中的临时目录
    * `WeBASE-Node-Manager/dist/conf/application.yml` 配置文件中 `rootDirOnHost` 配置目录下的 `deleted-tmp` 目录
    * 包含了**节点的所有文件**配置文件和节点数据文件
    * 文件名格式 `default_chain-YYYYMMDD_HHmmSS（删除时间）`：default_chain-20200722_102631


<span id="docker_sudo"></span>

#### docker必须使用sudo才能运行，但是sudo下系统环境变量失效

答：可以在root用户下配置环境变量如JAVA_HOME等，或者通过下面操作，尝试创建docker用户组

```
# 创建docker用户组
sudo groupadd docker
# 将当前用户添加到docker用户组
sudo usermod -aG docker $USER
# 重启docker服务
sudo systemctl restart docker
# 切换或者退出当前账户，重新登入
exit
```

