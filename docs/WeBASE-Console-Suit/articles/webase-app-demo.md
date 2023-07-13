# webase-app-demo

> WeBASE应用管理接入Demo,项目示例使用docker运行

代码示例： https://github.com/idefa/webase-app-demo

## 测试运行
```bash
docker-compose up -d
docker-compose ps
```
![avatar](https://github.com/idefa/webase-app-demo/blob/main/img/0.png)

## 网络环境
由于是一台机器上运行，使用制定网络和ip的方式
```bash
docker network create -d bridge --subnet=172.25.0.0/16 --gateway=172.25.0.1 web_network
```
## 1.建链
节点分别为  172.25.0.2，172.25.0.3，172.25.0.4
```bash
bash build_chain.sh -l 172.25.0.2:1,172.25.0.3:1,172.25.0.4:1 -p 30300,20200,8545
```
### 查看状态
tail -f fisco/nodes/172.25.0.2/node0/log/log*  | grep connected
tail -f fisco/nodes/172.25.0.2/node0/log/log*  | grep +++


## 2.搭建Webase
webase也使用官方镜像来运行并挂载证书文件，webase第一次初始化较慢，需等待。

webase访问地址：http://localhost:5000

## 3.创建应用
![avatar](https://github.com/idefa/webase-app-demo/blob/main/img/1.png)
![avatar](https://github.com/idefa/webase-app-demo/blob/main/img/2.png)
![avatar](https://github.com/idefa/webase-app-demo/blob/main/img/3.png)





