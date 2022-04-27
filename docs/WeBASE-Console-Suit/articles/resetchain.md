# 区块链教程 | 如何重置区块链所有节点数据，并重置WeBASE的链上数据

作者：赖泽沐

# 前言

本文是基于FISCO BCOS 2.8.0版本，在不重新搭链的情况下用于重置所有节点数据及WeBASE的链上数据（WeBASE管理平台自身存储的数据不重置）


# 环境准备
- 区块链搭建：https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/installation.html
- WeBASE版本及兼容：https://webasedoc.readthedocs.io/zh_CN/latest/docs/WeBASE/ChangeLOG.html


# 1、重置区块链所有节点数据

本节用于重置区块链的所有节点数据，使各节点回到第0个块高。

```eval_rst
.. important::
    -  本文使用CentOS7环境4节点服务。
    -  生产环境下注意做好数据备份。
```


## 第一步：停止区块链所有节点服务

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
    -  生产环境下注意做好数据备份。
```

## 通过WeBASE管理平台删除WeBASE的链上数据

登录WeBASE管理平台，选择群组管理，删除群组数据
![image](https://user-images.githubusercontent.com/81018072/163778388-f975e55c-c56e-44f1-9500-dc9749b3dcd2.png)
![image](https://user-images.githubusercontent.com/81018072/164955578-9cadae7d-fcc6-44d6-b43a-6cab8e323b35.png)
![image](https://user-images.githubusercontent.com/81018072/164955577-97af4538-ebcf-45e6-a144-fa6494e418df.png)


## 总结
至此，区块链的数据全部清空，块高回到0。请注意：删除数据前做好数据备份。


