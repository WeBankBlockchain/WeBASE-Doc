# 如何使用Docker部署WeBASE-Front

* * *

作者：深职院 陈洁 
github：https://github.com/JieChen-Afra

* * *


### **实验环境**

| 环境 | 操作系统 |Docker  |
| --- | --- | --- |
|版本  |CentOS Linux release 7.4.1708 (Core)  | Docker version 20.10.17, build 100c701 | 

* * *

### **节点搭建**
>WeBASE-Front是和FISCO-BCOS节点配合使用的一个子系统。 WeBASE-Front需要跟节点同机部署，一个节点对应一个WeBASE-Front服务。

所以在搭建WeBASE-Front前我们要先将节点运行起来。在这里我们直接查看节点状态和日志，确保节点是正常运行的。

查看节点进程
```ps -ef | grep -v grep | grep fisco-bcos```




查看任意节点链接的节点数
`tail -f nodes/127.0.0.1/node0/log/log*  | grep connected`






查看共识状态
`tail -f nodes/127.0.0.1/node0/log/log*  | grep +++`






>其他详细操作可参照官方文档[搭建第一个区块链网络](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/installation.html)
>

* * *

### **Docker安装与配置**
>官方安装文档[https://docs.docker.com/engine/install/centos/](https://docs.docker.com/engine/install/centos/)

为提高部署的成功率，这里需要配置Docker的镜像源为国内的镜像源。（以中科大的镜像源为例）
###### 修改/创建Docker镜像配置文件
若目录不存在
`mkdir -p /etc/docker`

创建/修改daemon.json配置文件
`vi /etc/docker/daemon.json`

配置内容如下：
```
{
"registry-mirrors": ["https://docker.mirrors.ustc.edu.cn"]
}
```
###### 重新加载配置文件，重启docker服务
`systemctl daemon-reload`
`systemctl restart docker.service`


* * *

### **启动WeBASE-Front服务**

###### 拉取WeBASE-Front镜像
`docker pull webasepro/webase-front:latest`


###### 查看镜像
`docker images`





###### 运行容器
`docker run -it --net=host --name webase-front -v /root/fisco/nodes/127.0.0.1/sdk:/dist/sdk webasepro/webase-front:latest`



 
######  查看容器运行状况
`docker  ps `





* * *

### **验证WeBASE-Front服务**
 webasepro/webase-front容器正常运行后可以通过浏览器访问WeBASE-Front。
 在浏览器输入
`http://宿主机ip:5002/WeBASE-Front`
正常情况可以访问到WeBASE-Front界面。



 

* * *


 
###  **可能会遇到的错误**
**报错提示**：cannot stat '/dist/sdk/*':No such file or directory


原因：**WeBASE-Front服务通过sdk与节点建立链接**，所以在运行webasepro/webase-front容器时需要**对sdk文件进行挂载**。

在这里我们**指定容器网络模式**：**host**
这样容器将不会虚拟出自己的网卡，配置自己的 IP 等，而是**使用宿主机的 IP 和端口**。

###### sdk路径一般都在/fisco/nodes/127.0.0.1/sdk 

正确启动命令：
`docker run -it --net=host --name webase-front -v /root/fisco/nodes/127.0.0.1/sdk:/dist/sdk webasepro/webase-front:latest`

* * *

### **参考**：
1.[搭建第一个区块链网络](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/installation.html
)


2.[节点前置服务](https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE-Front/index.html
)


3.[front镜像模式使用说明](https://gitee.com/WeBank/WeBASE-Docker/blob/dev-deploy/docker/front-install.md#front%E9%95%9C%E5%83%8F%E6%A8%A1%E5%BC%8F%E4%BD%BF%E7%94%A8%E8%AF%B4%E6%98%8E)


4.[Docker端口映射](https://www.docker.org.cn/dockerppt/110.html)


5.[Docker网络配置](https://www.docker.org.cn/dockerppt/110.html)
