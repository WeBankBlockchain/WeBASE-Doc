# MAC系统部署WeBASE各个子系统教程详解

- 作者：江会文

- github：https://github.com/Jay1213811

  

#### 本文主要分为三章节来讲解：

1. 搭建联盟链
2. 搭建节点前置服务
3. 搭建WeBASE管理平台



## 1.基于FISCO搭建联盟链

**第一步：构建一条FISCO BCOS的链**

1.创建一个文件夹 以后就是基于这个文件夹进行的操作

```bash
mkdir fisco
```
2.
安装centos依赖

```bash
curl -LO https://github.com/FISCO-BCOS/FISCO-BCOS/releases/download/`curl -s https://api.github.com/repos/FISCO-BCOS/FISCO-BCOS/releases | grep "\"v2\.[0-9]\.[0-9]\"" | sort -u | tail -n 1 | cut -d \" -f 4`/build_chain.sh && chmod u+x build_chain.sh
```
这时候运行ls查看当前目录下文件我们会发现多了一个`build_chain.sh`

3搭建单群组4节点联盟链

```bash
bash build_chain.sh -l "127.0.0.1:4" -p 30300,20200,8545
```

命令执行成功会输出All completed。如果执行出错，请检查nodes/build.log文件中的错误信息
4.启动所有节点

```bash
bash nodes/127.0.0.1/start_all.sh
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/20201113173338804.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQxNTY5NTkx,size_16,color_FFFFFF,t_70#pic_center)
5执行下面指令，检查是否在共识

```bash
tail -f nodes/127.0.0.1/node0/log/log* | grep +++
```
正常情况会不停输出++++Generating seal，表示共识正常。

**第二步：安装一个交互式控制台**

在fisco目录下执行1234
1.
```bash
bash <(curl -s https://raw.githubusercontent.com/FISCO-BCOS/console/master/tools/download_console.sh)
```
2.

```bash
 cp -n console/conf/applicationContext-sample.xml console/conf/applicationContext.xml
```
3.

```bash
cp nodes/127.0.0.1/sdk/* console/conf/
```
4.启动控制台

```bash
cd console && ./start.sh
```
成功后会出现这个
![在这里插入图片描述](https://img-blog.csdnimg.cn/2020111317372941.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQxNTY5NTkx,size_16,color_FFFFFF,t_70#pic_center)

> 此时，你已经进入控制台界面，可以通过help查看命令列表，通过getPeers获取节点连接列表，通过exit或quit命令退出控制台。
>
> 
>
> 同时，控制台内置了一个HelloWorld合约，可以直接调用deploy HelloWorld进行部署，然后调用call
> HelloWorld进行访问。

首先部署合约
```bash
deploy HelloWorld
```
我们可以得到两个值一个交易哈希值，和合约地址
![在这里插入图片描述](https://img-blog.csdnimg.cn/20201113174136507.png#pic_center)
合约包含两个方法set和get方法。调用合约方法使用

```bash
call HelloWorld contractaddress 方法名
```
如我们使用get方法
```bash
call HelloWorld 0x65fba847909e119c04245fbc8feff5891cacc319 get
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/20201113174326845.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQxNTY5NTkx,size_16,color_FFFFFF,t_70#pic_center)
我们自己set一个方法，再调用get得到我们set的值
set方法
```bash
call HelloWorld 0x65fba847909e119c04245fbc8feff5891cacc319 set "Hello FISCO"
```
get方法
```bash
call HelloWorld 0x65fba847909e119c04245fbc8feff5891cacc319 get
```

![在这里插入图片描述](https://img-blog.csdnimg.cn/20201113174445483.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQxNTY5NTkx,size_16,color_FFFFFF,t_70#pic_center)

​	至此，我们完成了基于Fisco-Bcos搭建一条单群组四节点的联盟链，并在链上完成了简单的数据操作。但是这些控制都是在控制台进行的，对于节点的管理以及出块数据的查看可视性较差。我们将通过第二节和第三节的内容讲解如何基于WeBase更好的操作我们搭建的联盟链。

### 2.节点前置服务(WeBASE-Front)搭建

## 首先你应该完成节点的搭建。可参考之前写的一篇博客
[单群租4节点联盟链的搭建](https://editor.csdn.net/md/?articleId=109621033)
第一个坑就是java版本 ，安装默认Java版本(Java 8或以上)

```bash
sudo apt install -y default-jdk
```
配置Java环境，编辑`/etc/profile`文件

```bash
# java environment
export JAVA_HOME=/usr/java/jdk1.8.0_262（换成你自己的地址）
export CLASSPATH=.:${JAVA_HOME}/jre/lib/rt.jar:${JAVA_HOME}/lib/dt.jar:${JAVA_HOME}/lib/tools.jar
export PATH=$PATH:${JAVA_HOME}/bin
```
关于如何查询JAVA_HOME

```bash
which java # 返回路径
ls -l 返回的路径 # 会再返回一个新的途径
ls -l 新的路径 # 返回最终的路径
```
生效

```bash
source /etc/profile
```
查询java_home是否修改成功，如果前面生效不成功，java_home就不会生效

```bash
echo $JAVA_HOME
```

## Webase 平台的搭建

```bash
cd ~
wget https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/WeBASE/releases/download/v1.4.1/webase-front.zip
unzip webase-front.zip
cd webase-front
```

## copy证书

将节点所在目录nodes/${ip}/sdk下的ca.crt、node.crt和node.key文件拷贝到conf下
可以直接用命令拷贝

```bash
sudo cp  fisco/nodes/127.0.0.1/sdk/ca.crt webase-front/conf/
```
最后启动we-base

```bash
bash start.sh
```
打开浏览器`http://127.0.0.1:5002/WeBASE-Front/#/home`

![在这里插入图片描述](https://img-blog.csdnimg.cn/20201128153338192.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQxNTY5NTkx,size_16,color_FFFFFF,t_70)

我们可以看到我们搭建的节点数量以及交易的数量，并且可以进行合约操作管理。

# 3.WeBASE一键部署

一键部署可以在 同机 快速搭建WeBASE管理台环境，方便用户快速体验WeBASE管理平台。

一键部署会搭建：节点（FISCO-BCOS 2.0+）、管理平台（WeBASE-Web）、节点管理子系统（WeBASE-Node-Manager）、节点前置子系统（WeBASE-Front）、签名服务（WeBASE-Sign）。其中，节点的搭建是可选的，可以通过配置来选择使用已有链或者搭建新链。一键部署架构如下：

#### 一 前提条件：

​	

| 环境    | 版本                |
| ------- | ------------------- |
| Java    | JDK8或以上版本      |
| MySQL   | MySQL-5.6或以上版本 |
| Python  | Python3.4+          |
| PyMySQL | 使用python3时需安装 |

##### 1、下载安装包

```
wget https://www.fisco.com.cn/cdn/webase/releases/download/v1.3.1/webase-front.zip
```

##### 2、解压

```
unzip webase-front.zip
cd webase-front
```

##### 3、拷贝sdk证书文件（build_chain的时候生成的）

将节点所在目录`/root/fisco/nodes/127.0.0.1/sdk`下的`ca.crt`、`node.crt`和node.key文件拷贝到`/root/webase-front/conf`下

##### 4、服务起停

启动： `bash start.sh`
停止： `bash stop.sh`
检查： `bash status.sh`

#### 二 修改配置

```js
vim common.properties
```

Ps：一键部署支持使用已有链或者搭建新链。服务端口不能小于1024。

通过参数”if.exist.fisco”配置是否使用已有链，以下配置二选一即可：

```
当配置”yes”时，需配置已有链的路径
当配置”no”时，需配置节点fisco版本和节点安装个数，搭建的新链默认两个群组
```

#### 三 启动服务

```python
python3 deploy.py installAll
```

