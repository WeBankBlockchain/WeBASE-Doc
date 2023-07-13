#!/bin/bash
####################################
#	作者:  深职院-zyh          #
# 	作用:  FISCO BCOS环境提供  # 
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
