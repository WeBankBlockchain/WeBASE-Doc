# 区块链教程 | 如何重置区块链所有节点数据，并重置WeBASE的链上数据

作者：赖泽沐

# 前言

本文是基于FISCO BCOS 2.8.0版本，在不重新搭链的情况下用于重置所有节点数据及WeBASE的链上数据（WeBASE管理平台自身存储的数据不重置）


# 环境准备
- 区块链搭建
https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/installation.html
- WeBASE版本及兼容：https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE/ChangeLOG.html


# 1、重置区块链所有节点数据

本节用于重置区块链的所有节点数据，使各节点回到第0个块高。

```eval_rst
.. important::
    -  本文使用CentOS7环境4节点服务。
    -  生成环境下注意做好数据备份。
```


## 第一步：停止区块链所有节点的服务

```bash
bash nodes/127.0.0.1/stop_all.sh
```
## 第二步：删除各个节点的数据
```bash
rm -rf nodes/127.0.0.1/node0/data/
rm -rf nodes/127.0.0.1/node1/data/
rm -rf nodes/127.0.0.1/node3/data/
rm -rf nodes/127.0.0.1/node4/data/
```
## 第三步：启动区块链所有节点服务
```bash
bash nodes/127.0.0.1/start_all.sh
```
## 第四步：检查日志输出
```bash
tail -f nodes/127.0.0.1/node0/log/log*  | grep connected
```
正常情况会不停地输出连接信息，从输出可以看出node0与另外3个节点有连接。
```bash
info|2022-04-15 16:00:26.088880|[P2P][Service] heartBeat,connected count=3
info|2022-04-15 16:00:36.088981|[P2P][Service] heartBeat,connected count=3
info|2022-04-15 16:00:46.089136|[P2P][Service] heartBeat,connected count=3
```

# 2、重置WeBASE的链上数据

本节用于重置WeBASE的链上数据，使WeBASE管理平台的看到链数据及块高为0。

```eval_rst
.. important::
    -  本文使用CentOS7环境WeBASE1.5.4版本。
    -  生成环境下注意做好数据备份。
```

## 第一步：登录节点管理服务的mysql数据库

```bash
#登录MySQL:
mysql -u ${your_db_account} -p${your_db_password}  例如：mysql -u root -p123456
```
##  第二步：通过命令删除WeBASE平台上的链数据

```bash
MariaDB [(none)]> show databases；                         //查看数据库
MariaDB [(none)]> use webasenodemanager；                  //切换到节点管理服务数据库
MariaDB [webasenodemanager]> delete from tb_trans_hash_1;  //删除群组1的交易数据
MariaDB [webasenodemanager]> delete from tb_block_1;	   //删除群组1的块数据
```
