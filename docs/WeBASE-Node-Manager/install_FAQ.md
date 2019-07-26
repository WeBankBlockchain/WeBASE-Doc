## 常见问题解答

### 一般问题
* 问：执行shell脚本报下面错误：
```
[app@VM_96_107_centos deployInputParam]$ bash start.sh
start.sh: line 2: $'\r': command not found
start.sh: line 8: $'\r': command not found
start.sh: line 9: $'\r': command not found
start.sh: line 10: $'\r': command not found
```
答：这是编码问题，在脚本的目录下执行转码命令：
```shell
dos2unix *.sh
```


### 数据库问题
* 问：执行数据库初始化脚本抛出异常：
```
ERROR 2003 (HY000): Can't connect to MySQL server on '127.0.0.1' (110)
```
答：MySQL没有开通该帐号的远程访问权限，登录MySQL，执行如下命令，其中TestUser改为你的帐号
```
GRANT ALL PRIVILEGES ON *.* TO 'TestUser'@'%' IDENTIFIED BY '此处为TestUser的密码’' WITH GRANT OPTION;
```


### 服务搭建问题
* 问：执行构建命令`gradle build -x test`抛出异常：
```
A problem occurred evaluating root project 'WeBASE-Node-Manager'.
Could not find method compileOnly() for arguments [[org.projectlombok:lombok:1.18.2]] on root project 'WeBASE-Node-Manager'.
```
答：
方法1、已安装的Gradle版本过低，升级Gradle版本到4.10以上即可。
方法2、直接使用命令：`./gradlew build -x test`


* 问：服务能正常运行，但调用获取验证码接口就报错，然后服务就停止：
```
symbol lookup error: /lib64/libfontconfig.so.1: undefined symbol: FT_Get_Advances
```
答：
1、尽量选择【[sunJDK](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)】，而不是openJDK（有些服务器受有影响）
2、检查jdk的位数是否跟当前系统支持的一致。
3、安装gcc和gcc-c++

```
yum -y install gcc
yum -y install gcc-c++
```

* 问：服务报错：
```
  -bash: /opt/java/jdk1.8.0_211/bin/java: /lib/ld-linux.so.2: bad ELF interpreter: No such file or directory
```
答：安装libgcc.i686：
```
yum install libgcc.i686 --setopt=protected_multilib=false
```

* 问：集群环境下，成功的登录，但登录状态无效：

答：更改nginx服务配置文件，加上ip_hash,如：

```
 upstream /mgr { 
                server localhost:80; 
                server 127.0.0.1:80;
                ip_hash;
       }
```