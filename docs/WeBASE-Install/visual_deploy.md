# 可视化部署

可视化部署是指通过 WeBASE 管理平台，在 **多台** 主机上快速部署 **FISCO-BCOS 底层节点和 WeBASE-Front 前置** 以及 对底层节点的扩容操作。

可视化部署，需要先部署依赖服务，包括管理平台（WeBASE-Web）、节点管理子系统（WeBASE-Node-Manager）、签名服务（WeBASE-Sign）。

然后通过 WeBASE 管理平台（WeBASE-Web）的界面在填入的主机中部署节点（FISCO-BCOS 2.0+）和节点前置子系统（WeBASE-Front）。


## 环境准备

在进行可视化部署之前，请按照部署要求，准备相应的部署环境。

### 系统环境

#### 硬件配置
使用可视化部署搭建一个 **至少2 节点** 的区块链服务，WeBASE配置至少1G空闲内存（用于节点管理服务与签名服务，每个WeBASE后台组件至少配置500M内存）、每个节点+前置的镜像配置至少2G空闲内存（节点数与CPU内核数正相关，如4核可配置4节点），在进行可视化部署时会进行主机的可用内存检测。

**注意：**
- 在企业级部署时，为了安全，推荐将签名服务（WeBASE-Sign）放在内网中，与管理平台、管理子系统分开部署。此处为了方便演示，因此将签名服务（WeBASE-Sign）部署在同一台主机。


**具体配置**

| 名称 | 最低配置  |推荐配置  |
|---|---|---|
| CPU  | 2 核  | 4 核 |
| 内存 |  4 G | 8 G |
| 磁盘 |  100G + | 500G + |

#### 操作系统
部署节点的主机操作系统需要满足安装 Docker 服务的最低版本要求；

| 操作系统 | 最低要求 |
| ---- | -------- |
| CentOS / RHEL | CentOS 7.3 |
| Ubuntu | Xenial 16.04 |


#### 端口开放

主机防火墙需要开放以下端口。如果是云服务器，需要配置**云服务器安全组策略**中的端口开放规则。

|  端口 | 描述  |
|------|------|
| 22  | SSH 登录端口  |
| 20200  |  节点 P2P 通信端口 |
| 5000  |  WeBASE-Web 节点管理平台的访问端口 |

### 系统依赖

配置系统依赖分成**宿主机**（Node-Manager所在主机）与**节点主机**（节点所在主机）两种：（宿主机与节点主机均为统一主机时，则需要两种配置）
- 宿主机：配置Ansible、配置Ansible免密登录节点机
- 节点主机：配置docker及docker用户组、配置Ansible用户的sudo权限、安装FISCO BOCS节点依赖

#### 配置Ansible

在宿主机安装Ansible、配置Ansible host列表，配置Ansible免密登录到节点主机的私钥与登录用户

##### 安装Ansible

CentOS
```
yum install epel-release -y
yum install ansible –y
```

Ubuntu
```
apt-get install software-properties-common
apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install ansible 
```

安装完成后，可以通过`--version`检查是否安装成功
```
$ ansible --version
ansible 2.9.15
  config file = /etc/ansible/ansible.cfg
  configured module search path = [u'/root/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python2.7/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 2.7.17 (default, Sep 30 2020, 13:38:04) [GCC 7.5.0]
```

<span id="ansible_host"></span>

##### 配置Ansible sudo账号

首先修改Ansible登录到节点主机的sudo用户名，默认为root。

若使用root则跳过此步骤。需要保证该用户名拥有sudo权限，如何为非root用户设置sudo权限参考[sudo账号免密配置](#sudo_config)
```
vi /etc/ansible/ansible.cfg

# 找到sudo_user选项，
···
sudo_user=root
``` 

<span id="ssh"></span>

##### 免密登录配置

在节点管理台进行可视化部署时，节点管理（WeBASE-Node-Manager）服务会为每个节点生成相应的配置文件，然后通过Ansible的免密登录远程操作，在远程的节点主机中执行系统命令来操作节点。

下面介绍配置免密登录的各个步骤

```eval_rst
.. important::
    1. 配置 WeBASE-Node-Manager 主机到其它节点主机的 SSH 免密登录；
    2. 配置Ansible的hosts列表并配置免密登录私钥路径
    3. 注意免密登录的账号sudo权限，否则会造成创建文件目录，Docker 命令执行失败；
    4. 如果免密账号为非 `root` 账号，保证账号有 `sudo` **免密** 权限，即使用 `sudo` 执行命令时，不需要输入密码；参考[sudo账号配置](#sudo_config)
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

* 将公钥文件上传到需要免密登录的主机（替换 [IP] 为节点主机的 IP 地址），然后输入远程主机的登录密码

    ssh-copy-id -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa.pub root@[IP]

* 输出结果出现 `Number of key(s) added: 1` 结果，表示免密登录配置成功

* 检查从部署 WeBASE-Node-Manager 服务的主机是否能成功免密登录部署节点的主机（替换 [IP] 为主机的 IP 地址）

    `ssh -o StrictHostKeyChecking=no root@[IP]`
    
此处配置宿主机免密登录到节点主机完成后，记住宿主机中`id_rsa`私钥的路径，下一步进行Ansible中hosts的免密配置

*切记妥善保管免密登录的私钥，否则当前主机与ssh免密登录的主机均会被控制*

<span id="ansible_host"></span>

**配置Ansible Hosts与免密登录**

在`/etc/ansible/hosts`文件中添加IP组webase，并添加节点机的IP、免密登录账号和私钥路径。

若后续需要添加新的主机，需要将新主机的IP添加到此处

添加以下内容，此处假设远端IP为127.0.0.1，免密登录账户为root，且`id_rsa`免密私钥的路径为`/root/.ssh/id_rsa`
```
vi /etc/ansible/hosts

···
[webase]
127.0.0.1 ansible_ssh_private_key_file=/root/.ssh/id_rsa  ansible_ssh_user=root
{your_host_ip} ansible_ssh_private_key_file={id_rsa_path}  ansible_ssh_user={ssh_user}
```

##### 测试Ansible

执行ansible的ping命令，检测添加到hosts中各个节点主机IP能否被访问。若出现`IP | SUCCESS`的则代表该IP可连通。

如果出现`FAILED`代表该IP无法连接，需要根据上文的免密登录配置进行`ssh -o StrictHostKeyChecking=no root@[IP]`检测

对ansible中的webase ip组进行ping检测
```
ansible webase -m ping

116.63.161.132 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
}
116.63.184.110 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python"
    }, 
    "changed": false, 
    "ping": "pong"
}

```

#### 配置Docker

配置Docker需要**在每个安装节点的主机上都要执行**，否则将导致节点远程安装失败。包括以下几个步骤
- 安装Docker并启动Docker
- 配置Docker用户组

安装 Docker 服务，请参考下文**常见问题**中：[Docker 安装](#install_docker)

如果使用云服务器，推荐使用**操作系统镜像模板**的方式创建主机，即在一台主机上安装 Docker 后，然后使用安装 Docker 服务后的操作系统做一个镜像模板。通过这个模板镜像来创建主机，这样新创建的主机就自带了 Docker 服务。

<span id="docker_sudo"></span>

#### 配置docker用户组

若执行Docker命令，如`docker ps`必须使用sudo才能运行

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

重新登入后，执行`docker ps`如有输出，未报错Permission Denied则代表配置成功

<span id="pull_image"></span>
##### 拉取 Docker 镜像

**在v1.4.3版本后，可视化部署支持自动从CDN拉取镜像，无需手动拉取**

若需要手动配置镜像，可以通过以下方法配置

可视化部署需要使用`FISCO BCOS + WeBASE-Front`组成的节点与前置Docker镜像，并提供拉取Docker镜像的三种方式（**推荐通过CDN加速服务拉取**）：
- 通过可视化部署自动从CDN拉取镜像压缩包并加载镜像（**推荐**），需要确保wget命令能正常使用
- 通过WeBASE CDN服务下载镜像压缩包后，通过`docker load`命令安装镜像
- 直接通过`docker pull`命令直接从DockerHub拉取镜像

```eval_rst
.. important::
可视化自动部署功能支持自动从 Docker 仓库拉取镜像，仅通过页面点击就可以完成Docker拉取。但是由于DockerHub的网络原因，拉取镜像的速度较慢，耗时过长，容易导致拉取镜像失败，页面的可视化部署操作失败。
因此，为了保证部署过程顺利和快速完成，可在执行可视化部署前，手动拉取镜像，并将镜像上传到每个需要部署节点服务的主机。
```

拉取镜像的方法，请参考下文**常见问题**中：[拉取 Docker 镜像](#pull_image)


## 部署依赖服务
可视化部署需要依赖 WeBASE 的中间件服务，包括**管理平台（WeBASE-Web）、节点管理子系统（WeBASE-Node-Manager）、签名服务（WeBASE-Sign）**。

对于依赖服务的安装，有两种方式（ **一键部署** 和 **手动部署** ），选择其中一种部署方式即可

### 1. 一键部署依赖服务

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
    注意： `sign.ip` 配置的 IP 是WeBASE-Sign签名服务对外提供服务访问的 IP 地址（外网ip），供其他部署节点主机访问。
```

```shell
# WeBASE子系统的最新版本(v1.4.0或以上版本)
webase.web.version=v1.4.3
webase.mgr.version=v1.4.3
webase.sign.version=v1.4.3
fisco.webase.docker.cdn.version=v1.4.3

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
# 此配置决定可视化部署部署国密链或非国密链
encrypt.type=0

# WeBASE-Sign 对外提供服务的访问 IP 地址
# 部署在其它主机的节点，需要使用此 IP 访问 WeBASE-Sign 服务
# 不能是 127.0.0.1 或者 localhost
sign.ip=

# SSH 免密登录账号
mgr.ssh.user=root
# SSH 访问端口
mgr.ssh.port=22
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
$ python3 deploy.py installAll
...
