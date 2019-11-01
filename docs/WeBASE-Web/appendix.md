## 附录
### 1 安装nginx
#### 1.1 下载nginx依赖
在安装nginx前首先要确认系统中安装了gcc、pcre-devel、zlib-devel、openssl-devel。如果没有，请执行命令

	yum -y install gcc pcre-devel zlib-devel openssl openssl-devel
执行命令时注意权限问题，如遇到，请加上sudo
#### 1.2 下载nginx
nginx下载地址：https://nginx.org/download/（下载最新稳定版本即可）
或者使用命令：

	wget http://nginx.org/download/nginx-1.9.9.tar.gz  (版本号可换)
将下载的包移动到/usr/local/下
#### 1.3 安装nginx
##### 1.3.1 解压
	tar -zxvf nginx-1.9.9.tar.gz

##### 1.3.2 进入nginx目录

	cd nginx-1.9.9
##### 1.3.3 配置

	./configure --prefix=/usr/local/nginx

##### 1.3.4 make

	make
	make install
##### 1.3.5 测试是否安装成功
使用命令：

	/usr/local/nginx/sbin/nginx –t
正常情况的信息输出：

	nginx: the configuration file /usr/local/nginx/conf/nginx.conf syntax is ok
	nginx: configuration file /usr/local/nginx/conf/nginx.conf test is successful

##### 1.3.6 nginx几个常见命令
```shell
/usr/local/nginx/sbin/nginx -s reload            # 重新载入配置文件
/usr/local/nginx/sbin/nginx -s reopen            # 重启 Nginx
/usr/local/nginx/sbin/nginx -s stop              # 停止 Nginx
ps -ef | grep nginx                              # 查看nginx进程
```


### 2 常见问题
#### 2.1 出现“登录错误”怎么排查问题
登录时出现“登录错误”，请一一排查：
 1. WeBASE-Node-Manager服务是否启动成功，
 2. WeBASE-Node-Manager的数据库是否正常，
 3. nginx代理是否存在错误。
    
#### 2.2 为什么输入正确的验证码显示验证码错误
登录验证码有效时间为五分钟，五分钟后验证码失效，登录会出现“验证码错误” 。

#### 2.3 交易解码解不出来
将发送该交易的合约上传到合约管理，并编译。

#### 2.4 交易审计异常交易和异常合约怎么消除
将发送交易的账户在私钥管理中添加成公钥用户，那么该用户所发的交易将审计成正常交易；
将部署该合约的账户在私钥管理中添加成公钥用户，那么该用户所部署的合约将审计成正常合约。

### 3. 二次开发
[开发文档](./development.html)
