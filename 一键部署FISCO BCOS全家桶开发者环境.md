# 张宇豪 | 一键部署FISCO BCOS开发者环境

> 作者：张宇豪
> 学校：深圳职业技术大学

## 前言

在此使用脚本之前，需要了解什么是Shell编程语言，什么是Shell脚本。

1. Shell自动化脚本是一种用Shell编写的程序，可以在Unix或类Unix操作系统上运行。它们通常被用于执行重复性、繁琐或时间-consuming的任务，如文件操作、系统配置和软件安装等。
2. 这些脚本可以包含控制结构、变量、函数和命令等元素，以执行特定的任务。例如，一个Shell自动化脚本可以用来自动备份数据库、定期清理日志文件、创建用户账户等。
3. 由于Shell自动化脚本易于编写和修改，因此它们是许多系统管理员、开发人员和DevOps工程师的首选工具。它们也可以与其他自动化工具、版本控制系统和云平台集成，使整个自动化过程更加高效。



本案例目标：

- 学习如何编写Shell脚本
- 理解脚本的基本语法和逻辑结构
- 通过Shell脚本大大简化平时的工作流程，比如我不想老是重复部署WeBAE或者是其他平台，可以用到以下脚本
- 脚本环境涵盖基本的FISCO BCOS建链、WeBASE一键部署的环境、压力测试的环境。



## 1.开发者环境详细

### 1.1.适配环境

| 运行环境       | Ubuntu 20.04 |
| -------------- | ------------ |
| OpenssL 版本   | 1.1.1f       |
| FISCO BCOS版本 | 2.8/3.1      |



### 1.2.环境准备

只需要安装好一台全新的Ubuntu 20.04的环境。

![image-20230402122348641](https://blog-1304715799.cos.ap-nanjing.myqcloud.com/imgs/202304021223810.webp)





### 1.3.环境介绍

脚本部署完毕之后，会输出相关主机以及服务配置信息。需要联网部署，我没有切换apt源，因为试过更换了阿里和网易的，安装完环境之后，会更新一些包，会出现Authentication error。

**编写脚本的用途：**

1. 初学者和开发者在每次使用Ubuntu 20.04稳定新版搭建FISCO BCOS后，多次使用环境错乱或者虚拟机崩溃，需要重新搭建，太繁琐了，为此该脚本可以解决如上问题。
2. 对于长时间接触智能合约开发的小伙伴，不想每次都繁琐的搭建环境，也可以使用该脚本。
3. 对于只需要WeBASE-Front中间件和需要一键部署WeBASE环境的同学非常友好。目前支持FISCO BCOS2.8和3.1两个版本环境部署。
4. 也非常适合初学者对FISCO BCOS脱离网络环境在工作目录下利用离线包学习。

**环境服务详细：**

- [x] 配置了默认Java JDK 11的环境
- [x] 配置了MySQL 8服务，默认无密码
- [x] 配置了常用的网络工具以及Git
- [x] 添加了Python3-pip的依赖
- [x] 添加了Docker容器环境以及docker-compose工具，使用了阿里源加速
- [x] 添加了NVM工具，方便切换Node版本
- [x] 添加了Remix的容器运行环境，默认8080端口访问
- [x] 使用工作目录拉取离线包以后扩展脚本
- [x] 提供FISCO BCOS2.8的所有离线部署资源包
- [x] 提供FISCO BCOS3.1的所有离线部署资源包



### 1.4.脚本详细

- 我这里没有进行换源，是因为更换源之后安装完后会出现软件不兼容。

```shell
####################################
#       作者:  CN-ZHANG             #
#       作用:  FISCO BCOS环境提供    #
####################################


install_depall(){
        # 关闭防火墙
        ufw disable  && systemctl stop --now ufw.service

        # 更新当前的数据源
        apt-get update

        # 安装SSH
        apt install -y openssh-server && systemctl restart sshd

        # 安装基本的Java依赖环境
        apt install -y default-jdk

        # 配置Java的开发环境
        echo '''export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64''' >> ~/.bashrc
        echo '''export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64''' >> /etc/profile
        source ~/.bashrc
        source /etc/profile

        # 安装MySQL8和常用的工具
        apt install -y  mysql-server \
                        curl wget git net-tools \
                        unzip python3-pip
                        pip3 install pyMySQL
        # 查看当前的基础环境工具版本
        java_version=`java --version  | grep  openjdk`
        openssl_version=`openssl version`
        git_version=`git version`
        mysql_version=`mysql --version`
        echo -e "\033[32m
        =====================😋 ✔✔✔ 所有环境版本详细 ======================
           Java的开发环境版本:
           $java_version
           OpenSSL的工具环境版本:
           $openssl_version
           Git工具的环境版本:
           $git_version
           MySQL工具的环境版本:
           $mysql_version
        =================================================================
        \033[0m"
}

install_docker(){
    # 安装依赖包
    sudo apt-get install  -y \
            apt-transport-https \
            ca-certificates \
            curl \
            gnupg-agent \
            software-properties-common

    # 添加Docker官方GPG key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    # 添加docker仓库
    sudo add-apt-repository -y \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

    # 更新包索引
    sudo apt-get update

    # 安装Docker
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose
        systemctl restart docker
        if [ ! -d "/etc/docker/" ];then
                mkdir /etc/docker/
        else
                echo -e "\033[32m🥵 ✔✔✔ 当前目录已存在\033[0m"
        fi
        echo '''
        {
                "registry-mirrors": ["https://ably8t50.mirror.aliyuncs.com"]
        }
                ''' > /etc/docker/daemon.json
        systemctl daemon-reload
        systemctl restart docker && systemctl enable docker

}

install_nvm(){
        # 拉取安装包
        cd ~/ && curl -#LO https://gitee.com/mirrors/nvm/raw/v0.33.2/install.sh && chmod +x install.sh && sh install.sh
        # nvm淘宝镜像
        echo '''export NVM_NODEJS_ORG_MIRROR=http://npm.taobao.org/mirrors/node''' >> ~/.bashrc
        echo '''export NVM_NODEJS_ORG_MIRROR=http://npm.taobao.org/mirrors/node''' >> /etc/profile
        sleep 3
        # 重新加载配置文件
        source ~/.bashrc
        source /etc/profile
        # 安装Node.js 8
        nvm install 8
        # 使用Node.js 8
        nvm use 8
        rm -rf install.sh
}

install_fisco_bcos_28(){
    echo -e "\033[32m🥵 ✔✔✔ 检测完成当前的环境\033[0m"
        # 创建一个工作目录
        if [ ! -d "/root/fisco/" ];then
                mkdir ~/fisco
        else
                echo -e "\033[32m🥵 ✔✔✔ 当前目录已存在正在备份中...\033[0m"
                mv ~/fisco  ~/fiscobak
                mkdir ~/fisco
        fi
        # 拉取FISCO BCOS 2.8的离线包
        cd ~/fisco && curl -#LO https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/FISCO-BCOS/FISCO-BCOS/releases/v2.8.0/build_chain.sh && chmod u+x build_chain.sh > /dev/null
        cd ~/fisco && curl -#LO https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/FISCO-BCOS/console/releases/v2.8.0/console.tar.gz > /dev/null
        cd ~/fisco && curl -#LO https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/FISCO-BCOS/FISCO-BCOS/releases/v2.8.0/fisco-bcos.tar.gz && tar zxvf fisco-bcos.tar.gz > /dev/null
        cd ~/fisco && curl -#LO https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/FISCO-BCOS/FISCO-BCOS/tools/get_account.sh && chmod u+x get_account.sh > /dev/null
        cd ~/fisco && curl -#LO https://gitee.com/FISCO-BCOS/FISCO-BCOS/raw/master-2.0/tools/gen_node_cert.sh > /dev/null
        # 拉取WeBASE的离线包
        cd ~/fisco && curl -#LO https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/WeBASE/releases/download/v1.5.4/webase-front.zip > /dev/null
    cd ~/fisco && curl -#LO https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/WeBASE/releases/download/v1.5.4/webase-deploy.zip > /dev/null
}

install_fisco_bcos_30(){
    echo -e "\033[32m🥵 ✔✔✔ 检测完成当前的环境\033[0m"
        # 创建一个工作目录
        if [ ! -d "/root/fisco/" ];then
                mkdir ~/fisco
        else
                echo -e "\033[32m🥵 ✔✔✔ 当前目录已存在正在备份中...\033[0m"
                mv ~/fisco  ~/fiscobak
                mkdir ~/fisco
        fi
        # 拉取FISCO BCOS 3.1的离线包
    cd ~/fisco && curl -#LO https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/FISCO-BCOS/FISCO-BCOS/releases/v3.1.0/build_chain.sh && chmod u+x build_chain.sh > /dev/null
    cd ~/fisco && curl -#LO https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/FISCO-BCOS/FISCO-BCOS/releases/v3.1.0/BcosBuilder.tgz > /dev/null
    cd ~/fisco && curl -#LO https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/FISCO-BCOS/FISCO-BCOS/tools/get_account.sh && chmod u+x get_account.sh > /dev/null
    cd ~/fisco && curl -#LO https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/FISCO-BCOS/FISCO-BCOS/tools/get_gm_account.sh && chmod u+x get_gm_account.sh > /dev/null
    cd ~/fisco && curl -#LO https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/FISCO-BCOS/console/releases/v3.1.0/console.tar.gz > /dev/null
    cd ~/fisco && curl -#LO https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/FISCO-BCOS/FISCO-BCOS/releases/v3.1.0/fisco-bcos.tar.gz && tar zxvf fisco-bcos.tar.gz  > /dev/null
        # 拉取WeBASE的离线包
    cd ~/fisco && curl -#LO https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/WeBASE/releases/download/v1.5.4/webase-front.zip > /dev/null
    cd ~/fisco && curl -#LO https://osp-1257653870.cos.ap-guangzhou.myqcloud.com/WeBASE/releases/download/v1.5.4/webase-deploy.zip > /dev/null
}

install_remixed(){
        docker pull remixproject/remix-ide:latest
        sleep 5
        docker run -d -p 8080:80 \
        --name remix \
        --restart=always \
        remixproject/remix-ide:latest
        sleep 3
}

start_4fisco(){
        cd ~/fisco && bash build_chain.sh -l 127.0.0.1:4 -p 30300,20200,8545 -e ./fisco-bcos && \
        tar zxvf console.tar.gz && \
        unzip webase-front.zip && \
        bash nodes/127.0.0.1/start_all.sh && \
        cp console/conf/config-example.toml console/conf/config.toml && \
        cp nodes/127.0.0.1/sdk/* console/conf/ && \
        cp nodes/127.0.0.1/sdk/*  webase-front/conf/
        cd ~/fisco/webase-front/ && bash start.sh

}

echo_all_info(){
    echo -e "\033[32m=========================================\033[0m"
    echo -e "\033[32m😋  ✔✔✔ 查看当前的工作目录环境包\033[0m"
    cd /root/fisco && chmod +x *.sh
    files=`ls -ll /root/fisco/ | awk 'NR>1{print $NF}'`
    for i in $files
    do
            echo $i
    done
    # Docker的版本
    docker_version=`docker -v`
    docker_compose_version=`docker-compose -v`
    # 本机IP
    local_ip=`ifconfig -a|grep inet|grep -v 127.0.0.1 | grep -v inet6 | awk 'NR>1{print $2}' | tr -d "addr:"`
    echo -e "\033[32m
                       🔋   基础环境部署完成
    ============================================================
    ✔✔✔  当前的IP地址:  $local_ip
    ✔✔✔  当前的登录用户: root
    ✔✔✔  当前的环境工作目录;  /root/fisco
    ✔✔✔ NVM仓库: http://npm.taobao.org/mirrors/node
    ✔✔✔ Docker仓库:
    {
    "registry-mirrors": ["https://ably8t50.mirror.aliyuncs.com"]
    }
    ✔✔✔ Docker版本: $docker_version
    ✔✔✔ Docker-Compose版本: $docker_compose_version
    ✔✔✔ 在线Remix http://localhost:8080
    ============================================================
    \033[0m"
}

menu(){
        echo -e "\033[32m
        ============================
        1) 部署FISCO BCOS V2.8 环境
        2) 部署FISCO BCOS V3.1 环境
        3) 开启在线Remix
        4) 退出
        5) HELP
        *) 部署环境菜单
        \033[0m"
}
helpInfo(){
        echo -e "\033[32m
        ==================================================
        =                                                =
        =          使用文档 一键部署FISCO环境            =
        =                                                =
        ==================================================

        1. source install_dev_all.sh
        2. chmod +x install_dev_all.sh  &&  .install_dev_all.sh

        description:
                1. 输入1默认部署FISCO BCOS 2.8的环境包
                2. 输入2默认部署FISCO BCOS 3.0的环境包
                3. 输入3退出当前的操作菜单
                4. 输入4查看当前的帮助文档
                5. 输入其他取消操作
        \033[0m"

}

install_init(){
        install_depall
        install_docker
        install_nvm
        install_remixed
}

select_install_fisco(){
        # 判断当前的用户是否为root
        idOfRoot=`id -u`
        if [ $idOfRoot != 0 ];then
                echo -e "\033[32m😴 !!! 当前的用户没有最高权限需要切换Root权限\033[0m"
                        exit
        else
                        while true;do
                                # 调用当前的菜单
                                menu
                                read -p "🚀 ✔✔✔ 请输入你的选项(DEFAULT 1):"  fiscorelease
                                        if [ -z $fiscorelease ];then
                                                        fiscorelease="1"
                                        fi
                                        case $fiscorelease in
                                                1)
                                                        install_init
                                                        install_fisco_bcos_28
                                                        start_4fisco
                                                        echo_all_info
                                                        break
                                                        ;;
                                                2)
                                                        install_init
                                                        install_fisco_bcos_30
                                                        echo_all_info
                                                        break
                                                        ;;
                                                3)
                                                        install_remixed
                                                        echo -e "\033[32m🌌 ✔✔✔ 已开启在线Remix服务\033[0m"
                                                        break
                                                        ;;
                                                4)
                                                        echo -e "\033[32m🌌 ✔✔✔ 当前已经取消操作\033[0m"
                                                        break
                                                        ;;
                                                5)
                                                        helpInfo
                                                        break
                                                        ;;
                                                *)
                                                        menu
                                                        ;;
                                        esac
                        done
        fi

}

# 调用主函数 select_install_fisco
select_install_fisco
```



## 2.快速开始

### 2.1.拉取脚本

```shell
 $ curl -OL https://gitee.com/isKcount/fisco-bcos-utils/raw/master/install_ubuntun_fisco_dep.sh
```



### 2.2.执行脚本

因为脚本包含了source命令，所以需要使用source去执行脚本。

```shell
$ source install_dev_all.sh
```



### 2.3.检查环境

脚本最后执行会提示当前所有的环境信息。

![image-20230402132219893](https://blog-1304715799.cos.ap-nanjing.myqcloud.com/imgs/202304021322240.webp)

```shell
# 当前的Java环境
root@fisco:~/fisco# java -version
openjdk version "11.0.18" 2023-01-17
OpenJDK Runtime Environment (build 11.0.18+10-post-Ubuntu-0ubuntu120.04.1)
OpenJDK 64-Bit Server VM (build 11.0.18+10-post-Ubuntu-0ubuntu120.04.1, mixed mode, sharing)

# 当前的Mysql8
root@fisco:~/fisco# mysql -V
mysql  Ver 8.0.32-0ubuntu0.20.04.2 for Linux on x86_64 ((Ubuntu))

# 当前的Docker环境
root@fisco:~/fisco# docker -v
Docker version 23.0.2, build 569dd73

# 当前的Docker-compose环境
root@fisco:~/fisco# docker-compose -v
docker-compose version 1.25.0, build unknown

# 当前的nvm环境
root@fisco:~/fisco# nvm version
v8.17.0
```



### 2.4.查看在线Remix

![image-20230402132538801](https://blog-1304715799.cos.ap-nanjing.myqcloud.com/imgs/202304021325180.webp)



### 2.5.查看WeBAE-Front

![image-20230402132605919](https://blog-1304715799.cos.ap-nanjing.myqcloud.com/imgs/202304021326233.webp)



### 2.6 视频演示

个人CSDN博客地址： https://blog.csdn.net/weixin_46532941/article/details/129910073?spm=1001.2014.3001.5501

Bilibili： https://www.bilibili.com/video/BV1nX4y1k7Hp/?vd_source=f79953f7d660554328be2b7b8b5eda99

![image-20230402142304841](https://blog-1304715799.cos.ap-nanjing.myqcloud.com/imgs/202304021423430.webp)

