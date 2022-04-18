深职 麦立健

### 前置准备：
    1.docker 安装：
    bash <(curl -s -L get.docker.com)
### 添加用户组：
### 将当前用户添加到docker用户组
    sudo usermod -aG docker $USER
### 重启docker服务
    sudo systemctl restart docker
    docker --version
### 配置Docker国内镜像源
    mkdir -p /etc/docker
### 创建/修改daemon.json配置文件
    sudo gedit /etc/docker/daemon.json
### 配置内容如下：
	{
    "注册表镜像": ["https://docker.mirrors.ustc.edu.cn"]
    }
### 重启服务
    systemctl daemon-reload
    systemctl restart docker.service
   ![dokcer安装](https://user-images.githubusercontent.com/102428352/163823173-96781d47-188e-41a1-bbb4-ff121bdaf9a9.jpg)





## docker-compose：
    sudo curl -L “https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$（uname -s）-$（uname -m）” -o /usr/local/bin/docker-compose
### 由于GitHub可能获取访问不了，可以用下面这条
    sudo curl -L “https://get.daocloud.io/docker/compose/releases/download/1.29.2/docker-compose-$（uname -s）-$（uname -m）” -o /usr/local/bin/docker-compose
### 修改权限
    sudo chmod +x /usr/local/bin/docker-compose
### 检查
    docker-compose --version

# 3.安装python和pymysql（此处采用fisco官网提供命令，Ubuntu20.4上的版本自带的python都是3.8，所以可忽略安装，直接安装pip）
### 添加仓库，回车继续
    sudo add-apt-repository ppa:deadsnakes/ppa
### 安装python 3.6
    sudo apt-get install -y python3.6
    sudo apt-get install -y python3-pip
    sudo pip3 install PyMySQL

# 4.安装Java
    sudo apt install -y default-jdk
    #配置环境变量
    sudo gedit /etc/profile
    export JAVA_HOME=/etc/java-11-openjdk（因个人版本和位置而异）
    export PATH = $JAVA_HOME/bin:$PATH
    source /etc/profile
# ！！！mysql最好下载5.7，不要下载8.0的，apt自动下载的是8.0会导致后期连接不上
# 5.安装 这里使用的是docker镜像方便管理
    docker search mysql
    docker pull mysql:5.7
    docker run -p 3306:3306 --name mysql57 -v $PWD/conf:/etc/mysql/conf.d -v $PWD/logs:/logs -v $PWD/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -d mysql:5.7
    sudo docker ps -a
    #查看mysql容器
    sudo docker ps -a
    docker start  [对应mysql的containerID]
    docker exec -it (mysql的id) bash
    mysql -uroot -p123456
    create database webasenodemanager;

# 6 开放5000和5002端口
    sudo apt-get install iptables-persistent
    sudo iptables -I INPUT -p tcp --dport 5000 -j ACCEPT
    sudo iptables -I INPUT -p tcp --dport 5002 -j ACCEPT
# 安装iptables-persistent后 开放端口需要root权限

# 7 拉取部署脚本
	wget https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/WeBASE/releases/download/v1.5.4/webase-deploy.zip
	#解压
	unzip webase-deploy.zip
### 进入目录
    cd webase-deploy

# !!!最重要的一步！！！
    sudo gedit common.properties
    #Mysql database configuration of WeBASE-Node-Manager）下的mysql.user=，mysql.password= 修改为配置mysql时的账户密码
    #这里由于先前没有设置，我采用的是root和默认密码
## WeBASE-Sign（同上） 的 Mysql 数据库配置
    在第74行按照自身情况选课yes，no选no就可以直接保存退出，选yes则需要配置fisco.dir和node0.dir
   ![5520cf6b4dfeaecdae228ed44d6b946](https://user-images.githubusercontent.com/102428352/163822926-a2661753-2815-4f78-865e-cca6c1f2ec8b.png)


###	拉取镜像
    python3 deploy.py pullDockerAll
### 超时可手动拉取
    docker pull webasepro/webase-front:v1.5.3
    docker pull webasepro/webase-node-mgr:v1.5.3
    docker pull webasepro/webase-sign:v1.5.3
    docker pull webasepro/webase-web:v1.5.3
    docker pull fiscoorg/fiscobcos:v2.8.0

# 最后运行
    python3 deploy.py 安装全部
    #成功后便可以直接登录了
    http://localhost:5000
    http://127.0.0.1:5000
    默认账户密码：
    管理员 Abcd1234
   ![11db53d83cdd075fcf2b61e5392cacc](https://user-images.githubusercontent.com/102428352/163823009-7d628f2d-d729-41a0-b60c-aa27394b1178.png)



